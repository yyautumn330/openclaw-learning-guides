import { AMapUtil } from "../../utils/AMapUtil";
import { Constants } from "../../utils/Constants";
import { CustomTitleBar } from "../../utils/CustomTitleBar";

export class WalkRouteParam {
  distance: string = "";
  time: string = "";
  routeDetailList: WalkRouteDetail[] = []
}

export class WalkRouteDetail {
  tag: string = ""
  textValue: string = ""

  constructor(tag: string, textValue: string) {
    this.tag = tag
    this.textValue = textValue
  }
}

@Builder
export function WalkRouteDetailControllerBuilder(name: string, param: Object) {
  WalkRouteDetailController()
}

@Component
export struct WalkRouteDetailController {
  @Consume("pageInfos") pageInfos: NavPathStack
  @State
  private routeDetailList: WalkRouteDetail[] = [];
  @State
  time: string = ""
  @State
  distance: string = ""

  build() {
    NavDestination() {
      this.buildMapWalkRouteDetail();
    }
    .hideTitleBar(true)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
      let param = this.pageInfos.getParamByIndex(1) as WalkRouteParam
      this.routeDetailList = param.routeDetailList
      this.time = param.time
      this.distance = param.distance
    })
  }

  @Builder
  getListItem(upLineVisible: boolean, tagResource: Resource, downLineVisible: boolean, contentText: string) {
    Row() {
      Column() {
        //上线条
        Line()
          .width(10)
          .height(20)
          .startPoint([5, 0])
          .endPoint([5, 20])
          .stroke(upLineVisible ? '#b6b6b6' : Color.White)
          .strokeWidth(3)
          .strokeLineCap(LineCapStyle.Round)
          .backgroundColor(Color.White)
        // 加载图片
        Image(tagResource).width(22).height(22)
        // 下线条
        Line()
          .width(10)
          .height(20)
          .startPoint([5, 0])
          .endPoint([5, 20])
          .stroke(downLineVisible ? '#b6b6b6' : Color.White)
          .strokeWidth(3)
          .strokeLineCap(LineCapStyle.Round)
          .backgroundColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .width(60)

      Column() {
        Text(`${contentText}`)
      }.alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width("100%")
    .height(62)

    // .constraintSize({minHeight: 44})
  }

  @Builder
  buildMapWalkRouteDetail() {
    Column() {
      CustomTitleBar({
        title: Constants.MAP_ROUTEWALK_DETAIL_FUNC, onPopClick: () => {
          this.pageInfos.pop()
        }
      })

      Divider()

      Row() {
        Column() {
          Text(`${this.distance}`)
          Text(`${this.time}`)
        }
        .backgroundColor(Color.White)
        .height("100%")
        .width(100)
        .padding({
          left: 30
        })
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }.justifyContent(FlexAlign.Start)
      .height(80)
      .width("100%")

      Divider()

      List() {
        ListItem() {
          this.getListItem(false, $r("app.media.dir_start"), true, "出发")
        }

        ForEach(this.routeDetailList, (content: WalkRouteDetail, index: number) => {
          ListItem() {
            this.getListItem(true, AMapUtil.getWalkActionID(content.tag), true, content.textValue)
          }
        })
        ListItem() {
          this.getListItem(true, $r("app.media.dir_end"), false, "到达终点")
        }
      }
      .layoutWeight(1)
      .height('100%')
      .divider({
        strokeWidth: 0.5,
        color: Color.Black,
        startMargin: 60
      })
    }.width('100%')
    .height('100%')
  }
}