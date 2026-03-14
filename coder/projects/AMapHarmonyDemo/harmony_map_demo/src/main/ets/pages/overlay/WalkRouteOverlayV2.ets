import { AMap, BitmapDescriptor, LatLng, MarkerOptions, PolylineOptions } from '@amap/amap_lbs_map3d';
import { WalkPath, LatLonPoint, WalkStep } from '@amap/amap_lbs_search';
import { AMapServicesUtil } from '../utils/AMapServicesUtil';
import { RouteOverlay } from './RouteOverlay';
import { BusinessError } from '@kit.BasicServicesKit';

export class WalkRouteOverlayV2 extends RouteOverlay {
  private mPolylineOptions?: PolylineOptions;
  private walkStationDescriptor?: BitmapDescriptor;
  private walkPath: WalkPath;

  /**
   * 通过此构造函数创建步行路线图层。
   * @param context 当前activity。
   * @param amap 地图对象。
   * @param path 步行路线规划的一个方案。详见搜索服务模块的路径查询包（com.amap.api.services.route）中的类 <strong><a href="../../../../../../Search/com/amap/api/services/route/WalkStep.html" title="com.amap.api.services.route中的类">WalkStep</a></strong>。
   * @param start 起点。详见搜索服务模块的核心基础包（com.amap.api.services.core）中的类<strong><a href="../../../../../../Search/com/amap/api/services/core/LatLonPoint.html" title="com.amap.api.services.core中的类">LatLonPoint</a></strong>。
   * @param end 终点。详见搜索服务模块的核心基础包（com.amap.api.services.core）中的类<strong><a href="../../../../../../Search/com/amap/api/services/core/LatLonPoint.html" title="com.amap.api.services.core中的类">LatLonPoint</a></strong>。
   * @since V2.1.0
   */
  constructor(context: Context, amap: AMap | undefined, path: WalkPath,
    start: LatLonPoint | undefined, end: LatLonPoint | undefined) {
    super(context);
    this.mAMap = amap;
    this.walkPath = path;
    if (start) {
      this.startPoint = AMapServicesUtil.convertToLatLng(start);
    }
    if (end) {
      this.endPoint = AMapServicesUtil.convertToLatLng(end);
    }
  }

  /**
   * 添加步行路线到地图中。
   * @since V2.1.0
   */
  public addToMap() {

    this.initPolylineOptions();
    try {
      let walkPaths = this.walkPath.getSteps();
      for (let i = 0; i < walkPaths.length; i++) {
        let walkStep = walkPaths[i];
        let latLng = AMapServicesUtil.convertToLatLng(walkStep.getPolyline()[0]);

        this.addWalkStationMarkers(walkStep, latLng);
        this.addWalkPolyLines(walkStep);

      }
      this.addStartAndEndMarker();

      this.showPolyline();
    } catch (e) {
      console.info((e as BusinessError).message);
    }
  }

  /**
   * @param walkStep
   */
  private addWalkPolyLines(walkStep: WalkStep) {
    this.mPolylineOptions?.addAll(AMapServicesUtil.convertArrList(walkStep.getPolyline()));
  }

  /**
   * @param walkStep
   * @param position
   */
  private addWalkStationMarkers(walkStep: WalkStep, position: LatLng) {
    this.addStationMarker(new MarkerOptions()
      .setPosition(position)
      .setTitle("\u65B9\u5411:" + walkStep.getAction()
        + "\n\u9053\u8DEF:" + walkStep.getRoad())
      .setSnippet(walkStep.getInstruction() ?? '')
      .setVisible(this.nodeIconVisible)
      .setAnchor(0.5, 0.5)
      .setIcon(this.walkStationDescriptor ?? new BitmapDescriptor(new ArrayBuffer(256), ''))
      .setZIndex(99)
    );
  }

  /**
   * 初始化线段属性
   */
  private initPolylineOptions() {

    if (this.walkStationDescriptor == null) {
      this.walkStationDescriptor = this.getWalkBitmapDescriptor();
    }

    this.mPolylineOptions = new PolylineOptions();
    this.mPolylineOptions.setColor(this.getWalkColor()).setWidth(this.getRouteWidth());
  }

  private showPolyline() {
    this.addPolyLine(this.mPolylineOptions);
  }
}