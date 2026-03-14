import {
  AMap,
  AMapOptions,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager
} from "@amap/amap_lbs_map3d";
import { Constants } from "../../utils/Constants";
import { hilog } from "@kit.PerformanceAnalysisKit";
import {
  AMapException,
  BusLineItem,
  BusLineQuery,
  BusLineResult,
  BusLineSearch,
  BusSearchType,
  OnBusLineSearchListener,
} from "@amap/amap_lbs_search";
import { ToastUtil } from "../../utils/ToastUtil";
import { Loading } from "../../utils/Loading";
import { ArrayList } from "@kit.ArkTS";
import { BusLineDialog } from "./BusLineDialog";
import { BusLineOverlay } from "../../overlay/BusLineOverlay";
import { window } from "@kit.ArkUI";

@Component
export struct BusLineController {
  private aMap?: AMap;
  private mapView?: MapView;
  private mContext: Context = getContext();
  @Consume("pageInfos") pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private itemCitys: SelectOption[] = [{ value: "北京-010" }, { value: "郑州-0371" }, { value: "上海-021" }];
  private cityCode = ""; // 城市区号
  private busLineQuery?: BusLineQuery; // 公交线路查询的查询类
  private busLineSearch?: BusLineSearch; // 公交线路列表查询
  private busLineResult?: BusLineResult; // 公交线路搜索返回的结果
  private lineItems: ArrayList<BusLineItem> = new ArrayList<BusLineItem>(); // 公交线路搜索返回的busline
  private isClick: boolean = false
  @State currentPage: number = 0; // 公交搜索当前页，第一页从0开始
  @State lineList: BusLineItem[] = []
  @State selectItem: string = "北京-010"
  @State searchName: string = ''; // 输入公交线路名称
  @State isLoading: boolean = false
  @State keyboardHeight: number = 0
  private indicatorHeight: number = 0

  //弹窗
  dialogController: CustomDialogController = new CustomDialogController({
    builder: BusLineDialog({
      lineItems: this.lineList,
      currentPage: this.currentPage,
      totalPage: this.busLineResult?.getPageCount(),
      onClickItem: (item: BusLineItem) => {
        let lineId = item.getBusLineId() ?? ''; // 得到当前点击item公交线路id
        this.busLineQuery = new BusLineQuery(lineId, BusSearchType.BY_LINE_ID,
          this.cityCode); // 第一个参数表示公交线路id，第二个参数表示公交线路id查询，第三个参数表示所在城市名或者城市区号
        let busLineSearch: BusLineSearch | undefined = undefined;
        try {
          busLineSearch = new BusLineSearch(this.mContext, this.busLineQuery);
        } catch (e) {
          console.log('BusLineController', JSON.stringify(e))
        }
        busLineSearch?.setOnBusLineSearchListener(this.busLineSearchListener);
        busLineSearch?.searchBusLineAsyn(); // 异步查询公交线路id
      },
      onClickPre: () => {
        this.isClick = true
        this.isLoading = true
        this.busLineQuery?.setPageNumber(--this.currentPage);// 设置公交查询第几页
        this.busLineSearch?.setOnBusLineSearchListener(this.busLineSearchListener);
        this.busLineSearch?.searchBusLineAsyn();// 异步查询公交线路名称
      },
      onClickNext: () => {
        this.isClick = true
        this.isLoading = true
        this.busLineQuery?.setPageNumber(++this.currentPage);// 设置公交查询第几页
        this.busLineSearch?.setOnBusLineSearchListener(this.busLineSearchListener);
        this.busLineSearch?.searchBusLineAsyn();// 异步查询公交线路名称
      }
    }),
    customStyle: true // 启用自定义样式
  })
  private busLineSearchListener: OnBusLineSearchListener = {
    onBusLineSearched: (result: BusLineResult | undefined, rCode: number) => {
      this.isLoading = false
      if (rCode == AMapException.CODE_AMAP_SUCCESS) {
        if (result && result.getQuery() != null
          && result.getQuery().equals(this.busLineQuery as object)) {
          if (result.getQuery().getCategory() == BusSearchType.BY_LINE_NAME) {
            if (result.getPageCount() > 0
              && result.getBusLines() != null
              && result.getBusLines().length > 0) {
              this.busLineResult = result;
              this.lineItems = result.getBusLines();
              if (this.lineItems.length > 0) {
                this.getLineList()
                if (!this.isClick) {
                  //跳转页面
                  this.dialogController.open()
                }
              }
            }
          } else if (result.getQuery().getCategory() == BusSearchType.BY_LINE_ID) {
            this.aMap?.clear(); // 清理地图上的marker
            this.busLineResult = result;
            this.lineItems = this.busLineResult.getBusLines();
            if (this.lineItems && this.lineItems.length > 0) {
              //绘制路线
              let busLineOverlay = new BusLineOverlay(this.mContext, this.aMap as AMap, this.lineItems[0]);
              busLineOverlay.removeFromMap();
              busLineOverlay.addToMap();
              busLineOverlay.zoomToSpan();
            }
          }
        } else {
          ToastUtil.show(this.getUIContext(), '对不起，没有搜索到相关数据！');
        }
      } else {
        ToastUtil.showError(this.getUIContext(), rCode);
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

  getLineList() {
    let lineList: BusLineItem[] = []
    for (let index = 0; index < this.lineItems.length; index++) {
      lineList.push(this.lineItems[index])
    }
    this.lineList = lineList
  }

  getCityCode() {
    let nameList = this.selectItem.split('-')
    if (nameList.length == 2) {
      return nameList[1]
    } else {
      return ''
    }
  }

  /**
   * 公交线路搜索
   */
  searchLine() {
    this.isClick = false
    this.isLoading = true;
    this.currentPage = 0; // 第一页默认从0开始
    let search = this.searchName.trim();
    if ("" === search) {
      search = "641";
      this.searchName = search;
    }
    this.busLineQuery = new BusLineQuery(search, BusSearchType.BY_LINE_NAME,
      this.getCityCode()); // 第一个参数表示公交线路名，第二个参数表示公交线路查询，第三个参数表示所在城市名或者城市区号
    this.busLineQuery.setPageSize(10); // 设置每页返回多少条数据
    this.busLineQuery.setPageNumber(this.currentPage); // 设置查询第几页，第一页从0开始算起
    try {
      this.busLineSearch = new BusLineSearch(this.mContext, this.busLineQuery); // 设置条件
    } catch (e) {
      console.log('BusLineController', JSON.stringify(e));
    }
    this.busLineSearch?.setOnBusLineSearchListener(this.busLineSearchListener); // 设置查询结果的监听
    this.busLineSearch?.searchBusLineAsyn(); // 异步查询公交线路名称
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_BUS_LINE_QUERY_FUNC) {
      return;
    }

    this.mapView = mapview;
    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.aMap = map;

      hilog.info(0xff, Constants.MAP_BUSSTATIONQUERY_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

      this.aMap?.setOnMapClickListener((point: LatLng) => {
        hilog.info(0xff, Constants.MAP_BUSSTATIONQUERY_FUNC, `map click ${point.longitude} ${point.latitude}`);
      });
      this.aMap.getUiSettings()?.setScaleControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomPosition(AMapOptions.ZOOM_POSITION_RIGHT_BUTTOM)
    })
  }

  build() {
    NavDestination() {
      Loading({ isLoading: this.isLoading })
      this.buildMapDriveRoute();
    }
    .title(Constants.MAP_BUS_LINE_QUERY_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      // mock请求数据
    })
  }

