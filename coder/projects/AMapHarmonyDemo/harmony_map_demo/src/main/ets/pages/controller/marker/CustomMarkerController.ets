import {
  AMap,
  Animation,
  BitmapDescriptor,
  BitmapDescriptorFactory,
  CameraUpdateFactory,
  LatLng,
  LatLngBounds,
  LatLngBoundsBuilder,
  MapView,
  MapViewComponent,
  MapViewManager,
  Marker,
  MarkerOptions,
  OnMarkerDragListener,
  Point,
  Projection,
  ScaleAnimation,
  TextOptions
} from '@amap/amap_lbs_map3d'
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import ArrayList from '@ohos.util.ArrayList';
import { promptAction } from '@kit.ArkUI';

let globalContext: Context;

/**
 * 自定义marker相关功能
 */
@Preview
@Component
export struct CustomMarkerController {
  private mapView?: MapView;
  private aMap?: AMap;
  private aId: number = 0;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private latLng: LatLng = new LatLng(36.061, 103.834);
  private marker1: Marker | undefined;
  private marker2: Marker | undefined;
  private marker3: Marker | undefined;
  private marker4: Marker | undefined;
  @State markerListenerText: string = "拖动marker1";
  @State infoWindowImageLeft ?: Resource = undefined;
  @State infoWindowTitle: string = ""
  @State infoWindowTitleColor: Color = Color.Black
  @State infoWindowSnippet: string = ""
  @State infoWindowSnippetColor: Color = Color.Gray
  private customType: string = "Radio1"

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

  onChangeInfoWindow(marker: Marker | undefined) {
    //更改图标
    if (this.customType === "Radio2") {
      this.infoWindowImageLeft = $rawfile("badge_sa.png")
    } else if (this.customType === "Radio3") {
      this.infoWindowImageLeft = $rawfile("badge_wa.png")
    }

    let title: string | undefined = marker?.getTitle()
    if (title) {
      this.infoWindowTitle = title
      this.infoWindowTitleColor = Color.Red
    } else {
      this.infoWindowTitle = ""
    }

    let snippet: string | undefined = marker?.getSnippet()
    if (snippet) {
      this.infoWindowSnippet = snippet
      this.infoWindowSnippetColor = Color.Green
    } else {
      this.infoWindowSnippet = ""
    }

  }

