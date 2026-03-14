import { AMap,
  AMapOptions,
  LatLng,
  LBSTraceClient, MapView, MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
  TraceListener,
  TraceLocation,
  TraceOverlay } from "@amap/amap_lbs_map3d";
import { Constants } from "../../utils/Constants";
import { CustomTitleBar } from "../../utils/CustomTitleBar";
import { ArrayList, HashMap } from "@kit.ArkTS";
import { LogUtil } from "@amap/amap_lbs_common";
import { TraceAsset } from "./TraceAsset";

/**
 * 轨迹纠偏功能 示例
 */
@Component
export struct TraceComponent{
  @Consume("pageInfos") pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private aMap?: AMap;
  private mapView?: MapView;
  private mTraceClient?: LBSTraceClient
  private mOverlayList: HashMap<number, TraceOverlay>  = new HashMap<number, TraceOverlay>()
  private mSequenceLineID: number = 1000
  private mTraceList: ArrayList<TraceLocation> = new ArrayList()
  @State  mDistanceString: string = '总距离：'
  @State  mStopTimeString: string = '等   待：'
  private static readonly DISTANCE_UNIT_DES: string = " KM"
  private static readonly TIME_UNIT_DES: string = " 分钟"
  private mCoordinateType: number = LBSTraceClient.TYPE_AMAP;
  private mRecordChooseArray: string[] = []
  @State titleStr: string = 'AMapTrace.txt'
  @State titleStrUpdate:string = '高德坐标'