  @Builder
  buildMapDriveRoute() {
    Column() {
      Row() {
        TextInput({ text: $$this.searchName, placeholder: '请输入公交线路名' })
          .width('60%')
          .border({
            width: 2,
            color: Color.Orange,
            radius: 2
          })
          .margin({ right: 5 })
          .height('100%')
          .backgroundColor(Color.White)

        Select(this.itemCitys)
          .layoutWeight(1)
          .value($$this.selectItem)
          .border({
            width: 1,
            radius: 2
          })
          .height('100%')
          .backgroundColor('#eeeeee')
      }
      .padding({
        left: 5,
        right: 5,
        top: 5,
        bottom: 5
      })
      .height(50)
      .backgroundColor('#eeeeee')

      Row() {
        Button('线路名称查询')
          .border({
            width: 1,
            radius: 2
          })
          .backgroundColor('#eeeeee')
          .padding({
            left: 10,
            right: 10,
            top: 15,
            bottom: 15
          })
          .type(ButtonType.ROUNDED_RECTANGLE)
          .fontColor(Color.Black)
          .onClick(() => {
            this.searchLine()
          })
      }
      .width('100%')
      .padding({ left: 5, bottom: 5 })

      MapViewComponent({ mapViewName: Constants.MAP_BUS_LINE_QUERY_FUNC })
        .layoutWeight(1)
        .padding({
          bottom: this.keyboardHeight - (this.keyboardHeight ? this.getUIContext().px2vp(this.indicatorHeight) : 0)
        })
    }
    .width('100%')
    .height('100%')
  }

  async aboutToAppear(): Promise<void> {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
    let navigationIndicatorType = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR;
    window.getLastWindow(this.getUIContext().getHostContext()).then(currentWindow => {
      let avoidArea = currentWindow.getWindowAvoidArea(navigationIndicatorType);
      // Get the height of the navigation bar area
      this.indicatorHeight = avoidArea.bottomRect.height
      currentWindow.on('avoidAreaChange', data => {
        if (data.type === window.AvoidAreaType.TYPE_KEYBOARD) {
          this.keyboardHeight = this.getUIContext().px2vp(data.area.bottomRect.height)
        }
      })
    }).catch((err : Error) => {
      hilog.error(0xff, Constants.MAP_BUSSTATIONQUERY_FUNC, 'err ' + err.message);
    })
    hilog.info(0xff, Constants.MAP_BUSSTATIONQUERY_FUNC, "aboutToAppear");
  }

  aboutToDisappear(): void {
    window.getLastWindow(this.getUIContext().getHostContext()).then(currentWindow => {
      currentWindow.off('avoidAreaChange')
    }).catch((err : Error) => {
      hilog.error(0xff, Constants.MAP_BUS_LINE_QUERY_FUNC, 'err ' + err.message);
    })
    if (this.mapViewCreateCallback) {
      MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    }

    if (this.mapView) {
      this.mapView.onDestroy();
      this.mapView = undefined;
      this.aMap = undefined;
      hilog.info(0xff, Constants.MAP_BUSSTATIONQUERY_FUNC, "aboutToDisappear");
    }
  }
}
