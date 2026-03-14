import { AMapUtil } from "../../utils/AMapUtil";
import { Constants } from "../../utils/Constants";
import { CustomTitleBar } from "../../utils/CustomTitleBar";
import { display, MeasureText, UIContext } from "@kit.ArkUI";

export class TruckRouteParam {
  distance: string = "";
  time: string = "";
  routeDetailList: TruckRouteDetail[] = []
  title?: string
}

export class TruckRouteDetail {
  tag: string = ""
  textValue: string = ""

  constructor(tag: string, textValue: string) {
    this.tag = tag
    this.textValue = textValue
  }
}

@Builder
export function TruckRouteDetailControllerBuilder(name: string, param: Object) {
  TruckRouteDetailController()
}

@Component
export struct TruckRouteDetailController {
  @Consume("pageInfos") pageInfos: NavPathStack
  @State
  private routeDetailList: TruckRouteDetail[] = [];
  @State
  time: string = ""
  @State
  distance: string = ""
  screenWidth: number = 0

  aboutToAppear(): void {
    let dis = display.getDefaultDisplaySync();
    this.screenWidth = dis.width
  }

  build() {
    NavDestination() {
      this.buildMapRideRouteDetail();
    }
    .hideTitleBar(true)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
      let param = this.pageInfos.getParamByIndex(1) as TruckRouteParam
      this.routeDetailList = JSON.parse(JSON.stringify(param.routeDetailList))
      this.routeDetailList.push(new TruckRouteDetail('', ''))
      this.routeDetailList.unshift(new TruckRouteDetail('', ''))
      this.time = param.time
      this.distance = param.distance
    })
  }

  measureHeight(contentText: string) {
    const realSize = MeasureText.measureTextSize({
      textContent: contentText,
      constraintWidth: px2vp(this.screenWidth) - 60
    });

    let height: number = px2vp(realSize.height as number)
    if (height < 72) {
      height = 72
    }
    return height
  }

  @Builder
  getListItem(upLineVisible: boolean, tagResource: Resource, downLineVisible: boolean, contentText: string) {
    Row() {
      Column() {
        //上线条
        Line()
          .width(10)
          .height((this.measureHeight(contentText) - 22) / 2)
          .startPoint([5, 0])
          .endPoint([5, (this.measureHeight(contentText) - 22) / 2])
          .stroke(upLineVisible ? '#b6b6b6' : Color.White)
          .strokeWidth(3)
          .strokeLineCap(LineCapStyle.Round)
          .backgroundColor(Color.White)
        // 加载图片
        Image(tagResource).width(22).height(22)
        // 下线条
        Line()
          .width(10)
          .height((this.measureHeight(contentText) - 22) / 2)
          .startPoint([5, 0])
          .endPoint([5, (this.measureHeight(contentText) - 22) / 2])
          .stroke(downLineVisible ? '#b6b6b6' : Color.White)
          .strokeWidth(3)
          .strokeLineCap(LineCapStyle.Round)
          .backgroundColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .width(60)

      Column() {
        Text(`${contentText}`)
          .width('100%')
      }.alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width("100%")
    .height(this.measureHeight(contentText))

    // .constraintSize({minHeight: 72})
  }

  @Builder
  buildMapRideRouteDetail() {
    Column() {
      CustomTitleBar({
        title: Constants.MAP_ROUTETRUCK_DETAIL_FUNC, onPopClick: () => {
          this.pageInfos.pop()
        }
      })
      Row() {
        Column() {
          Line()
            .width('100%')
            .height(0.5)
            .backgroundColor(Color.Black)
          Text(`${this.distance}`)
            .margin({ left: 30 })
            .layoutWeight(1)
          Line()
            .width('100%')
            .height(0.5)
            .backgroundColor('#b6b6b6')
        }
        .backgroundColor(Color.White)
        .height("100%")
        .width(60)
        .justifyContent(FlexAlign.SpaceAround)
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }.justifyContent(FlexAlign.Start)
      .height(70)
      .width("100%")

      List() {
        ForEach(this.routeDetailList, (content: TruckRouteDetail, index: number) => {
          ListItem() {
            if (index === 0) {
              this.getListItem(false, $r("app.media.dir_start"), true, "出发")
            } else if (index === this.routeDetailList.length - 1) {
              this.getListItem(true, $r("app.media.dir_end"), false, "到达终点")
            } else {
              this.getListItem(true, AMapUtil.getDriveActionID(content.tag), true, content.textValue)
            }
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .divider({
        strokeWidth: 0.5,
        color: Color.Black,
        startMargin: 60
      })
    }
    .width('100%')
    .height('100%')
  }
}