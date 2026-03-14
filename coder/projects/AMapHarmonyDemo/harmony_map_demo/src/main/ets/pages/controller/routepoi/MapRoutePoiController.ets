import {
  AMap,
  AMapOptions,
  CameraUpdateFactory,
  LatLng,
  LatLngBounds,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
  Marker,
  MarkerOptions,
} from "@amap/amap_lbs_map3d";
import { Constants } from "../../utils/Constants"
import { hilog } from "@kit.PerformanceAnalysisKit";
import {
  AMapException,
  DriveRouteQuery,
  DriveRouteResult,
  FromAndTo,
  LatLonPoint,
  OnRoutePOISearchListener,
  OnRouteSearchListener,
  RoutePOISearch,
  RoutePOISearchQuery,
  RoutePOISearchResult,
  RoutePOISearchType,
  RouteSearch
} from "@amap/amap_lbs_search";
import { DrivingRouteOverlay } from "../../overlay/DrivingRouteOverlay";
import { ArrayList } from "@kit.ArkTS";
import { RoutePOIItem } from "@amap/amap_lbs_search";
import { ToastUtil } from "../../utils/ToastUtil";

@Component
export struct MapRoutePoiController {
  private mapView?: MapView;
  private aMap?: AMap;
  @Consume("pageInfos") pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private mContext: Context = getContext();
  private routePoiOverlay: myRoutePoiOverlay | undefined = undefined;
  private mRouteSearch?: RouteSearch;
  private mDriveRouteResult?: DriveRouteResult;
  private mStartPoint: LatLonPoint = new LatLonPoint(39.942295, 116.335891); //起点，39.942295,116.335891
  private mEndPoint: LatLonPoint = new LatLonPoint(39.995576, 116.481288); //终点，39.995576,116.481288
  private mode = RouteSearch.DrivingDefault;
  private routePOISearch: RoutePOISearch | undefined = undefined;
  @State selectIndex: number = 0;
  //ROUTE搜索回调
  private onRouteSearchListener: OnRouteSearchListener = {
    onDriveRouteSearched: (result: DriveRouteResult, errorCode: number): void => {
      this.aMap?.clear(); // 清理地图上的所有覆盖物
      if (errorCode === AMapException.CODE_AMAP_SUCCESS) {
        const paths = result.getPaths()
        if (result && paths) {
          if (paths.length > 0) {
            this.mDriveRouteResult = result;
            const drivePath = this.mDriveRouteResult.getPaths()?.[0];
            if (!drivePath) {
              return;
            }
            const drivingRouteOverlay = new DrivingRouteOverlay(
              this.mContext, this.aMap, drivePath,
              this.mDriveRouteResult.getStartPos(),
              this.mDriveRouteResult.getTargetPos(), new ArrayList());
            drivingRouteOverlay.setNodeIconVisibility(false); //设置节点marker是否显示
            drivingRouteOverlay.setIsColorfulline(false); //是否用颜色展示交通拥堵情况，默认false
            drivingRouteOverlay.removeFromMap();
            drivingRouteOverlay.addToMap();
            drivingRouteOverlay.zoomToSpan();

            this.searchRoutePOI(RoutePOISearchType.TypeGasStation);
          }
        }
      }
    },
    onRideRouteSearched: () => {

    },
    onWalkRouteSearched: () => {

    },
    onBusRouteSearched: () => {

    }
  }
  //ROUTEPOI 搜索回调
  private onRoutePoiSearchListener: OnRoutePOISearchListener = {
    onRoutePoiSearched: (result: RoutePOISearchResult | undefined, errorCode: number): void => {
      if (errorCode == AMapException.CODE_AMAP_SUCCESS) {
        if (result != null) {
          const items = result.getRoutePois();
          if (items != null && items.length > 0) {
            if (this.routePoiOverlay != null) {
              this.routePoiOverlay.removeFromMap();
            }
            this.routePoiOverlay = new myRoutePoiOverlay(this.aMap!, items);
            this.routePoiOverlay.addToMap();
          } else {
            ToastUtil.show(this.getUIContext(), '对不起，没有搜索到相关数据！');
          }
        }
      } else {
        ToastUtil.showError(this.getUIContext(), errorCode)
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

  build() {
    NavDestination() {
      this.buildSearchTypeView()
      this.buildMapShow()
    }
    .title(Constants.MAP_ROUTEPOI_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      // mock请求数据
    })
  }

  private searchRoutePOI(type: RoutePOISearchType) {
    if (this.routePoiOverlay != null) {
      this.routePoiOverlay.removeFromMap();
    }
    const query = new RoutePOISearchQuery(this.mStartPoint, this.mEndPoint, this.mode, type, 250);
    try {
      this.routePOISearch = new RoutePOISearch(this.mContext, query);
      this.routePOISearch.setPoiSearchListener(this.onRoutePoiSearchListener);
      this.routePOISearch.searchRoutePOIAsyn();
    } catch (e) {
      e.printStackTrace();
    }
  }

  @Builder
  buildSearchType_itemView(title: string, type: RoutePOISearchType, index: number) {
    Row() {
      Text(title)
        .fontColor(this.selectIndex === index ? "#FFFFFF" : "#666666")
        .textAlign(TextAlign.Center)
    }
    .width("25%")
    .height("100%")
    .backgroundColor(this.selectIndex === index ? "#0000FF" : "#F0F0F0")
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.searchRoutePOI(type);
      this.selectIndex = index;
    })
  }

