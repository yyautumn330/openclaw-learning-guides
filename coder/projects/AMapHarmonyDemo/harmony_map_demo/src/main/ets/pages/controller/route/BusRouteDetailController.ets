import { AMapUtil } from "../../utils/AMapUtil"
import { Constants } from "../../utils/Constants"
import { BusParamInfo, BusRoutePath } from "./BusRoutePathsController"
import { CustomTitleBar } from "../../utils/CustomTitleBar"
import { JSON } from "@kit.ArkTS"
import { TaxiItem } from "@amap/amap_lbs_search"

@Builder
export function BusRouteDetailControllerBuilder(name: string, param: Object) {
  BusRouteDetailController()
}

@Component
export struct BusRouteDetailController {
  @Consume("pageInfos") pageInfos: NavPathStack
  @State busRoutePaths: BusRoutePath[] = []
  @State taxiCost: number = 0
  @State totalTime: number = 0
  @State totalRoute: number = 0
  @State walkRoutePaths: number[] = []
  @State taxiRoutePath: TaxiItem = new TaxiItem()
  private paramInfo: BusParamInfo = {} as BusParamInfo

  build() {
    NavDestination() {
      this.buildMapBusRouteDetail();
    }
    .hideTitleBar(true)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack

      this.paramInfo = this.pageInfos.getParamByIndex(1) as BusParamInfo
      this.taxiCost = this.paramInfo.taxiCost
      this.totalTime = this.paramInfo.busRouteInfo.totalTime
      this.totalRoute = this.paramInfo.busRouteInfo.totalRoute

      this.busRoutePaths = this.paramInfo.busRouteInfo.busRoutePaths
      this.walkRoutePaths = this.paramInfo.busRouteInfo.walkPaths
      this.taxiRoutePath = this.paramInfo.busRouteInfo.Taxi
    })
  }

  @Builder
  buildMapBusRouteDetail() {
    Column() {
      CustomTitleBar({
        title: Constants.MAP_ROUTEBUS_DETAIL_FUNC,
        rightTitle: '地图',
        onPopClick: () => {
          this.pageInfos.pop()
        },
        onRightClick: () => {
          this.pageInfos.pushPath({ name: 'BusRouteController', param: this.paramInfo })
        }
      })

      Divider()

      Row() {
        Column() {
          Text(AMapUtil.getFriendlyTime(this.totalTime) +
            '(' + AMapUtil.getFriendlyLength(this.totalRoute) + ')')
            .margin({ top: 20, bottom: 10 })
            .fontSize(20)

          Text('打车约' + this.taxiCost + '元')
            .margin({ bottom: 20 })
            .fontSize(14)
            .fontColor('#999999')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
      }
      .padding({ left: 20 })

      Divider()

      Column() {
        List() {
          ListItem() {
            createBaseItem({
              tagResource: $r("app.media.dir_start"),
              upLineVisible: false,
              downLineVisible: true,
              contentText: "出发",
            })
          }

          ForEach(this.busRoutePaths, (item: BusRoutePath, index: number) => {
            //步行
            if (this.walkRoutePaths[index] && this.walkRoutePaths[index] > 0) {
              ListItem() {
                createBaseItem({
                  tagResource: $r("app.media.dir13"),
                  upLineVisible: true,
                  downLineVisible: true,
                  contentText: '步行' + this.walkRoutePaths[index] + '米',
                })
              }
            }
            //公交 铁路
            if (item.name) {
              ListItem() {
                Column() {
                  createBusItem({
                    tagResource: item.isRailway ? $r("app.media.dir16") : $r("app.media.dir14"),
                    upLineVisible: true,
                    downLineVisible: true,
                    contentText: item.name.split('/')[0],
                    busPath: item,
                  })
                }
              }
            }
          })
          //打车
          if (this.taxiRoutePath && this.taxiRoutePath.getmSname()) {
            createBaseItem({
              tagResource: $r("app.media.dir14"),
              upLineVisible: true,
              downLineVisible: true,
              contentText: "打车到终点",
            })
          }

          ListItem() {
            createBaseItem({
              tagResource: $r("app.media.dir_end"),
              upLineVisible: true,
              downLineVisible: false,
              contentText: "到达终点",
            })
          }
        }
        // .layoutWeight(1)
        // .height(LayoutPolicy.matchParent)
        .divider({
          strokeWidth: 0.5,
          color: '#999999',
          startMargin: 60,
        })
        .backgroundColor(Color.White)
      }
      .layoutWeight(1)
      .backgroundColor('#eeeeee')
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct createBaseItem {
  @Prop tagResource: Resource | undefined
  @Prop upLineVisible: boolean
  @Prop downLineVisible: boolean
  @State contentText: string = ''

  build() {
    Row() {
      Column() {
        //上线条
        Line()
          .width(10)
          .height(this.tagResource ? 15 : 10)
          .startPoint([5, 0])
          .endPoint([5, this.tagResource ? 20 : 10])
          .stroke(this.upLineVisible ? '#b6b6b6' : Color.White)
          .strokeWidth(3)
          .strokeLineCap(LineCapStyle.Round)
          .backgroundColor(Color.White)
        // 加载图片
        if (this.tagResource) {
          Image(this.tagResource).width(20).height(20)
            .margin({ top: 3, bottom: 3 })
        } else {
          Row()
            .width(10)
            .height(10)
            .border({
              color: '#b6b6b6',
              width: 3,
              radius: 5
            })
            .margin({ top: 3, bottom: 3 })
        }
        // 下线条
        Line()
          .width(10)
          .height(this.tagResource ? 15 : 10)
          .startPoint([5, 0])
          .endPoint([5, this.tagResource ? 20 : 10])
          .stroke(this.downLineVisible ? '#b6b6b6' : Color.White)
          .strokeWidth(3)
          .strokeLineCap(LineCapStyle.Round)
          .backgroundColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .width(60)

      Row() {
        Text(`${this.contentText}`)
          .fontSize(12)
          .fontColor(this.tagResource ? '#000000' : '#999999')
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ right: 10 })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width("100%")
    .height(this.tagResource ? 56 : 36)
  }
}

@Component
struct createBusItem {
  @Prop tagResource: Resource | undefined
  @Prop upLineVisible: boolean
  @Prop downLineVisible: boolean
  @State contentText: string = ''
  @ObjectLink busPath: BusRoutePath

  build() {
    Column() {
      Row() {
        Column() {
          //上线条
          Line()
            .width(10)
            .height(this.tagResource ? 15 : 10)
            .startPoint([5, 0])
            .endPoint([5, this.tagResource ? 20 : 10])
            .stroke(this.upLineVisible ? '#b6b6b6' : Color.White)
            .strokeWidth(3)
            .strokeLineCap(LineCapStyle.Round)
            .backgroundColor(Color.White)
          // 加载图片
          if (this.tagResource) {
            Image(this.tagResource).width(20).height(20)
              .margin({ top: 3, bottom: 3 })
          } else {
            Row()
              .width(10)
              .height(10)
              .border({
                color: '#b6b6b6',
                width: 3,
                radius: 5
              })
              .margin({ top: 3, bottom: 3 })
          }
          // 下线条
          Line()
            .width(10)
            .height(this.tagResource ? 15 : 10)
            .startPoint([5, 0])
            .endPoint([5, this.tagResource ? 20 : 10])
            .stroke(this.downLineVisible ? '#b6b6b6' : Color.White)
            .strokeWidth(3)
            .strokeLineCap(LineCapStyle.Round)
            .backgroundColor(Color.White)
        }
        .justifyContent(FlexAlign.Center)
        .width(60)

        Row() {
          Text(`${this.contentText}`)
            .fontSize(12)
            .fontColor(this.tagResource ? '#000000' : '#999999')

          if (this.busPath.name) {
            Row() {
              Text(this.busPath.busStations.length - 1 + '站')
                .fontSize(12)
                .fontColor(Color.Blue)
                .margin({ right: 10 })

              Image($r('app.media.down'))
                .width(15)
            }
          } else {
            Text('')
          }
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ right: 10 })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width("100%")
      .height(this.tagResource ? 56 : 36)
      .onClick(() => {
        this.busPath.isExpand = !this.busPath.isExpand
      })

      if (this.busPath.isExpand) {
        //站点
        ForEach(this.busPath.busStations, (station: string) => {
          createBaseItem({
            tagResource: undefined,
            upLineVisible: true,
            downLineVisible: true,
            contentText: station
          })
        })
      }
    }
  }
}