  private traceListener:TraceListener = {
    /**
     * 轨迹纠偏失败回调
     */
    onRequestFailed:(lineID: number, errorInfo: string)=>{
      this.getUIContext().getPromptAction().showToast({ message: errorInfo})
      if (this.mOverlayList.hasKey(lineID)) {
        const overlay = this.mOverlayList.get(lineID)
        overlay.setTraceStatus(TraceOverlay.TRACE_STATUS_FAILURE)
        this.setDistanceWaitInfo(overlay)
      }
    },
    /**
     * 轨迹纠偏过程回调
     */
    onTraceProcessing:(lineID: number,index: number,segments: ArrayList<LatLng>)=>{
      if (!segments) {
        return
      }
      if (this.mOverlayList.hasKey(lineID)) {
        const overlay = this.mOverlayList.get(lineID)
        overlay.setTraceStatus(TraceOverlay.TRACE_STATUS_PROCESSING)
        overlay.add(segments)
      }

    },
    /**
     * 轨迹纠偏结束回调
     */
    onFinished:(lineID: number,linepoints:ArrayList<LatLng>, distance:number,waitingtime: number)=>{
      this.getUIContext().getPromptAction().showToast({ message: 'onFinished'})
      if (this.mOverlayList.hasKey(lineID)) {
        const overlay = this.mOverlayList.get(lineID)
        overlay.setTraceStatus(TraceOverlay.TRACE_STATUS_FINISH)
        overlay.setDistance(distance)
        overlay.setWaitTime(waitingtime)
        this.setDistanceWaitInfo(overlay)
      }
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

  @Builder
  SubMenu() {
    Menu() {
      ForEach(this.mRecordChooseArray, (content: string, index: number) => {
        MenuItem({ content: content })
          .onClick(async ()=>{
            let rm = getContext().resourceManager;
            this.mTraceList =  await TraceAsset.parseLocationsData(rm,`traceRecord/${content}`)
            if (index == 0) {
              this.titleStrUpdate = '高德坐标'
            }else if (index == 1){
              this.titleStrUpdate = '百度坐标'
            }else if (index == 2){
              this.titleStrUpdate = 'GPS坐标'
            }
            this.titleStr = content
          })
      })
    }
  }

  @Builder
  radioAmapType(value:string){
    Row(){
      Radio({value:value,group:'radioGroup'})
        .width(30)
        .height(30)
        .onChange((isChecked:boolean)=>{
          if (isChecked == true){
            this.mCoordinateType = LBSTraceClient.TYPE_AMAP
            if (value == 'GPS坐标') {
             this.mCoordinateType = LBSTraceClient.TYPE_GPS
            }else if (value == '百度坐标'){
              this.mCoordinateType = LBSTraceClient.TYPE_BAIDU
            }
          }
        }).checked(this.titleStrUpdate==value?true:false)
      Text(value)
    }
  }

  build() {
    NavDestination() {
      Stack({alignContent:Alignment.TopStart}){
        MapViewComponent({ mapViewName: Constants.MAP_TRACE_FUNC }).zIndex(0)

        Column({space: 20}){
          Row(){
            Text('轨迹纠偏')
              .height(40)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
              .backgroundColor(Color.Gray)
              .onClick(()=>{
                this.traceGrasp()
              })
            Line()
              .height(40)
              .width(1)
            Text('清除已完成线路')
              .height(40)
              .layoutWeight(1)
              .backgroundColor(Color.Gray)
              .textAlign(TextAlign.Center)
              .onClick(()=>{
                this.cleanFinishTrace()
              })
          }
          .width('100%')
          Column({space:5}){
            Text(this.mDistanceString)
              .backgroundColor(Color.Gray)
            Text(this.mStopTimeString)
              .backgroundColor(Color.Gray)
          }.alignItems(HorizontalAlign.Start)
          .width('100%')

        }.width('100%')

        Column({space:10}){
          Text(this.titleStr + '⬇️')
            .bindMenu(this.SubMenu())
            .height(40)
          Row(){
            Radio({value:'高德坐标',group:'radioGroup'})
              .width(30)
              .height(30)
              .onChange((isChecked:boolean)=>{
                if (isChecked == true){
                  this.mCoordinateType = LBSTraceClient.TYPE_AMAP
                }
              }).checked(this.titleStrUpdate=='高德坐标'?true:false)
            Text('高德坐标')
          }

          Row(){
            Radio({value:'GPS坐标',group:'radioGroup'})
              .width(30)
              .height(30)
              .onChange((isChecked:boolean)=>{
                if (isChecked == true){
                  this.mCoordinateType = LBSTraceClient.TYPE_GPS
                }
              }).checked(this.titleStrUpdate=='GPS坐标'?true:false)
            Text('GPS坐标')
          }

          Row(){
            Radio({value:'百度坐标',group:'radioGroup'})
              .width(30)
              .height(30)
              .onChange((isChecked:boolean)=>{
                if (isChecked == true){
                  this.mCoordinateType = LBSTraceClient.TYPE_BAIDU
                }
              }).checked(this.titleStrUpdate=='百度坐标'?true:false)
            Text('百度坐标')
          }

        }.position({bottom:150,right:10})
        .backgroundColor(Color.Gray)

      }
      .width('100%')
      .height('100%')
    }
    .title(Constants.MAP_TRACE_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      // mock请求数据
    })
  }

   async init(){
     let rm = getContext().resourceManager;
     this.mTraceList =  await TraceAsset.parseLocationsData(rm,'traceRecord/AMapTrace.txt')
     this.mRecordChooseArray =  TraceAsset.recordNames()
  }


  /**
   * 设置显示总里程和等待时间
   *
   * @param overlay
   */
  private setDistanceWaitInfo(overlay: TraceOverlay): void {
    let distance = -1
    let waittime = -1
    if (overlay) {
      distance = overlay.getDistance();
      waittime = overlay.getWaitTime();
    }

    let distanceStr: string = (distance / 1000.0).toFixed(1)
    let waittimeStr: string = (waittime / 60.0).toFixed(1)

    this.mDistanceString = '总距离：' + distanceStr + TraceComponent.DISTANCE_UNIT_DES
    this.mStopTimeString = '等   待：' + waittimeStr + TraceComponent.TIME_UNIT_DES
  }

  /**
   * 调起一次轨迹纠偏
   */
  traceGrasp(){
    if (this.mOverlayList.hasKey(this.mSequenceLineID)){
      const overlay = this.mOverlayList.get(this.mSequenceLineID)
      overlay.zoopToSpan()
      const status = overlay.getTraceStatus()
      let tipString = ''
      if (status == TraceOverlay.TRACE_STATUS_PROCESSING) {
        tipString = '该线路轨迹纠偏进行中...'
      } else if (status == TraceOverlay.TRACE_STATUS_FINISH){
        tipString = '该线路轨迹已完成'
      } else if (status == TraceOverlay.TRACE_STATUS_FAILURE){
        tipString = '该线路轨迹失败'
      }else  if (status == TraceOverlay.TRACE_STATUS_PREPARE){
        tipString = '该线路轨迹纠偏已经开始'
      }
      this.getUIContext().getPromptAction().showToast({ message: tipString})
      return
    }
    if (this.aMap) {
      const  mTraceOverlay = new TraceOverlay(this.aMap)
      this.mOverlayList.set(this.mSequenceLineID,mTraceOverlay)
      const mapList = this.traceLocationToMap(this.mTraceList)
      mTraceOverlay.setProperCamera(mapList)
      try {
        this.mTraceClient = new LBSTraceClient(getContext())
        this.mTraceClient.queryProcessedTrace(this.mSequenceLineID,this.mTraceList,this.mCoordinateType,this.traceListener)
      }catch (e) {
        LogUtil.e('TraceComponent','TraceComponent',JSON.stringify(e))
      }
    }
  }
  /**
   * 清除地图已完成或出错的轨迹
   */
  cleanFinishTrace(){
       for(let entry of this.mOverlayList.entries()){
         const key = entry[0] as number
         const overlay = entry[1] as TraceOverlay
         if (overlay.getTraceStatus() == TraceOverlay.TRACE_STATUS_FINISH || overlay.getTraceStatus() == TraceOverlay.TRACE_STATUS_FAILURE) {
           overlay.remove()
           this.mOverlayList.remove(key)
         }
       }
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
    if (mapViewName != Constants.MAP_TRACE_FUNC) {
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
    this.init()
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