  @Builder
  buildSearchTypeView() {
    Row() {
      this.buildSearchType_itemView("加油站", RoutePOISearchType.TypeGasStation, 0)
      this.buildSearchType_itemView("ATM", RoutePOISearchType.TypeATM, 1)
      this.buildSearchType_itemView("汽修店", RoutePOISearchType.TypeMaintenanceStation, 2)
      this.buildSearchType_itemView("厕所", RoutePOISearchType.TypeToilet, 3)
    }
    .justifyContent(FlexAlign.Start)
    .alignItems(VerticalAlign.Center)
    .backgroundColor("#F0F0F0")
    .width("100%")
    .height(44)
  }

  @Builder
  buildMapShow() {
    Column() {
      MapViewComponent({ mapViewName: Constants.MAP_ROUTEDRIVE_FUNC }).layoutWeight(1)
    }.width('100%')
    .height('100%')
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_ROUTEDRIVE_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.aMap = map;

      hilog.info(0xff, Constants.MAP_ROUTEPOI_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

      this.aMap?.setOnMapClickListener((point: LatLng) => {
        hilog.info(0xff, Constants.MAP_ROUTEPOI_FUNC, `map click ${point.longitude} ${point.latitude}`);
      });
      this.aMap.getUiSettings()?.setScaleControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomPosition(AMapOptions.ZOOM_POSITION_RIGHT_BUTTOM)
      this.searchRouteResult()
      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
    })

  }

  /**
   * 开始搜索路径规划方案
   */
  public async searchRouteResult() {
    this.mRouteSearch = new RouteSearch(this.mContext)
    this.mRouteSearch.setRouteSearchListener(this.onRouteSearchListener)
    const fromAndTo = new FromAndTo(this.mStartPoint, this.mEndPoint);
    const query = new DriveRouteQuery(fromAndTo, RouteSearch.DrivingDefault, undefined, undefined,
      ""); // 第一个参数表示路径规划的起点和终点，第二个参数表示驾车模式，第三个参数表示途经点，第四个参数表示避让区域，第五个参数表示避让道路
    query.setExtensions(RouteSearch.EXTENSIONS_ALL);
    this.mRouteSearch.calculateDriveRouteAsyn(query); // 异步路径规划驾车模式查询
    // this.onRouteSearchListener.onDriveRouteSearched(await this.mRouteSearch.calculateDriveRoute(query) ?? new DriveRouteResult(),AMapException.CODE_AMAP_SUCCESS); // 同步路径规划驾车模式查询
  }

  async aboutToAppear(): Promise<void> {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
    hilog.info(0xff, Constants.MAP_SHOW_FUNC, "aboutToAppear");
  }

  aboutToDisappear(): void {
    if (this.mapViewCreateCallback) {
      MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    }

    if (this.mapView) {
      this.mapView.onDestroy();
      this.mapView = undefined;
      this.aMap = undefined;
      hilog.info(0xff, Constants.MAP_SHOW_FUNC, "aboutToDisappear");
    }
  }
}


