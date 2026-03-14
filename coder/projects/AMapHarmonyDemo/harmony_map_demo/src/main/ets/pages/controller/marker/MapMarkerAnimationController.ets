import {
  AlphaAnimation,
  AMap,
  Animation,
  AnimationSet,
  BitmapDescriptorFactory,
  CameraPosition,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewManager,
  Marker,
  MarkerOptions,
  OnCameraChangeListener,
  OnMarkerDragListener,
  Point,
  ScaleAnimation,
  TranslateAnimation
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';

let globalContext: Context;

/**
 * marker动画相关功能
 */
@Component
export struct MapMarkerAnimationController {
  private mapView?: MapView;
  private aMap?: AMap;
  private aId: number = 0;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private growMarker?: Marker;
  private jumpMarker?: Marker;
  private breatheMarker?: Marker;
  private breatheMarker_center?: Marker;
  private latLng: LatLng = new LatLng(39.761, 116.434);

  onPageShow(): void {
    this.mapView?.onResume();
  }

  onPageHide(): void {
    this.mapView?.onPause();
  }

  pageChange(changedPropertyName: string) {
    if (this.isPageHide === true) {
      this.onPageHide()
    } else {
      this.onPageShow()
    }
  }

  //marker功能
  @Builder
  buildMapMarker() {
    Stack() {
      MapViewComponent({ mapViewName: Constants.MAP_MARKER_ANIMATION_FUNC }).zIndex(0)

      Flex({ wrap: FlexWrap.Wrap }) {
        Button("生长动画")
          .onClick(() => {
            this.addGrowMarker()
          })
        Button("跳动动画")
          .onClick(() => {
            this.addJumpMarker()
          })
        Button("呼吸动画")
          .onClick(() => {
            this.addBreatheMarker()
          })
      }.position({ x: 10, y: 10 })

    }.width('100%')
    .height('100%')
  }

  /**
   * 添加一个从地上生长的Marker
   */
  addGrowMarker() {
    if (this.growMarker == undefined) {
      let markerOptions: MarkerOptions =
        new MarkerOptions().setIcon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_AZURE))
          .setPosition(this.latLng)
          .setTitle("地上生长");
      this.growMarker = this.aMap?.addMarker(markerOptions);
    }
    this.startGrowAnimation();
  }

  /**
   * 地上生长的Marker
   */
  private startGrowAnimation() {
    if (this.growMarker) {
      let animation: Animation = new ScaleAnimation(0, 1, 0, 1);
      const linearCurve: ICurve = { interpolate: (t: number) => t };
      animation.setInterpolator(linearCurve);
      //整个移动所需要的时间
      animation.setDuration(1000);
      //设置动画
      this.growMarker.setAnimation(animation);
      //开始动画
      this.growMarker.startAnimation();
    }
  }

  //在中心屏幕添加一个marker
  addJumpMarker() {
    if (!this.jumpMarker) {
      let latLng: LatLng | undefined = this.aMap?.getCameraPosition()?.target;
      let bitmap = BitmapDescriptorFactory.fromRawfilePathSync(getContext(), "purple_pin.png");
      if (bitmap && latLng) {
        let screenPosition: Point | undefined = this.aMap?.getProjection()?.toScreenLocationSync(latLng);

        this.jumpMarker = this.aMap?.addMarker(new MarkerOptions()
          .setAnchor(0.5, 0.5)
          .setIcon(bitmap));
        //设置Marker在屏幕上,不跟随地图移动
        if (screenPosition) {
          this.jumpMarker?.setPositionByPixels(screenPosition?.x, screenPosition.y);
        }
      }
    }
    this.startJumpAnimation();
  }

  /**
   * 屏幕中心marker 跳动
   */
  startJumpAnimation() {
    if (this.jumpMarker) {
      //根据屏幕距离计算需要移动的目标点
      let latLng: LatLng = this.jumpMarker?.getPosition();
      let point: Point | undefined = this.aMap?.getProjection()?.toScreenLocationSync(latLng);
      if (point) {
        point.y -= vp2px(125);
        let target: LatLng | undefined = this.aMap?.getProjection()?.fromScreenLocationSync(point);
        //使用TranslateAnimation,填写一个需要移动的目标点
        if (target) {
          let animation = new TranslateAnimation(target);
          const interpolator: ICurve = {
            interpolate: (input: number) => {
              // 模拟重加速度的interpolator
              if (input <= 0.5) {
                return (0.5 - 2 * (0.5 - input) * (0.5 - input));
              } else {
                return (0.5 - Math.sqrt((input - 0.5) * (1.5 - input)));
              }
            }
          };
          animation.setInterpolator(interpolator)
          //整个移动所需要的时间
          animation.setDuration(600);
          //设置动画
          this.jumpMarker?.setAnimation(animation);
          //开始动画
          this.jumpMarker?.startAnimation();
        }
      }


    } else {
      console.error("amap", "jumpMarker is null");
    }
  }

  addBreatheMarker() {
    if (!this.breatheMarker) {
      let latLngTemp: LatLng = new LatLng(this.latLng.latitude - 0.02, this.latLng.longitude - 0.02);
      let bitmap = BitmapDescriptorFactory.fromRawfilePathSync(getContext(), "marker_circle_64.png");
      if (bitmap) {
        this.breatheMarker =
          this.aMap?.addMarker(new MarkerOptions().setPosition(latLngTemp).setZIndex(1).setAnchor(0.5, 0.5)
            .setIcon(bitmap))
        // 中心的marker
        this.breatheMarker_center =
          this.aMap?.addMarker(new MarkerOptions().setPosition(latLngTemp).setZIndex(2).setAnchor(0.5, 0.5)
            .setIcon(bitmap))
      }
    }
    this.startBreatheAnimation();
  }

  private breatheHeartbeatTimer: number | undefined;

  startBreatheAnimation() {
    // 如果已经在运行，防止重复启动
    if (this.breatheHeartbeatTimer) {
      return;
    }

    // 创建动画集
    let animationSet: AnimationSet = new AnimationSet(true);

    let alphaAnimation: AlphaAnimation = new AlphaAnimation(0.5, 0);
    alphaAnimation.setDuration(2000);
    alphaAnimation.setRepeatCount(Animation.INFINITE);

    let scaleAnimation: ScaleAnimation = new ScaleAnimation(1, 3.5, 1, 3.5);
    scaleAnimation.setDuration(2000);
    scaleAnimation.setRepeatCount(Animation.INFINITE);

    animationSet.addAnimation(alphaAnimation);
    animationSet.addAnimation(scaleAnimation);
    const linearCurve: ICurve = { interpolate: (t: number) => t };
    animationSet.setInterpolator(linearCurve);

    // 设置并启动动画
    this.breatheMarker?.setAnimation(animationSet);
    this.breatheMarker?.startAnimation(); // SDK 内部会提帧一次

    //启动心跳保活：每 800ms 唤醒一次渲染线程
    this.breatheHeartbeatTimer = setInterval(() => {
      try {
        this.aMap?.runOnDrawFrame?.();
      } catch (e) {
        console.log('[Heartbeat] runOnDrawFrame failed', e);
      }
    }, 800); // 小于动画周期，确保不断连
  }



  private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_MARKER_ANIMATION_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync(async (map) => {
      this.aMap = map;

      hilog.info(0xff, Constants.MAP_MARKER_ANIMATION_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true);
      this.aMap.setOnMarkerDragListener(new OnMarkerDragListener(
        // start
        (marker: Marker) => {
          let position = marker.getPosition();
          hilog.info(0xff, Constants.MAP_MARKER_ANIMATION_FUNC,
            `marker drag start ${marker.getId()} ${marker.getTitle()} ${position.latitude} ${position.longitude}`);
        },
        // drap
        (marker: Marker) => {
          let position = marker.getPosition();
          hilog.info(0xff, Constants.MAP_MARKER_ANIMATION_FUNC,
            `marker drag move ${marker.getId()} ${marker.getTitle()} ${position.latitude} ${position.longitude}`);
        },
        // end
        (marker: Marker) => {
          let position = marker.getPosition();
          hilog.info(0xff, Constants.MAP_MARKER_ANIMATION_FUNC,
            `marker drag end ${marker.getId()} ${marker.getTitle()} ${position.latitude} ${position.longitude}`);
        }

      ));
      // 设置可视范围变化时的回调的接口方法
      this.aMap?.setOnCameraChangeListener(new OnCameraChangeListener(
        (position: CameraPosition) => {
          hilog.info(0xff, Constants.MAP_MARKER_ANIMATION_FUNC,
            `map change ${position.target.longitude} ${position.target.latitude}`);
        },
        (position: CameraPosition) => {
          hilog.info(0xff, Constants.MAP_MARKER_ANIMATION_FUNC,
            `map finish ${position.target.longitude} ${position.target.latitude}`);
          //屏幕中心的Marker跳动
          this.startJumpAnimation();
        }));

    })

  }

  aboutToAppear(): void {
    globalContext = getContext().getApplicationContext();
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
    hilog.info(0xff, Constants.MAP_MARKER_ANIMATION_FUNC, "aboutToAppear");
  }

  aboutToDisappear(): void {
    if (this.mapViewCreateCallback) {
      MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    }

    if (this.mapView) {
      this.mapView.onDestroy();
      this.mapView = undefined;
      this.aMap = undefined;
    }

    hilog.info(0xff, Constants.MAP_MARKER_ANIMATION_FUNC, "aboutToDisappear");
  }

  build() {
    NavDestination() {
      this.buildMapMarker();
    }
    .title(Constants.MAP_MARKER_ANIMATION_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })

  }
}

