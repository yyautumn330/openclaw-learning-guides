import { AMap, BitmapDescriptor, BitmapDescriptorFactory, LatLng,
  MarkerOptions,
  PolylineOptions } from "@amap/amap_lbs_map3d";
import { LatLonPoint, RidePath, RideStep } from "@amap/amap_lbs_search";
import { AMapUtil } from "../utils/AMapUtil";
import { RouteOverlay } from "./RouteOverlay";
import { ArrayList } from "@kit.ArkTS";

/**
 * 骑行路线图层类。在高德地图API里，如果要显示步行路线规划，可以用此类来创建骑行路线图层。如不满足需求，也可以自己创建自定义的骑行路线图层。
 * @since V3.5.0
 */
export class RideRouteOverlay extends RouteOverlay {

  private mPolylineOptions?: PolylineOptions

  private walkStationDescriptor?: BitmapDescriptor

  private ridePath: RidePath
  /**
   * 通过此构造函数创建骑行路线图层。
   * @param context 当前activity。
   * @param amap 地图对象。
   * @param path 骑行路线规划的一个方案。详见搜索服务模块的路径查询包（com.amap.api.services.route）中的类 <strong><a href="../../../../../../Search/com/amap/api/services/route/WalkStep.html" title="com.amap.api.services.route中的类">WalkStep</a></strong>。
   * @param start 起点。详见搜索服务模块的核心基础包（com.amap.api.services.core）中的类<strong><a href="../../../../../../Search/com/amap/api/services/core/LatLonPoint.html" title="com.amap.api.services.core中的类">LatLonPoint</a></strong>。
   * @param end 终点。详见搜索服务模块的核心基础包（com.amap.api.services.core）中的类<strong><a href="../../../../../../Search/com/amap/api/services/core/LatLonPoint.html" title="com.amap.api.services.core中的类">LatLonPoint</a></strong>。
   * @since V3.5.0
   */
  public constructor(context:Context,amap:AMap | undefined,path:RidePath, start:LatLonPoint | undefined,end:LatLonPoint | undefined) {
    super(context)
    this.mContext = context
    this.mAMap = amap
    this.ridePath = path
    if (start) {
      this.startPoint = AMapUtil.convertToLatLng(start)
    }
    if (end) {
      this.endPoint = AMapUtil.convertToLatLng(end)
    }
  }
  /**
   * 添加骑行路线到地图中。
   * @since V3.5.0
   */
  public addToMap(){
    this.initPolylineOptions()
    try {
      let ridePaths  = this.ridePath.getSteps() as ArrayList<RideStep>
      for (const rideStep of ridePaths){
        const positions = rideStep.getPolyline() as ArrayList<LatLonPoint>
        if (positions && positions.length>0) {
          const position = positions[0] as LatLonPoint
          const latLng = AMapUtil.convertToLatLng(position)
          this.addRideStationMarkers(rideStep,latLng)
          this.addRidePolyLines(rideStep)
        }
      }

     this.addStartAndEndMarker()
      this.showPolyline()

    }catch (e){
      //todo 错误验证
      e.printStackTrace()
    }
  }
  /**
   * 初始化线段属性
   */
  private initPolylineOptions(){
    if (!this.walkStationDescriptor) {
      this.walkStationDescriptor = this.getRideBitmapDescriptor()
    }
    this.mPolylineOptions = undefined
    this.mPolylineOptions = new PolylineOptions()
    this.mPolylineOptions.setColor(this.getDriveColor())
  }
  /**
   * @param rideStep
   */
  private addRidePolyLines(rideStep: RideStep){
    const latlonPoints = rideStep.getPolyline() as ArrayList<LatLonPoint>
    for (const latlonpoint of latlonPoints){
      this.mPolylineOptions?.add(AMapUtil.convertToLatLng(latlonpoint))
    }
  }
  /**
   * @param rideStep
   * @param position
   */
  private addRideStationMarkers(rideStep: RideStep, position: LatLng){
      this.addStationMarker(new MarkerOptions()
        .setPosition(position)
        .setTitle("\u65B9\u5411:" + rideStep.getAction()
          + "\n\u9053\u8DEF:" + rideStep.getRoad())
        .setSnippet(rideStep.getInstruction() ?? "")
        .setVisible(this.nodeIconVisible)
        .setAnchor(0.5, 0.5)
        .setIcon(this.walkStationDescriptor as BitmapDescriptor)
        .setZIndex(99)
        )



  }

  private showPolyline() {
    this.addPolyLine(this.mPolylineOptions)
  }


}