import { AMap,
  BitmapDescriptorFactory,
  CameraUpdateFactory,
  LatLng,
  LatLngBoundsBuilder,
  MapView, MapViewComponent, MapViewCreateCallback, MapViewManager,
  MarkerOptions,
  PolylineOptions,
  TextOptions} from "@amap/amap_lbs_map3d";
import { DistanceResult, DistanceSearch, LatLonPoint, OnDistanceSearchListener, AMapException,
  DistanceQuery,
  DistanceItem} from "@amap/amap_lbs_search";
import { AMapUtil } from "../../utils/AMapUtil";
import { Constants } from "../../utils/Constants";
import { ToastUtil } from "../../utils/ToastUtil";
import { ArrayList } from "@kit.ArkTS";

/**
 * 距离测量 实现
 */
@Component
export struct RouteDistanceController{

  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  private mapView? : MapView;
  private aMap? : AMap;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

  private distanceSearch: DistanceSearch | undefined = undefined;

  // 北京站
  private start0: LatLonPoint = new LatLonPoint(39.902896,116.42792);
  // 北京南站
  private start1: LatLonPoint = new LatLonPoint(39.865208,116.378596);

  // 北京西站
  private start2: LatLonPoint = new LatLonPoint(39.894914,116.322062);

  // 北京北站
  private start3: LatLonPoint = new LatLonPoint(39.945261,116.352994);

  // 北京市政府
  private dest: LatLonPoint = new LatLonPoint(39.90455, 116.407555);

  // 中间点列表
  private midPointList: ArrayList<LatLng> = new ArrayList();
  /**
   * 监听外部传入的isWaiting变量，isWaiting值发生变化时触发onChange回调函数
   */
  @State @Watch("onWaitingStateChange") isWaiting: boolean = false;
  /**
   * Waiting弹窗
   */
  controller: CustomDialogController | undefined = new CustomDialogController({
    builder: WaitingDialog({
      isWaiting: $isWaiting
    }),
    cancel: () => {
      this.isWaiting = false
    },
    alignment: DialogAlignment.Center,
    customStyle: true,
  })

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

  /**
   * 当isWaiting的值变化时触发回调
   */
  onWaitingStateChange() {
    if (this.isWaiting) {
      this.controller?.open();
    } else {
      this.controller?.close();
    }
  }

  aboutToAppear(): void {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
  }

  private setFromAndTo() {

    const latLngStart0 = AMapUtil.convertToLatLng(this.start0);
    const latLngStart1 = AMapUtil.convertToLatLng(this.start1);
    const latLngStart2 = AMapUtil.convertToLatLng(this.start2);
    const latLngStart3 = AMapUtil.convertToLatLng(this.start3);
    const latLngEnd = AMapUtil.convertToLatLng(this.dest);

    const start0Icon = BitmapDescriptorFactory.fromRawfilePathSync(this.context!, "poi_marker_1.png");
    const startOptions = new MarkerOptions().setPosition(latLngStart0);
    if(start0Icon) startOptions.setIcon(start0Icon);
    this.aMap?.addMarker(startOptions);

    const start1Icon = BitmapDescriptorFactory.fromRawfilePathSync(this.context!, "poi_marker_2.png");
    const start1Options = new MarkerOptions().setPosition(latLngStart1);
    if(start1Icon) start1Options.setIcon(start1Icon);
    this.aMap?.addMarker(start1Options);

    const start2Icon = BitmapDescriptorFactory.fromRawfilePathSync(this.context!, "poi_marker_3.png");
    const start2Options = new MarkerOptions().setPosition(latLngStart2);
    if(start2Icon) start2Options.setIcon(start2Icon);
    this.aMap?.addMarker(start2Options);

    const start3Icon = BitmapDescriptorFactory.fromRawfilePathSync(this.context!, "poi_marker_4.png");
    const start3Options = new MarkerOptions().setPosition(latLngStart3);
    if(start3Icon) start3Options.setIcon(start3Icon);
    this.aMap?.addMarker(start3Options);

    const endIcon = BitmapDescriptorFactory.fromRawfilePathSync(this.context!, "amap_end.png");
    const endOptions = new MarkerOptions().setPosition(latLngEnd);
    if(endIcon) endOptions.setIcon(endIcon);
    this.aMap?.addMarker(endOptions);

    this.aMap?.addPolyline(new PolylineOptions().add(latLngStart0,latLngEnd).setColor(0xff00ff00));
    this.aMap?.addPolyline(new PolylineOptions().add(latLngStart1,latLngEnd).setColor(0xff00ff00));
    this.aMap?.addPolyline(new PolylineOptions().add(latLngStart2,latLngEnd).setColor(0xff00ff00));
    this.aMap?.addPolyline(new PolylineOptions().add(latLngStart3,latLngEnd).setColor(0xff00ff00));

    this.midPointList.add(this.getMidLatLng(latLngStart0, latLngEnd));
    this.midPointList.add(this.getMidLatLng(latLngStart1, latLngEnd));
    this.midPointList.add(this.getMidLatLng(latLngStart2, latLngEnd));
    this.midPointList.add(this.getMidLatLng(latLngStart3, latLngEnd));

    //展示出所有点
    const builder = new LatLngBoundsBuilder();
    builder.include(AMapUtil.convertToLatLng(this.start0));
    builder.include(AMapUtil.convertToLatLng(this.start1));
    builder.include(AMapUtil.convertToLatLng(this.start2));
    builder.include(AMapUtil.convertToLatLng(this.start3));
    builder.include(AMapUtil.convertToLatLng(this.dest));
    this.aMap?.moveCamera(CameraUpdateFactory.newLatLngBounds(builder.build()!, 100));

    try {
      this.distanceSearch = new DistanceSearch(this.context!);
      this.distanceSearch.setDistanceSearchListener(this.distanceSearchListener);
    } catch (e) {
      e.printStackTrace();
    }

    this.searchDistanceResult(DistanceSearch.TYPE_DRIVING_DISTANCE);

  }

