import {
  AMap,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
  MarkerOptions,
  Poi,
} from '@amap/amap_lbs_map3d'
import { OnPoiSearchListener, PoiItem, PoiQuery, PoiResult, PoiSearch, AMapException,
  LatLonPoint,
  SuggestionCity,
  ServiceSettings} from '@amap/amap_lbs_search';
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import { ArrayList } from '@kit.ArkTS';
import { ToastUtil } from '../../utils/ToastUtil';
import { PoiOverlay } from '../../overlay/PoiOverlay';
import { inputMethod } from '@kit.IMEKit';
import { webview } from '@kit.ArkWeb';
import { window } from '@kit.ArkUI';

/**
 * poiID搜索功能
 */
@Component
export struct MapPOIIDSearchController {
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  private mapView? : MapView;
  private aMap? : AMap;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

  @State poiQuery: PoiQuery | undefined = undefined;
  @State poiSearch: PoiSearch | undefined = undefined;

  //POI ID 字符串
  @State poiIDStr: string = "";

  @State poiTitle: string | undefined = "";
  @State poiSnippet: string | undefined = "";
  @State poiInfo: string = "";
  @State poiDetailVisibility: Visibility = Visibility.None

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
    onPoiSearched: (pageResult: PoiResult | undefined, errorCode: number) => {},
    onPoiItemSearched: (poiItem: PoiItem | undefined, errorCode: number) => {
      if (errorCode === AMapException.CODE_AMAP_SUCCESS) {
        if (poiItem !== null && poiItem !== undefined && poiItem.getLatLonPoint()) {
          // 清理之前的图标
          this.aMap?.clear();

          const markerOptions = new MarkerOptions();
          markerOptions.setPosition( this.convertToLatLng(poiItem.getLatLonPoint()!));
          this.setPoiItemDisplayContent(poiItem);
          this.whetherToShowDetailInfo(true);

          this.aMap?.addMarker(markerOptions);
        }
      }else {
        ToastUtil.showError(this.uiContext, errorCode)
      }
    }
  };

  setPoiItemDisplayContent(poiItem: PoiItem){
    this.poiTitle = poiItem.getTitle() || ''
    this.poiSnippet = poiItem.getSnippet() || ''
    this.poiInfo = "营业时间：" + (poiItem.getPoiExtension()?.getOpentime() || '') + "     评分："
      + (poiItem.getPoiExtension()?.getRating() || '');
  }

  whetherToShowDetailInfo(isToShow: boolean) {
    if (isToShow) {
      this.poiDetailVisibility = Visibility.Visible;
    } else {
      this.poiDetailVisibility = Visibility.None;
    }
  }

  //开始搜索
  startSearch(){
    try{
      //搜索，回调通过OnPoiSearchListener
      this.poiSearch?.searchPOIIdAsyn(this.poiIDStr);
    }catch (e){
      console.log(`doPoiSearchRequest error: ${JSON.stringify(e)}}`);
    }
  }

  //搜索视图
  @Builder
  buildSearchView() {
    Column(){
      Row(){
        TextInput({text: $$this.poiIDStr, placeholder: "请输入搜索ID"})
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
        .enabled(this.poiIDStr.length > 0)
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
    MapViewComponent({mapViewName: Constants.MAP_POI_ID_SEARCH_FUNC })
      .width("100%")
      .height("100%")
      .zIndex(1)
      .padding({
        bottom: this.keyboardHeight - (this.keyboardHeight ? this.getUIContext().px2vp(this.indicatorHeight) : 0)
      })
  }

  @Builder
  buildPoiDetail() {
    Column(){
      Text(this.poiTitle)
        .height(30)
        .fontSize(15)
        .fontColor('#5566b8')
        .width('100%')
      Text(this.poiSnippet)
        .height(25)
        .fontSize(15)
        .fontColor('#3333333')
        .width('100%')
      Text(this.poiInfo)
        .fontSize(12)
        .height(15)
        .fontColor('#3333333')
        .width('100%')
    }
    .justifyContent(FlexAlign.Center)
    .backgroundColor(Color.White)
    .visibility(this.poiDetailVisibility)
    .justifyContent(FlexAlign.Start)
    .padding({left:12, right:12})
    .width('100%')
    .position({
      bottom: -20
    })
    .height(80)
    .zIndex(999)
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_POI_ID_SEARCH_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.aMap = map;
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true);
      hilog.info(0xff, Constants.MAP_POI_ID_SEARCH_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);
      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
    })

  }

  aboutToAppear(): void {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);

    this.poiSearch = new PoiSearch(this.context!, undefined);
    this.poiSearch.setOnPoiSearchListener(this.poiSearchListener)

    this.poiIDStr = "B000A816R6";
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
      hilog.error(0xff, Constants.MAP_POI_ID_SEARCH_FUNC, 'err ' + err.message);
    })
  }

  aboutToDisappear(): void {
    window.getLastWindow(this.context).then(currentWindow => {
      currentWindow.off('avoidAreaChange')
    }).catch((err : Error) => {
      hilog.error(0xff, Constants.MAP_POI_ID_SEARCH_FUNC, 'err ' + err.message);
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
        Web({src: "", controller: new webview.WebviewController})
          .enableNativeEmbedMode(true)
        this.buildPoiDetail();
      }.height('100%')
    }
    .title(Constants.MAP_POI_ID_SEARCH_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })

  }
}

