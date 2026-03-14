import {
  AMap,
  CameraUpdateFactory,
  CircleOptions,
  LatLng,
  LatLngBounds,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
  Marker,
  MarkerOptions,
} from '@amap/amap_lbs_map3d'
import { OnPoiSearchListener, PoiItem, PoiQuery, PoiResult, PoiSearch, AMapException,
  LatLonPoint,
  PoiSearchBound} from '@amap/amap_lbs_search';
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import { ArrayList } from '@kit.ArkTS';
import { ToastUtil } from '../../utils/ToastUtil';
import { window } from '@kit.ArkUI';

@Component
export struct MapPOIAroundSearchController {
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  private mapView? : MapView;
  private aMap? : AMap;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

  lp: LatLonPoint = new LatLonPoint(39.993743, 116.472995);// 116.472995,39.993743
  @State keyword: string = "超市";

  @State poiSearch: PoiSearch | undefined = undefined

  private poiOverlay: myPoiOverlay | null = null;// poi图层

  @State keyboardHeight: number = 0
  private indicatorHeight: number = 0

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

  public convertToLatLng(point: LatLonPoint) {
    return new LatLng(point.getLatitude(), point.getLongitude());
  }

  /**
   * POI接口回调
   */
  private poiSearchListener: OnPoiSearchListener = {
    onPoiSearched: (pageResult: PoiResult | undefined, errorCode: number) => {
      console.log(`pageResult: ${JSON.stringify(pageResult)}`);
      this.aMap?.clear();
      if (errorCode === AMapException.CODE_AMAP_SUCCESS) {
        if (pageResult && pageResult.getPois() && pageResult.getPois().length > 0) {
          const poiItemList = pageResult.getPois() as ArrayList<PoiItem>;
          if(poiItemList !== null && poiItemList.length > 0){

            //清理之前搜索结果的marker
            if (this.poiOverlay !=null) {
              this.poiOverlay.removeFromMap();
            }

            this.poiOverlay = new myPoiOverlay(this.aMap!, poiItemList);
            this.poiOverlay.addToMap();
            this.poiOverlay.zoomToSpan();

            this.aMap!.addMarker(new MarkerOptions()
              .setAnchor(0.5, 0.5)
              .setPosition(new LatLng(this.lp.getLatitude(), this.lp.getLongitude()))
            );

            this.aMap!.addCircle(new CircleOptions()
              .setCenter(new LatLng(this.lp.getLatitude(), this.lp.getLongitude()))
              .setRadius(1000)
              .setStrokeColor(Color.Blue)
              .setFillColor(Constants.rgbaStringToArgbInt("rgba(0, 0, 0, 0.2)"))
              .setStrokeWidth(2)
            );
          }
        } else {
          ToastUtil.show(this.uiContext, '对不起，没有搜索到相关数据！')
        }
      } else {
        ToastUtil.showError(this.uiContext, errorCode)
      }
    },
    onPoiItemSearched: (poiItem: PoiItem | undefined, errorCode: number) => {}
  };

  //生成圆形搜索区域
  createCircleSearchBound(): PoiSearchBound{
    const searchBound = PoiSearchBound.createCircleSearchBound(this.lp, 1000);
    return searchBound;
  }

  //生成矩形搜索区域
  createRectangleSearchBound(): PoiSearchBound{
    const lowerLeftPoint = new LatLonPoint(39.998748, 116.47882);
    const upperRight = new LatLonPoint(40.000482, 116.484962);
    const searchBound = PoiSearchBound.createRectangleSearchBound(lowerLeftPoint, upperRight);
    return searchBound;
  }

  //生成多边形搜索区域
  createPolygonSearchBound(): PoiSearchBound{

    const pointList = new ArrayList<LatLonPoint>();
    pointList.add(new LatLonPoint(39.941711, 116.382248));
    pointList.add(new LatLonPoint(39.884882, 116.359566));
    pointList.add(new LatLonPoint(39.878120, 116.437630));
    pointList.add(new LatLonPoint(39.941711, 116.382248));

    const searchBound = PoiSearchBound.createPolygonSearchBound(pointList);
    return searchBound;
  }

  //开始搜索
  startSearch(){
    try{
      let query = new PoiQuery(this.keyword, "",  "");
      //默认base
      query.setExtensions("all");
      this.poiSearch?.setQuery(query);

      //搜索区域
      const searchBound = this.createCircleSearchBound();
      // const searchBound = this.createRectangleSearchBound();
      // const searchBound = this.createPolygonSearchBound();
      this.poiSearch?.setBound(searchBound)

      //搜索，回调通过 OnPoiSearchListener
      this.poiSearch?.searchPOIAsyn()
    }catch (e){
      console.log(`doPoiSearchRequest error: ${JSON.stringify(e)}}`);
    }
  }

