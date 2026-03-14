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
  BusStationQuery,
  BusStationResult,
  BusStationSearch,
  OnBusStationSearchListener
} from "@amap/amap_lbs_search";
import { ToastUtil } from "../../utils/ToastUtil";
import { Loading } from "../../utils/Loading";
import { window } from "@kit.ArkUI";

@Component
export struct BusStationController {
  private aMap?: AMap;
  private mapView?: MapView;
  private mContext: Context = getContext();
  @Consume("pageInfos") pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private itemCitys: SelectOption[] = [{ value: "北京-010" }, { value: "郑州-0371" }, { value: "上海-021" }];
  private busLineQuery?: BusStationQuery; // 公交线路查询的查询类
  private busLineSearch?: BusStationSearch; // 公交线路列表查询
  @State selectItem: string = "北京-010"
  @State searchName: string = ''; // 输入公交线路名称
  @State isLoading: boolean = false
  @State keyboardHeight: number = 0
  private indicatorHeight: number = 0
  private busStationSearchListener: OnBusStationSearchListener = {
    onBusStationSearched: (result: BusStationResult | undefined, rCode: number) => {
      this.isLoading = false
      if (rCode == AMapException.CODE_AMAP_SUCCESS) {
        if (result && result.getPageCount() > 0
          && result.getBusStations() != null
          && result.getBusStations().length > 0) {
          let item = result.getBusStations()
          let buf: string[] = [];
          for (let i = 0; i < item.length; i++) {
            let stationItem = item[i];
            buf.push(" station: ")
            buf.push(i.toString())
            buf.push(" name: ")
            buf.push(stationItem.getBusStationName() ?? '');
          }
          let text = buf.join('');
          this.getUIContext().getPromptAction().showToast({ message: text, duration: 3000 })
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
    // currentpage = 0;// 第一页默认从0开始
    this.isLoading = true
    let search = this.searchName.trim();
    if ("" === search) {
      search = "望京";
      this.searchName = search;
    }
    this.busLineQuery =
      new BusStationQuery(search, this.getCityCode()); // 第一个参数表示公交线路名，第二个参数表示公交线路查询，第三个参数表示所在城市名或者城市区号
    //		busLineQuery.setPageSize(10);// 设置每页返回多少条数据
    // busLineQuery.setPageNumber(currentpage);// 设置查询第几页，第一页从0开始算起
    try {
      this.busLineSearch = new BusStationSearch(this.mContext, this.busLineQuery); // 设置条件
    } catch (e) {
      console.log('BusStationController', JSON.stringify(e))
    }
    this.busLineSearch?.setOnBusStationSearchListener(this.busStationSearchListener); // 设置查询结果的监听

    this.busLineSearch?.setQuery(new BusStationQuery(search, this.getCityCode()));
    this.busLineSearch?.searchBusStationAsyn();
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_BUSSTATIONQUERY_FUNC) {
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
    .title(Constants.MAP_BUSSTATIONQUERY_FUNC)
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
        TextInput({ text: $$this.searchName, placeholder: '请输入站点名称' })
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
        Button('公交站点查询')
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

      MapViewComponent({ mapViewName: Constants.MAP_BUSSTATIONQUERY_FUNC })
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
      hilog.error(0xff, Constants.MAP_BUSSTATIONQUERY_FUNC, 'err ' + err.message);
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
