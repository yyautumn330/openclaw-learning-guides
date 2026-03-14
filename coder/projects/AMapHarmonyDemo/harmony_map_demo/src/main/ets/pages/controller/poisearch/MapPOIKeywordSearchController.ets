import {
  AMap,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
} from '@amap/amap_lbs_map3d'
import { OnPoiSearchListener, PoiItem, PoiQuery, PoiResult, PoiSearch, AMapException,
  LatLonPoint,
  SuggestionCity,
  ServiceSettings,
  PoiQueryV2} from '@amap/amap_lbs_search';
import hilog from '@ohos.hilog';
import { Constants } from '../../utils/Constants';
import { ArrayList } from '@kit.ArkTS';
import { ToastUtil } from '../../utils/ToastUtil';
import { PoiOverlay } from '../../overlay/PoiOverlay';
import { inputMethod } from '@kit.IMEKit';
import { window } from '@kit.ArkUI';

@Component
export struct MapPOIKeywordSearchController {
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  private mapView? : MapView;
  private aMap? : AMap;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

  @State keyword: string = "";
  @State city: string = "北京";


  @State poiQuery: PoiQuery | undefined = undefined;
  @State poiQuery2: PoiQueryV2 | undefined = undefined;
  @State poiSearch: PoiSearch | undefined = undefined

  @State pageResult: PoiResult | undefined = undefined;

  //当前页码
  @State currPage: number = 0;

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
      if (errorCode === AMapException.CODE_AMAP_SUCCESS) {
        this.pageResult = pageResult;
        if (pageResult && pageResult.getPois() && pageResult.getPois().length > 0) {
          const poiItemList = pageResult.getPois() as ArrayList<PoiItem>;

          // 清理之前的图标
          this.aMap?.clear();

          const poiOverlay = new PoiOverlay(this.aMap!, poiItemList);
          poiOverlay.removeFromMap();
          poiOverlay.addToMap();
          poiOverlay.zoomToSpan();
        } else if(pageResult && pageResult.getSearchSuggestionCitys() && pageResult.getSearchSuggestionCitys()!.length > 0){
          this.showSuggestCity(pageResult.getSearchSuggestionCitys()!);
        } else {
          ToastUtil.show(this.uiContext, '对不起，没有搜索到相关数据！')
        }
      }else {
        ToastUtil.showError(this.uiContext, errorCode)
      }
    },
    onPoiItemSearched: (poiItem: PoiItem | undefined, errorCode: number) => {}
  };


  /**
   * poi没有搜索到数据，返回一些推荐城市的信息
   */
  private showSuggestCity(cities: ArrayList<SuggestionCity> ): void {
    let infomation = "推荐城市\n";
    for (let i = 0; i < cities.length; i++) {
      infomation += "城市名称:" + cities[i].getCityName() + "城市区号:"
      + cities[i].getCityCode() + "城市编码:"
      + cities[i].getAdCode() + "\n";
    }
    ToastUtil.show(this.uiContext, infomation);
  }

  //开始搜索
  startSearch(){
    try{
      this.currPage = 0;
      this.poiQuery = new PoiQuery(this.keyword, "",  this.city);
      //默认base
      // query.setExtensions("all");
      this.poiQuery.setPageNum(this.currPage);
      this.poiQuery.setPageSize(10);
      this.poiQuery.setQueryLanguage(ServiceSettings.ENGLISH)
      this.poiSearch?.setQuery(this.poiQuery);

      //搜索，回调通过OnPoiSearchListener
      this.poiSearch?.searchPOIAsyn()
    }catch (e){
      console.log(`doPoiSearchRequest error: ${JSON.stringify(e)}}`);
    }
  }

  //搜索视图
  @Builder
  buildSearchView() {
    Column(){
      Row({space: 10}){
        TextInput({text: $$this.keyword, placeholder: "请输入关键字"})
          .fontColor("#333")
          .width("50%")
          .borderWidth(1)
          .borderColor(Color.Orange)
        TextInput({text: $$this.city, placeholder: "请输入城市"})
          .fontColor("#333")
          .width("50%")
          .borderWidth(1)
          .borderColor(Color.Orange)
      }
      .width("100%")
      .height(44)

      Row({space: 10}){
        Button("开始搜索")
          .enabled(this.keyword.length > 0)
          .width("50%")
          .onClick(() => {
            //键盘消失
            inputMethod.getController().stopInputSession();
            this.startSearch();
          })
        Button("下一页")
          .width("50%")
          .onClick(() => {
            if(this.pageResult !== null && this.pageResult !== undefined && this.pageResult.getPageCount() - 1 > this.currPage ){
             this.currPage += 1;
             this.poiQuery?.setPageNum(this.currPage);
              this.poiSearch?.searchPOIAsyn()
            }
          })
      }
      .width("100%")
      .height(44)
    }
    .padding(10)
    .width("100%")
    .backgroundColor("#F0F0F0")
  }

  //显示地图
  @Builder
  buildMapShow() {
    MapViewComponent({mapViewName: Constants.MAP_POI_KEYWORD_SEARCH_FUNC })
      .width("100%")
      .layoutWeight(1)
      .padding({
        bottom: this.keyboardHeight - (this.keyboardHeight ? this.uiContext.px2vp(this.indicatorHeight) : 0)
      })
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_POI_KEYWORD_SEARCH_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.aMap = map;
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true);
      hilog.info(0xff, Constants.MAP_POI_KEYWORD_SEARCH_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);
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
      hilog.error(0xff, Constants.MAP_POI_KEYWORD_SEARCH_FUNC, 'err ' + err.message);
    })
  }

  aboutToDisappear(): void {
    window.getLastWindow(this.context).then(currentWindow => {
      currentWindow.off('avoidAreaChange')
    }).catch((err : Error) => {
      hilog.error(0xff, Constants.MAP_POI_KEYWORD_SEARCH_FUNC, 'err ' + err.message);
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
      this.buildSearchView();
      this.buildMapShow();
    }
    .title(Constants.MAP_POI_KEYWORD_SEARCH_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })

  }
}