  //搜索视图
  @Builder
  buildSearchView() {
    Column(){
      Row(){
        TextInput({text: $$this.keyword, placeholder: "请输入关键字"})
          .fontColor("#333")
          .borderRadius(0)
          .backgroundColor(Color.White)
          .layoutWeight(1)
          .height(44)
        Row(){
          Text("搜索")
            .fontSize(14)
            .fontColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(Color.Blue)
        .width(60)
        .height("100%")
        .enabled(this.keyword.length > 0)
        .onClick(() => {
          this.startSearch();
        })
      }
      .borderRadius(5)
      .clip(true)
      .width("100%")
      .height(44)
    }
    .height(44)
    .padding(10)
    .width("100%")
    .backgroundColor(Color.Transparent)
    .zIndex(2)
  }

  //显示地图
  @Builder
  buildMapShow() {
    MapViewComponent({mapViewName: Constants.MAP_POI_AROUND_SEARCH_FUNC })
      .width("100%")
      .height("100%")
      .zIndex(1)
      .padding({
        bottom: this.keyboardHeight - (this.keyboardHeight ? this.getUIContext().px2vp(this.indicatorHeight) : 0)
      })
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_POI_AROUND_SEARCH_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.aMap = map;
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true);
      hilog.info(0xff, Constants.MAP_POI_AROUND_SEARCH_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);
      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
    })

  }

  aboutToAppear(): void {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);

    this.poiSearch = new PoiSearch(this.context!, undefined);
    this.poiSearch.setOnPoiSearchListener(this.poiSearchListener)
    let navigationIndicatorType = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR;
    window.getLastWindow(this.context).then(currentWindow => {
      let avoidArea = currentWindow.getWindowAvoidArea(navigationIndicatorType);
      // Get the height of the navigation bar area
      this.indicatorHeight = avoidArea.bottomRect.height
      currentWindow.on('avoidAreaChange', data => {
        if (data.type === window.AvoidAreaType.TYPE_KEYBOARD) {
          this.keyboardHeight = this.uiContext.px2vp(data.area.bottomRect.height)
        }
      })
    }).catch((err : Error) => {
      hilog.error(0xff, Constants.MAP_POI_AROUND_SEARCH_FUNC, 'err ' + err.message);
    })
  }

  aboutToDisappear(): void {
    window.getLastWindow(this.context).then(currentWindow => {
      currentWindow.off('avoidAreaChange')
    }).catch((err : Error) => {
      hilog.error(0xff, Constants.MAP_POI_AROUND_SEARCH_FUNC, 'err ' + err.message);
    })
    if (this.mapViewCreateCallback) {
      MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    }

    if (this.mapView) {
      this.mapView.onDestroy();
      this.mapView = undefined;
      this.aMap = undefined;
    }
  }



  build() {
    NavDestination() {
      Stack({alignContent: Alignment.TopStart}){
        this.buildMapShow();
        this.buildSearchView();
      }
    }
    .title(Constants.MAP_POI_AROUND_SEARCH_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })

  }
}

/**
 * 自定义PoiOverlay
 *
 */

class myPoiOverlay {
  private mamap: AMap | null = null;
  private mPois: ArrayList<PoiItem> = new ArrayList<PoiItem>();
  private mPoiMarks: ArrayList<Marker> = new ArrayList<Marker>();

  constructor(amap: AMap, pois: ArrayList<PoiItem>) {
    this.mamap = amap;
    this.mPois = pois;
  }

  /**
   * 添加Marker到地图中。
   * @since V2.1.0
   */
  public addToMap() {
    if(this.mPois != null) {
      for (let i = 0; i < this.mPois.length; i++) {
        const marker = this.mamap!.addMarker(this.getMarkerOptions(i));
        const item = this.mPois[i];
        marker!.setObject(item);
        this.mPoiMarks.add(marker);
      }
    }
  }

  /**
   * 去掉PoiOverlay上所有的Marker。
   *
   * @since V2.1.0
   */
  public removeFromMap(): void {
    this.mPoiMarks.forEach((marker: Marker) => {
      marker.remove();
    });
  }

  /**
   * 移动镜头到当前的视角。
   * @since V2.1.0
   */
  public zoomToSpan(): void {
    if (this.mPois != null && this.mPois.length > 0) {
      if (this.mamap == null)
        return;
      const bounds = this.getLatLngBounds();
      this.mamap.moveCamera(CameraUpdateFactory.newLatLngBounds(bounds, 400));
    }
  }

  private getLatLngBounds(): LatLngBounds {
    const b = LatLngBounds.builder();
    if(this.mPois != null) {
      for (let i = 0; i < this.mPois.length; i++) {
        b.include(new LatLng(this.mPois[i].getLatLonPoint()?.getLatitude() ?? 0,
          this.mPois[i].getLatLonPoint()?.getLongitude() ?? 0));
      }
    }
    return b.build()!;
  }

  private getMarkerOptions(index: number): MarkerOptions {
    return new MarkerOptions().setPosition(
        new LatLng(this.mPois[index].getLatLonPoint()?.getLatitude() ?? 0,
          this.mPois[index].getLatLonPoint()?.getLongitude() ?? 0))
      .setTitle(this.getTitle(index))
      .setSnippet(this.getSnippet(index))
  }

  protected getTitle(index: number): string {
    return this.mPois[index].getTitle() ?? "";
  }

  protected getSnippet(index: number): string {
    return this.mPois[index].getSnippet() ?? "";
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
  public getPoiItem(index: number): PoiItem | null {
    if (index < 0 || index >= this.mPois.length) {
      return null;
    }
    return this.mPois[index];
  }
}