  @Builder
  customInfoWindow() {
    Stack() {

      Column() {
        Row() {
          Image(this.infoWindowImageLeft)
            .margin({ left: 5, right: 5 })
            .width(30)
            .height(30)
          Column() {
            Text(this.infoWindowTitle)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.infoWindowTitleColor)
              .fontSize(15)
              .margin({
                top: 10,
                left: 10,
                right: 10
              })

            Text(this.infoWindowSnippet)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.infoWindowSnippetColor)
              .fontSize(20)
              .margin({
                top: 5,
                left: 10,
                right: 10,
                bottom: 10
              })
          }
        }
      }
      .backgroundColor(Color.White)
      .border({
        width: 2,
        color: Color.Black,
        radius: 5

      })
    }
    .padding(5)

  }

  //marker功能
  @Builder
  buildMapMarker() {

    Stack({ alignContent: Alignment.BottomEnd }) {
      MapViewComponent({ mapViewName: Constants.MAP_MARKER_CUSTOM_FUNC }).zIndex(0)
      Text(this.markerListenerText)
        .height(50)
        .width("100%")
        .textAlign(TextAlign.Start)
        .backgroundColor("#D999")
        .position({ x: 0, y: 0 })
        .fontSize(12)
      Flex({ wrap: FlexWrap.Wrap }) {
        Column() {
          Row() {
            Button("clear").onClick(() => {
              this.aMap?.clear()
            })
            Button("reset").onClick(() => {
              this.aMap?.clear()
              this.addMarkersToMap();
              if (this.marker1) {
                this.renderInfoWindow(this.marker1)
              }
              this.setAllMarkerIntoScreen()
            })
          }
          .width("100%")
          .justifyContent(FlexAlign.SpaceEvenly)
          .margin({ top: 10, bottom: 10 })

          Row() {
            Radio({ value: 'Radio1', group: 'radioGroup' })
              .height(25)
              .width(25)
              .checked(true)
              .onChange((isChecked: boolean) => {
                if (isChecked) {
                  this.customType = "Radio1"
                  this.aMap?.setInfoWindowAdapter(undefined)

                }
              })
            Text('Default info window')
          }
          .margin({ top: 10, bottom: 10 })
          .width("100%")

          Row() {
            Radio({ value: 'Radio2', group: 'radioGroup' })
              .height(25)
              .width(25)
              .onChange((isChecked: boolean) => {
                if (isChecked) {
                  this.customType = "Radio2"
                  this.aMap?.setInfoWindowAdapter(() => {
                    this.customInfoWindow()
                  })
                }
              })
            Text('Custom info contents')
          }.width("100%")

          Row() {
            Radio({ value: 'Radio3', group: 'radioGroup' })
              .height(25)
              .width(25)
              .onChange((isChecked: boolean) => {
                if (isChecked) {
                  this.customType = "Radio3"
                  this.aMap?.setInfoWindowAdapter(() => {
                    this.customInfoWindow()
                  })
                }
              })
            Text('Custom info window')
          }
          .margin({ top: 10, bottom: 10 })
          .width("100%")

        }

      }
      .backgroundColor("#D999")
      .width("55%")
    }

  }

  /**
   * 在地图上添加marker
   */
  async addMarkersToMap() {
    // 文字显示标注，可以设置显示内容，位置，字体大小颜色，背景色旋转角度
    let textOptions: TextOptions = new TextOptions()
      .position(Constants.BEIJING)
      .text("Text")
      .fontColor("#000000")
      .backgroundColor("#0000FF")
      .fontSize(30)
      .rotate(20)// .align(Text.ALIGN_CENTER_HORIZONTAL, Text.ALIGN_CENTER_VERTICAL)
      .zIndex(1)
      .typeface("bold");
    this.aMap?.addText(textOptions);
    let bitmap = BitmapDescriptorFactory.fromRawfilePathSync(getContext(), "BLUE.png"); //HUE_AZURE


    if (bitmap) {
      this.marker1 = this.aMap?.addMarker(new MarkerOptions()
        .setTitle("好好学习")
        .setIcon(bitmap)
        .setDraggable(true));
    }


    this.marker1?.setRotateAngle(90); // 设置marker旋转90度
    this.marker1?.setPositionByPixels(400, 400);
    this.marker1?.showInfoWindow(); // 设置默认显示一个infowinfow

    let markerOption = new MarkerOptions();
    markerOption.setPosition(Constants.XIAN);
    markerOption.setTitle("西安市").setSnippet("西安市：34.341568, 108.940174");


    let icon = BitmapDescriptorFactory.fromRawfilePathSync(getContext(), "location_marker.png")
    markerOption.setDraggable(true);
    if (icon) {
      markerOption.setIcon(icon);
    }
    // 将Marker设置为贴地显示，可以双指下拉看效果
    markerOption.setFlat(true);

    let gifList: ArrayList<BitmapDescriptor> = new ArrayList<BitmapDescriptor>();

    let bitmapDes1 = BitmapDescriptorFactory.fromRawfilePathSync(getContext(), "BLUE.png");
    if (bitmapDes1) {
      gifList.add(bitmapDes1);
    }
    let bitmapDes2 = BitmapDescriptorFactory.fromRawfilePathSync(getContext(), "RED.png");
    if (bitmapDes2) {
      gifList.add(bitmapDes2);
    }
    let bitmapDes3 = BitmapDescriptorFactory.fromRawfilePathSync(getContext(), "YELLOW.png");
    if (bitmapDes3) {
      gifList.add(bitmapDes3);
    }

    let markerOption1: MarkerOptions = new MarkerOptions().setAnchor(0.5, 0.5)
      .setPosition(Constants.CHENGDU)
      .setTitle("成都市")
      .setSnippet("成都市:30.679879, 104.064855")
      .setIcons(gifList)
      .setDraggable(true)
      .setPeriod(10);

    let markerOptionList: ArrayList<MarkerOptions> = new ArrayList<MarkerOptions>();
    markerOptionList.add(markerOption);
    markerOptionList.add(markerOption1);
    let markerList: ArrayList<Marker> | undefined = this.aMap?.addMarkers(markerOptionList, true);
    this.marker2 = markerList?.[0];
    this.marker4 = markerList?.[1];

    let icon3 = BitmapDescriptorFactory.fromRawfilePathSync(getContext(), "ic_launcher.png");
    if (icon3) {
      this.marker3 = this.aMap?.addMarker(new MarkerOptions().setPosition(Constants.ZHENGZHOU).setIcon(icon3));
    }


  }

  /**
   * marker点击时跳动一下
   */
  jumpPoint(marker: Marker) {
    let start: number = Date.now();
    let proj: Projection | undefined = this.aMap?.getProjection();
    let startPoint: Point | undefined = proj?.toScreenLocationSync(Constants.XIAN);
    let markerLatlng: LatLng = Constants.XIAN;

    if (startPoint) {
      startPoint.y = startPoint.y - 100;
      let startLatLng: LatLng | undefined = proj?.fromScreenLocationSync(startPoint);
      let duration: number = 1500;

      const interpolator: ICurve = {
        interpolate: (input: number) => {
          // 模拟弹跳插值器
          if (input < 4 / 11.0) {
            return (121 * input * input) / 16.0;
          } else if (input < 8 / 11.0) {
            return (363 / 40.0 * input * input) - (99 / 10.0 * input) + 17 / 5.0;
          } else if (input < 9 / 10.0) {
            return (4356 / 361.0 * input * input) - (35442 / 1805.0 * input) + 16061 / 1805.0;
          } else {
            return (54 / 5.0 * input * input) - (513 / 25.0 * input) + 268 / 25.0;
          }
        }
      };
      const animate = () => {
        const elapsed = Date.now() - start;
        let fraction = elapsed / duration;

        if (fraction > 1) {
          fraction = 1;
        }

        const t = interpolator.interpolate(fraction);

        const lng = t * markerLatlng.longitude + (1 - t) * (startLatLng?.longitude ?? 0);
        const lat = t * markerLatlng.latitude + (1 - t) * (startLatLng?.latitude ?? 0);
        marker.setPosition(new LatLng(lat, lng));

        if (fraction < 1) {
          // 继续下一帧
          setTimeout(animate, 16);
        }
      };
      animate();
    }

  }

  /**
   * 从地上生长效果，
   */
  growInto(marker: Marker) {
    let animation: Animation = new ScaleAnimation(0, 1, 0, 1);
    const linearCurve: ICurve = { interpolate: (t: number) => t };
    animation.setInterpolator(linearCurve);
    //整个移动所需要的时间
    animation.setDuration(1000);
    //设置动画
    marker.setAnimation(animation);
    //开始动画
    marker.startAnimation();
  }

  private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_MARKER_CUSTOM_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync(async (map) => {
      this.aMap = map;

      hilog.info(0xff, Constants.MAP_MARKER_CUSTOM_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true);
      // 设置marker可拖拽事件监听器
      this.aMap.setOnMarkerDragListener(new OnMarkerDragListener(
        // start
        (marker: Marker) => {
          let position = marker.getPosition();
          hilog.info(0xff, Constants.MAP_MARKER_CUSTOM_FUNC,
            `marker drag start ${marker.getId()} ${marker.getTitle()} ${position.latitude} ${position.longitude}`);
          this.markerListenerText = marker.getTitle() + "开始拖动";
          this.aMap?.getUiSettings()?.setAllGesturesEnabled(false)
        },
        // drap
        (marker: Marker) => {
          let position = marker.getPosition();
          hilog.info(0xff, Constants.MAP_MARKER_CUSTOM_FUNC,
            `marker drag move ${marker.getId()} ${marker.getTitle()} ${position.latitude} ${position.longitude}`);
          let curDes: string = marker.getTitle() + "拖动时当前位置:(lat,lng)\n("
            + marker.getPosition().latitude + ","
            + marker.getPosition().longitude + ")";
          this.markerListenerText = curDes
        },
        // end
        (marker: Marker) => {
          let position = marker.getPosition();
          hilog.info(0xff, Constants.MAP_MARKER_CUSTOM_FUNC,
            `marker drag end ${marker.getId()} ${marker.getTitle()} ${position.latitude} ${position.longitude}`);
          this.markerListenerText = marker.getTitle() + "停止拖动";
          this.aMap?.getUiSettings()?.setAllGesturesEnabled(true)
        }

      ));
      // 设置点击marker事件监听器
      this.aMap?.setOnMarkerClickListener((marker: Marker): boolean => {
        hilog.info(0xff, Constants.MAP_MARKER_CUSTOM_FUNC, `marker click ${marker.getId()} ${marker.getTitle()}`);
        if (marker === this.marker2) {
          this.jumpPoint(marker);
        } else if (marker === this.marker3) {
          this.aMap?.moveCamera(CameraUpdateFactory.newLatLng(new LatLng(marker.getPosition().latitude,
            marker.getPosition().longitude)))
          this.growInto(marker);
        }
        this.markerListenerText = "你点击的是:" + marker.getTitle()
        //
        this.renderInfoWindow(marker)
        return true;
      });
      // 设置点击infoWindow事件监听器
      this.aMap?.setOnInfoWindowClickListener((marker: Marker): void => {
        promptAction.showToast({ message: "你点击了infoWindow窗口：" + marker.getTitle() })
        setTimeout(()=>{
          promptAction.showToast({ message: "当前地图可视区域内Marker数量:" + this.aMap?.getMapScreenMarkers().length })
        },500)
      })
      await this.addMarkersToMap();

      // 设置所有maker显示在当前可视区域地图中
      this.setAllMarkerIntoScreen()

    })

  }
  setAllMarkerIntoScreen(){
    // 设置所有maker显示在当前可视区域地图中
    let bounds: LatLngBounds | undefined = new LatLngBoundsBuilder()
      .include(Constants.XIAN)
      .include(Constants.CHENGDU)
      .include(Constants.BEIJING)
      .include(this.latLng)
      .build();
    if (bounds) {
      this.aMap?.moveCamera(CameraUpdateFactory.newLatLngBounds(bounds, 150));
    }
  }

  renderInfoWindow(marker: Marker) {
    //设置点击后更改infowindow信息
    if (marker === this.marker2 || marker === this.marker4 || marker === this.marker1) {
      this.aMap?.moveCamera(CameraUpdateFactory.newLatLng(new LatLng(marker.getPosition().latitude,
        marker.getPosition().longitude)))
      this.onChangeInfoWindow(marker)
      marker.showInfoWindow()
    }
  }

  aboutToAppear(): void {
    globalContext = getContext().getApplicationContext();
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
    hilog.info(0xff, Constants.MAP_MARKER_CUSTOM_FUNC, "aboutToAppear");
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

    hilog.info(0xff, Constants.MAP_MARKER_CUSTOM_FUNC, "aboutToDisappear");
  }

  build() {
    NavDestination() {
      this.buildMapMarker();
    }
    .title(Constants.MAP_MARKER_CUSTOM_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })

  }
}