  /**
   * 求两个经纬度的中点
   * @param l1
   * @param l2
   * @return
   */
  private getMidLatLng(l1: LatLng, l2: LatLng): LatLng {
    return new LatLng((l1.latitude + l2.latitude ) / 2, (l1.longitude + l2.longitude ) / 2);
  }


  /**
   * POI接口回调
   */
  private distanceSearchListener: OnDistanceSearchListener = {
    onDistanceSearched: (distanceResult: DistanceResult, errorCode: number) => {
      this.isWaiting = false;
      if (errorCode === AMapException.CODE_AMAP_SUCCESS) {
        try {
          const distanceItems = distanceResult.getDistanceResults();
          const distanceQuery = distanceResult.getDistanceQuery();
          const origins = distanceQuery.getOrigins();
          const destLatlon = distanceQuery.getDestination();

          if(distanceItems === null || distanceItems.length === 0) {
            return;
          }

          let index = 1;
          distanceItems.forEach((item: DistanceItem) => {
            let sb = "";
            //item.getOriginId() - 1 是因为 下标从1开始
            sb += "\n\torid: " + item.getOriginId() + " " + origins[item.getOriginId() - 1] + "\n";
            sb += "\tdeid: " + item.getDestId() + " " + destLatlon + "\n";
            sb += "\tdis: " + item.getDistance() + " , ";
            sb += "\tdur: " + item.getDuration();

            if (item.getErrorInfo().length > 0) {
              sb += " , " + "err: " + item.getErrorCode() + " " + item.getErrorInfo();
            }

            sb += "\n";

            this.aMap?.addText(new TextOptions().position(this.midPointList[index - 1]).text(item.getDistance() + " 米 " + item.getDuration() + " 秒"));

            index++;
          });
        } catch (e) {
          e.printStackTrace();
        }
      } else {
        ToastUtil.showError(this.uiContext, errorCode)
      }
    }
  };

  /**
   * 开始搜索路径规划方案
   */
  public searchDistanceResult(mode: number): void {
    this.isWaiting = true;
    const distanceQuery = new DistanceQuery();

    const latLonPoints: ArrayList<LatLonPoint> = new ArrayList<LatLonPoint>();
    latLonPoints.add(this.start0);
    latLonPoints.add(this.start1);
    latLonPoints.add(this.start2);
    latLonPoints.add(this.start3);
    distanceQuery.setOrigins(latLonPoints);
    distanceQuery.setDestination(this.dest);
    distanceQuery.setType(mode);

    this.distanceSearch?.calculateRouteDistanceAsyn(distanceQuery);
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
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_ROUTEDISTANCE_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.aMap = map;
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true);

      this.setFromAndTo();
    })

  }


  //显示地图
  @Builder
  buildMapShow() {
    MapViewComponent({mapViewName: Constants.MAP_ROUTEDISTANCE_FUNC })
      .width("100%")
      .layoutWeight(1)
  }

  build() {
    NavDestination() {
      this.buildMapShow();
    }
    .title(Constants.MAP_ROUTEDISTANCE_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
  }
}


@CustomDialog
export struct WaitingDialog {
  @Link isWaiting: boolean
  controller?: CustomDialogController
  @State rotateAngle: number = 0

  build() {

    Stack({ alignContent: Alignment.Center }) {
      Image($r('app.media.default_loading_icon'))
        .width(54)
        .objectFit(ImageFit.Cover)

      Image($r('app.media.default_loading'))
        .width(60)
        .height(60)
        .objectFit(ImageFit.Cover)
        .rotate({ angle: this.rotateAngle })
        .animation({
          duration: 500,
          curve: Curve.Linear,
          iterations: -1, // -1为无限播放
          playMode: PlayMode.Normal,
        })
        .onAppear(() => {
          this.rotateAngle = 360
        })
    }.width(56)
    .height(56)
    .borderRadius(10)
    .backgroundColor('#99ADAEB2')

  }
}