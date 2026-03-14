import {
  AMap,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager
} from "@amap/amap_lbs_map3d";

import { Constants } from "../../utils/Constants";
import { CustomContentDialog } from "@kit.ArkUI";
import { utils } from "../../utils/utils";
import { AMapException, OnRoutePlanSearchListener } from "@amap/amap_lbs_search";
import { DriveRoutePlanResult } from "@amap/amap_lbs_search";
import { hilog } from "@kit.PerformanceAnalysisKit";
import { TimeInfo } from "@amap/amap_lbs_search";
import { DrivingRoutePlanOverlay } from "../../overlay/DrivingRoutePlanOverlay";
import { FromAndTo, LatLonPoint, RouteSearch } from "@amap/amap_lbs_search";
import { DrivePlanQuery } from "@amap/amap_lbs_search";
import { ToastUtil } from "../../utils/ToastUtil";

export class ItemValue {
  select: boolean = false
  dateStr: string = ""
  dur: string = ""
}

@Component
export struct MapDriveRoutePlanController {
  clickable: boolean = true
  private mapView?: MapView;
  private aMap?: AMap;
  private mRouteSearch?: RouteSearch;
  private mContext: Context = getContext()
  @Consume("pageInfos") pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  private mStartPoint = new LatLonPoint(39.942295, 116.335891); //起点，39.942295,116.335891
  private mEndPoint = new LatLonPoint(39.995576, 116.481288); //终点，39.995576,116.481288
  @State planArriveTime: number = 0
  @State
  timeList: ItemValue[] = []
  @State
  queryFirstInterval: string = "5"
  @State
  queryInterval: string = "5"
  @State
  commendDiff: string = "5"
  selectedDate: Date = new Date();
  @State
  settingVisiable: Visibility = Visibility.None
  @State
  routeVisiable: Visibility = Visibility.None
  @State
  beginTimeTitle: string = ""
  @State
  arriveTimeTitle: string = ""
  @State
  distanceTextTitle: string = ""
  @State
  setArriveTime: string = ""
  @State
  setArriveTimeTitle: string = ""
  @State
  setArriveTimeVisiable: Visibility = Visibility.None
  @State
  setArriveTimeTitleVisiable: Visibility = Visibility.None
  @State
  beginTime: string = ""
  @State
  arriveTime: string = ""
  @State
  distance: string = ""
  result?: DriveRoutePlanResult

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

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != Constants.MAP_ROUTEDRIVE_PLAN_FUNC) {
      return;
    }

    this.mapView = mapview;

    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.aMap = map;

      hilog.info(0xff, Constants.MAP_SHOW_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom);

      this.aMap?.setOnMapClickListener((point: LatLng) => {
        hilog.info(0xff, Constants.MAP_SHOW_FUNC, `map click ${point.longitude} ${point.latitude}`);
      });
      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
    })

  }
  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomContentDialog({
      primaryTitle: '设置到达时间',
      contentBuilder: () => {
        this.buildContent();
      },
      buttons: [
        {
          value: '确认',
          buttonStyle: ButtonStyleMode.TEXTUAL,
          action: () => {
            const now: Date = new Date()
            const after = new Date(now.getTime() + 48 * utils.queryInterval * 60 * 1000);
            // 比较传入的date是否在after和now之间
            if (this.selectedDate > after) {
              this.planArriveTime = 0
              AlertDialog.show({ message: `请选择最近${48 * utils.queryInterval / 60}小时以内的时间` })
              return
            } else if (this.selectedDate <= now) {
              // 未来
              this.planArriveTime = 0
              AlertDialog.show({ message: "请选择未来时间点" })
              return
            }
            this.planArriveTime = this.selectedDate.getTime() / 1000
          }
        },
        {
          value: '取消',
          buttonStyle: ButtonStyleMode.TEXTUAL,
          role: ButtonRole.ERROR
        }
      ],
    }),
  });
  private onRoutePlanSearchListener: OnRoutePlanSearchListener = {
    onDriveRoutePlanSearched: (result: DriveRoutePlanResult | undefined, errorCode: number): void => {
      // dissmissProgressDialog();
      this.aMap?.clear(false); // 清理地图上的所有覆盖物
      if (errorCode === AMapException.CODE_AMAP_SUCCESS) {
        if (result && result.getPaths()) {
          this.result = result
          this.routeVisiable = Visibility.Visible
          this.timeList = []
          result.getTimeInfos().forEach(info => {
            const item = new ItemValue()
            item.select = false
            item.dateStr = utils.times(info.getStartTime())
            item.dur = info.getElements()[0].getDuration() + "min"
            this.timeList.push(item)
          })
          if (this.planArriveTime > 0) {
            this.beginTimeTitle = "建议出发时间"
            this.arriveTimeTitle = "预计到达时间"
            this.distanceTextTitle = "预计耗时"
            this.setArriveTime = (utils.times(this.planArriveTime));
            this.setArriveTimeTitleVisiable = Visibility.Visible;
            this.setArriveTimeVisiable = Visibility.Visible
            const index = this.setArriveInfo(result, this.planArriveTime);
            this.timeList[index].select = true
            this.clickable = false
            this.drawRoute(index, result)
          } else {
            this.beginTimeTitle = "出发时间"
            this.arriveTimeTitle = "到达时间"
            this.distanceTextTitle = "全部里程"
            this.setArriveTimeTitleVisiable = Visibility.Visible
            this.setArriveTimeVisiable = Visibility.Visible
            this.timeList[0].select = true
            this.clickEvent(0)
            this.setPathInfo(0, true);
            this.clickable = true
            this.drawRoute(0, result)
          }

        } else {
          ToastUtil.show(this.getUIContext(), "对不起，没有搜索到相关数据！");
        }
      } else {
        ToastUtil.showError(this.getUIContext(), errorCode);
      }
    }
  }

  // 自定义弹出框的内容区
  @Builder
  buildContent(): void {
    Column() {
      DatePicker({
        start: new Date('1970-1-1'),
        end: new Date('2100-1-1'),
        selected: this.selectedDate
      })
        .width('80%')
        .height('40%')
        .onDateChange((value: Date) => {
          this.selectedDate.setFullYear(value.getFullYear(), value.getMonth(), value.getDate())
          console.info('select current date is: ' + value.toString());
        })
      TimePicker({
        selected: this.selectedDate
      })
        .useMilitaryTime(true)
        .dateTimeOptions({ hour: "2-digit", minute: "2-digit" })
        .onChange((value: TimePickerResult) => {
          if (value.hour >= 0) {
            this.selectedDate.setHours(value.hour, value.minute);
            console.info('select current date is: ' + this.selectedDate.toString());
          }
        })
        .width('80%')
        .height('40%')
    }
    .alignRules({
      middle: { anchor: "__container__", align: HorizontalAlign.Center },
      center: { anchor: "__container__", align: VerticalAlign.Center },
    })
    .width(300)
    .height(200)
    .backgroundColor(Color.Pink)
    .borderRadius(10)
  }

  build() {
    NavDestination() {
      this.buildMapDrivePlanRoute();
    }
    .title(Constants.MAP_ROUTEDRIVE_PLAN_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      // mock请求数据
    })
    .onBackPressed(() => {
      if (this.routeVisiable === Visibility.Visible) {
        this.routeVisiable = Visibility.None
        this.result = undefined
        this.timeList = []
        this.aMap?.clear()
        return true
      }
      this.pageInfos.pop(); // 弹出路由栈顶元素
      return false
    })
  }

  @Builder
  buildMapDrivePlanRoute() {
    RelativeContainer() {
      MapViewComponent({ mapViewName: Constants.MAP_ROUTEDRIVE_PLAN_FUNC })
        .alignRules({ bottom: { anchor: "__container__", align: VerticalAlign.Bottom } })
        .width('100%')
        .height('100%')
      Button("路线")
        .alignRules(
          {
            bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
            middle: { anchor: "__container__", align: HorizontalAlign.Center },
          }
        )
        .offset({
          bottom: 20
        })
        .onClick(() => {
          this.searchRouteResult()
        })
        .id("routeButton")
      Image($r('app.media.up_time'))
        .alignRules({
          bottom: { anchor: "routeButton", align: VerticalAlign.Top },
          middle: { anchor: "routeButton", align: HorizontalAlign.Center },
        })
        .offset({
          bottom: 30
        })
        .onClick(() => {
          this.selectedDate = new Date()
          this.dialogController.open()
        })
        .height(30)
        .width(30)
      Image($r('app.media.setting'))
        .height(30)
        .width(30)
        .alignRules({
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
          right: { anchor: "__container__", align: HorizontalAlign.End },
        })
        .offset({
          right: 10,
          bottom: 10
        })
        .onClick(() => {
          this.queryFirstInterval = utils.queryFirstInterval.toString()
          this.queryInterval = utils.queryInterval.toString()
          this.commendDiff = utils.commendDiff.toString()
          this.settingVisiable = Visibility.Visible
        })

      Column() {
        Row() {
          Column() {
            Text("首个查询间隔")
            TextInput({ text: $$this.queryFirstInterval }).textAlign(TextAlign.Center)
          }.height('100%').width(100).backgroundColor(Color.White).justifyContent(FlexAlign.SpaceAround)

          Column() {
            Text("查询时间间隔")
            TextInput({ text: $$this.queryInterval }).textAlign(TextAlign.Center)
          }.height('100%').width(100).backgroundColor(Color.White).justifyContent(FlexAlign.SpaceAround)

          Column() {
            Text("允许偏差")
            TextInput({ text: $$this.commendDiff }).textAlign(TextAlign.Center)
          }.height('100%').width(100).backgroundColor(Color.White).justifyContent(FlexAlign.SpaceAround)
        }
        .width('100%')
        .height('50%')
        .margin({ top: 20 })
        .justifyContent(FlexAlign.SpaceAround)

        Row() {
          Button("确认")
            .onClick(() => {
              let MAX_VALUE = 0x7fffffff//Integer.MAX_VALUE
              utils.queryFirstInterval = Number(this.queryFirstInterval)
              if(utils.queryFirstInterval >= MAX_VALUE){
                utils.queryFirstInterval = MAX_VALUE
              }
              if(!this.queryFirstInterval || Number.isNaN(utils.queryFirstInterval)){
                utils.queryFirstInterval = 5
              }
              utils.queryInterval = Number(this.queryInterval)
              if(utils.queryInterval >= MAX_VALUE){
                utils.queryInterval = MAX_VALUE
              }
              if(!this.queryInterval || Number.isNaN(utils.queryInterval)){
                utils.queryInterval = 5
              }
              utils.commendDiff = Number(this.commendDiff)
              if(utils.commendDiff >= MAX_VALUE){
                utils.commendDiff = MAX_VALUE
              }
              if(!this.commendDiff || Number.isNaN(utils.commendDiff)){
                utils.commendDiff = 5
              }
              this.settingVisiable = Visibility.None
            })
        }
        .width('100%')
        .height('50%')
        .justifyContent(FlexAlign.Center)
      }
      .alignRules({
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
        middle: { anchor: "__container__", align: HorizontalAlign.Center },
      })
      .width('100%')
      .height(300)
      .backgroundColor(Color.Blue)
      .visibility(this.settingVisiable)

      Column() {
        Row() {
          Column() {
            Text(`${this.beginTimeTitle}`).textAlign(TextAlign.Center)
            Text(`${this.beginTime}`).textAlign(TextAlign.Center)
          }.height('100%').width(100).backgroundColor(Color.White).justifyContent(FlexAlign.SpaceAround)

          Column() {
            Text(`${this.arriveTimeTitle}`).textAlign(TextAlign.Center)
            Text(`${this.arriveTime}`).textAlign(TextAlign.Center)
          }.height('100%').width(100).backgroundColor(Color.White).justifyContent(FlexAlign.SpaceAround)

          Column() {
            Text(`${this.distanceTextTitle}`).textAlign(TextAlign.Center)
            Text(`${this.distance}`).textAlign(TextAlign.Center)
          }.height('100%').width(100).backgroundColor(Color.White).justifyContent(FlexAlign.SpaceAround)
        }
        .width('100%')
        .height(100)
        .margin({ top: 20 })
        .justifyContent(FlexAlign.SpaceAround)

        Row() {
          Row() {
            Text("设定到达时间").textAlign(TextAlign.Center)
            Text(`${utils.times(this.planArriveTime)}`).textAlign(TextAlign.Center)
          }
          .width('66%')
          .justifyContent(FlexAlign.SpaceAround)
        }
        .width('100%')
        .height(20)
        .margin({ top: 20 })
        .visibility(this.planArriveTime > 0 ? Visibility.Visible : Visibility.None)

        Row() {
          List() {
            ForEach(this.timeList, (item: ItemValue, index: number) => {
              ListItem() {
                Column() {
                  Text(`${item.dur}`).height(50).fontSize(item.select ? 20 : 15)
                  Column() {
                    Column().width(20).height('100%').backgroundColor(item.select ? Color.Blue : Color.Brown)
                      .onClick(() => {
                        this.clickEvent(index)
                      })
                    Divider()
                  }.layoutWeight(1).width('100%')

                  Text(`${item.dateStr}`).height(50)
                }
                .width(60)
                .height('100%')
                .justifyContent(FlexAlign.SpaceEvenly)
              }
            }, (item: ItemValue, index: number) => {
              return String(item.select) + index
            })
          }
          .listDirection(Axis.Horizontal)
          .scrollBar(BarState.Off)
          .height('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
      .alignRules({
        bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
        middle: { anchor: "__container__", align: HorizontalAlign.Center },
      })
      .width('100%')
      .height(300)
      .backgroundColor(Color.Yellow)
      .visibility(this.routeVisiable)
    }
    .width('100%')
    .height('100%')
  }

  aboutToAppear() {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
    this.mRouteSearch = new RouteSearch(this.mContext);
    this.mRouteSearch?.setOnRoutePlanSearchListener(this.onRoutePlanSearchListener);
    hilog.info(0xff, Constants.MAP_SHOW_FUNC, "aboutToAppear");
  }

  clickEvent(index: number) {
    const item = this.timeList[index]
    if (item.select || !this.clickable) {
      return
    }
    this.timeList.forEach(value => {
      if (value.select) {
        value.select = false
      }
    })
    let a: ItemValue = {
      dateStr: item.dateStr,
      select: true,
      dur: item.dur
    }
    this.timeList[index] = a
    this.setPathInfo(index, true);
    if (this.result) {
      this.drawRoute(index, this.result)
    }
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

  private setArriveInfo(result: DriveRoutePlanResult, arriveTime: number) {
    let lastIndex = -1;

    for (let i = 0; i < result.getTimeInfos().length; i++) {
      let info: TimeInfo = result.getTimeInfos()[i];
      if (info.getElements().length < 0) {
        // Log.e("","getElementsCount error:" + info.getElements().length);
        return lastIndex;
      }
      const element = info.getElements()[0];
      if (info.getStartTime() + element.getDuration() * 60 <= arriveTime - utils.commendDiff * 60) {
        lastIndex = i;
      } else {
        break;
      }
    }
    this.setPathInfo(lastIndex, false);

    return lastIndex;
  }

  private setPathInfo(index: number, setDistance: boolean) {
    if (index >= 0 && this.result && this.result?.getTimeInfos().length > index) {
      const info = this.result.getTimeInfos()[index];
      const element = info.getElements()[0];
      this.beginTime = utils.times(info.getStartTime());
      this.arriveTime = String(utils.times(info.getStartTime() + element.getDuration() * 60));
      const path = this.result.getPaths()[element.getPathindex()];
      if (setDistance) {
        this.distance = String((Math.floor(path.getDistance() / 1000)))
      } else {
        this.distance = String(element.getDuration()) + "分";
      }
    } else {
      this.beginTime = "error";
      this.arriveTime = "error";
      this.distance = "error";
    }
  }

  private drawRoute(index: number, mDriveRoutePlanResult: DriveRoutePlanResult) {
    this.aMap?.clear()
    const drivingRouteOverlay: DrivingRoutePlanOverlay = new DrivingRoutePlanOverlay(
      this.mContext, this.aMap as AMap, mDriveRoutePlanResult, index);
    drivingRouteOverlay.setNodeIconVisibility(false); //设置节点marker是否显示
    drivingRouteOverlay.setIsColorfulline(true); //是否用颜色展示交通拥堵情况，默认true
    drivingRouteOverlay.removeFromMap();
    drivingRouteOverlay.addToMap();
    drivingRouteOverlay.zoomToSpan();
  }

  /**
   * 开始搜索路径规划方案
   */
  public searchRouteResult() {
    if (!this.mStartPoint) {
      // 下一版本添加此功能
      // ToastUtil.show(mContext, "定位中，稍后再试...");
      return;
    }
    if (!this.mEndPoint) {
      // ToastUtil.show(mContext, "终点未设置");
    }
    // 下一版本添加此功能
    // showProgressDialog();
    const fromAndTo = new FromAndTo(
      this.mStartPoint, this.mEndPoint);
    const time = Math.floor(Date.now() / 1000)
    const query = new DrivePlanQuery(fromAndTo, time + utils.queryFirstInterval * 60, utils.queryInterval * 60,
      48); // 第一个参数表示路径规划的起点和终点，第二个参数表示驾车模式，第三个参数表示途经点，第四个参数表示避让区域，第五个参数表示避让道路
    this.mRouteSearch?.calculateDrivePlanAsyn(query); // 异步路径规划驾车模式查询
  }
}