/**
 * 自定义PoiOverlay
 *
 */

class myRoutePoiOverlay {
  private mamap: AMap | undefined;
  private mPois: ArrayList<RoutePOIItem> = new ArrayList<RoutePOIItem>();
  private mPoiMarks = new ArrayList<Marker>();

  constructor(amap: AMap, pois: ArrayList<RoutePOIItem>) {
    this.mamap = amap;
    this.mPois = pois;
  }

  /**
   * 添加Marker到地图中。
   * @since V2.1.0
   */
  public addToMap() {
    for (let i = 0; i < this.mPois.length; i++) {
      const marker = this.mamap!.addMarker(this.getMarkerOptions(i));
      const item = this.mPois[i];
      marker?.setObject(item);
      this.mPoiMarks.add(marker);
    }
  }

  /**
   * 去掉PoiOverlay上所有的Marker。
   *
   * @since V2.1.0
   */
  public removeFromMap(): void {
    this.mPoiMarks.forEach((mark: Marker) => {
      mark.remove();
    });
  }

  /**
   * 移动镜头到当前的视角。
   * @since V2.1.0
   */
  public zoomToSpan(): void {
    if (this.mPois != null && this.mPois.length > 0) {
      if (this.mamap == null) {
        return;
      }
      const bounds = this.getLatLngBounds();
      this.mamap.moveCamera(CameraUpdateFactory.newLatLngBounds(bounds, 100));
    }
  }

  private getLatLngBounds(): LatLngBounds {
    const b = LatLngBounds.builder();
    for (let i = 0; i < this.mPois.length; i++) {
      b.include(new LatLng(this.mPois[i].getPoint()?.getLatitude() ?? 0,
        this.mPois[i].getPoint()?.getLongitude() ?? 0));
    }
    return b.build()!;
  }

  private getMarkerOptions(index: number): MarkerOptions {
    return new MarkerOptions().setPosition(
      new LatLng(this.mPois[index].getPoint()?.getLatitude() ?? 0, this.mPois[index].getPoint()?.getLongitude() ?? 0))
      .setTitle(this.getTitle(index) ?? "").setSnippet(this.getSnippet(index) ?? "").setZIndex(100);
  }

  protected getTitle(index: number): string | undefined {
    return this.mPois[index].getTitle()
  }

  protected getSnippet(index: number): string | undefined {
    return this.mPois[index].getDistance() + "米  " + this.mPois[index].getDuration() + "秒";
  }

  /**
   * 从marker中得到poi在list的位置。
   *
   * @param marker 一个标记的对象。
   * @return 返回该marker对应的poi在list的位置。
   * @since V2.1.0
   */
  public getPoiIndex(marker: Marker): number {
    for (let i = 0; i < this.mPoiMarks.length; i++) {
      if (this.mPoiMarks[i].getId() === marker.getId()) {
        return i;
      }
    }
    return -1;
  }

  /**
   * 返回第index的poi的信息。
   * @param index 第几个poi。
   * @return poi的信息。poi对象详见搜索服务模块的基础核心包（com.amap.api.services.core）中的类 <strong><a href="../../../../../../Search/com/amap/api/services/core/PoiItem.html" title="com.amap.api.services.core中的类">PoiItem</a></strong>。
   * @since V2.1.0
   */
  public getPoiItem(index: number): RoutePOIItem | null {
    if (index < 0 || index >= this.mPois.length) {
      return null;
    }
    return this.mPois[index];
  }
}