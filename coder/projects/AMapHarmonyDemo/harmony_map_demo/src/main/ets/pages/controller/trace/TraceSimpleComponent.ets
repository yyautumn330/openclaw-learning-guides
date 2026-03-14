import { LatLng, LBSTraceClient, MapViewComponent, TraceLocation, TraceStatusListener,Polyline,
  AMap,
  MapView,
  MapViewManager,
  AMapOptions,
  MapViewCreateCallback,
  PolylineOptions,
  BitmapDescriptorFactory,
  BitmapDescriptor} from "@amap/amap_lbs_map3d"
import { Constants } from "../../utils/Constants"
import { CustomTitleBar } from "../../utils/CustomTitleBar"
import ArrayList from "@ohos.util.ArrayList"
import { ColorUtil } from "../../utils/ColorUtil"

@Component
export struct TraceSimpleComponent{
  @Consume("pageInfos") pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

  private aMap?: AMap;
  private mapView?: MapView;

  traceClient: LBSTraceClient| undefined = undefined;
  polyline: Polyline|undefined = undefined;
  tracedPolyline: Polyline|undefined = undefined;
  traceStatusListener: TraceStatusListener = {
     onTraceStatus:(locations?:ArrayList<TraceLocation>,rectifications?:ArrayList<LatLng>,errorInfo?:string)=>{

       if (LBSTraceClient.TRACE_SUCCESS != errorInfo) {
         let stringBuffer = ''
         if (locations) {
           for(const location of locations){
             stringBuffer = `{"lon":${location.getLongitude()},"lat":${location.getLatitude()},"loctime":${location.getTime()},"speed":${location.getSpeed()},"bearing":${location.getBearing()}}\n`
           }
         }
         console.log("amap","轨迹纠偏失败，请先检查以下几点:\n" +
           "定位是否成功\n" +
           "onTraceStatus第一个参数中 经纬度、时间、速度和角度信息是否为空\n" +
           "若仍不能解决问题，请将以下内容通过官网(lbs.amap.com)工单系统反馈给我们 \n" + errorInfo + " \n "
           + stringBuffer);
         return
       }
       this.showSourceLocations(locations)
       this.showTracedLocations(rectifications)
     }
  }

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

  build() {
    NavDestination() {
      Stack({alignContent:Alignment.TopStart}){
        MapViewComponent({ mapViewName: Constants.MAP_TRACE_SIMPLE_FUNC }).zIndex(0)
        Column({space: 20}){
          Row(){
            Text('开始轨迹纠偏')
              .height(40)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.Gray)
              .onClick(()=>{
                this.startTrace()
              })
            Line()
              .height(40)
              .width(1)
            Text('停止轨迹纠偏')
              .height(40)
              .layoutWeight(1)
              .backgroundColor(Color.Gray)
              .textAlign(TextAlign.Center)
              .onClick(()=>{
                // this.cleanFinishTrace()
                this.stopTrace()
              })
          }
          .width('100%')

        }.width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .title(Constants.MAP_TRACE_FUNC)
    .onBackPressed(() => {
      this.stopTrace()
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      // mock请求数据
    })
  }

  /**
   * 开启轨迹纠偏
   */
  private startTrace(): void {

    if (!this.traceClient) {
      try {
        this.traceClient = LBSTraceClient.getInstance(getContext());
      } catch (e) {
      }
    }
    this.traceClient?.startTrace(this.traceStatusListener);
  }

  /**
   * 停止轨迹纠偏
   */
  private  stopTrace():void {
  if(!this.traceClient) {
    try {
      this.traceClient = LBSTraceClient.getInstance(getContext());
    }catch (e){
    }
  }
  this.traceClient?.stopTrace()
}

  /**
   * 展示原始定位点
   * @param locations
   */
  private showSourceLocations(locations: ArrayList<TraceLocation>|undefined): void {
    if (!this.polyline) {
      this.polyline = this.aMap?.addPolyline(new PolylineOptions().setColor(ColorUtil.colorStringToNumber("#88FF0000"))
        .setWidth(40)
        .setZIndex(0));
    }
    if (!locations) {
      return;
    }
    let latLngs = new ArrayList<LatLng>();
    for (const traceLocation of locations) {
      latLngs.add(new LatLng(traceLocation.getLatitude(), traceLocation.getLongitude()));
    }
    this.polyline?.setPoints(latLngs);
  }

  /**
   * 展示纠偏后的点
   * @param rectifications
   */
  private showTracedLocations(rectifications: ArrayList<LatLng>|undefined): void {
    if (!this.tracedPolyline) {
      this.tracedPolyline = this.aMap?.addPolyline(new PolylineOptions()
        .setCustomTexture(BitmapDescriptorFactory.fromRawfilePathSync(getContext(this), "custtexture.png") as BitmapDescriptor)
        .setWidth(20).setZIndex(0));
    }
    if (!rectifications) {
      return;
    }
    this.tracedPolyline?.setPoints(rectifications);
  }

  /**
   * 轨迹纠偏点转换为地图LatLng
   *
   * @param traceLocationList
   * @return
   */
  public traceLocationToMap(traceLocationList: ArrayList<TraceLocation>): ArrayList<LatLng> {
    let mapList = new ArrayList<LatLng>();
    for (const location of traceLocationList) {
      const latlng = new LatLng(location.getLatitude(),
        location.getLongitude());
      mapList.add(latlng);
    }
    return mapList;
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }
    if (mapViewName != Constants.MAP_TRACE_SIMPLE_FUNC) {
      return;
    }
    this.mapView = mapview;
    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.aMap = map;

      this.aMap?.setOnMapClickListener((point: LatLng) => {

      });
      this.aMap.getUiSettings()?.setScaleControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomPosition(AMapOptions.ZOOM_POSITION_RIGHT_BUTTOM)
    })

  }

  async aboutToAppear(): Promise<void> {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
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

}