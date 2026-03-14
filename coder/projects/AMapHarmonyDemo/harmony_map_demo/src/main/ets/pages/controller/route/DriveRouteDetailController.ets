import { AMapUtil } from "../../utils/AMapUtil";
import { Constants } from "../../utils/Constants";

export class DriveRouteParam {
  routeName: string = ""
  distance: string = "";
  time: string = "";
  routeDetailList: RouteDetail[] = []
}
export class RouteDetail{
  tag: string = ""
  textValue: string = ""
  constructor(tag: string, textValue: string) {
    this.tag = tag
    this.textValue = textValue
  }
}
@Builder
export function DriveRouteDetailControllerBuilder(name: string, param: Object) {
  DriveRouteDetailController()
}
@Component
export struct DriveRouteDetailController{
  @Consume("pageInfos") pageInfos: NavPathStack
  @State
  private routeDetailList: RouteDetail[] = [];
  @State
  time: string = ""
  @State
  distance: string = ""
  @State
  routeName: string = ""

  build() {
    NavDestination() {
      this.buildMapDriveRouteDetail();
    }
    .title(this.routeName)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack
      let param = this.pageInfos.getParamByIndex(1) as DriveRouteParam
      this.routeDetailList = param.routeDetailList
      this.time = param.time
      this.distance = param.distance
      this.routeName = param.routeName
    })
  }
  @Builder
  getListItem(upLineVisible: boolean, tagResource: Resource, downLineVisible: boolean, contentText: string){
    Row() {
      Column(){
        //上线条
        Line()
          .width(10)
          .height(20)
          .startPoint([5, 0])
          .endPoint([5, 20])
          .stroke(upLineVisible?Color.Black:Color.White)
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
          .stroke(downLineVisible?Color.Black:Color.White)
          .strokeWidth(3)
          .strokeLineCap(LineCapStyle.Round)
          .backgroundColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .width(50)
      Column(){
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
  buildMapDriveRouteDetail() {
    Column() {
      Row(){
        Column(){
          Text(`${this.distance}`)
          Text(`${this.time}`)
        }.backgroundColor(Color.Pink).height("100%").width(100).padding({
          left: 30
        })
        .justifyContent(FlexAlign.SpaceAround)
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }.justifyContent(FlexAlign.Start)
      .height(80)
      .width("100%")
      List() {
        this.getListItem(false, $r("app.media.dir_start"), true, "出发")
        ForEach(this.routeDetailList, (content: RouteDetail, index: number) => {
          ListItem() {
            this.getListItem(true, AMapUtil.getDriveActionID(content.tag), true, content.textValue)
          }
        })
        this.getListItem(true, $r("app.media.dir_end"), false, "到达终点")
      }.width('100%')
      .layoutWeight(1)
      .divider({
        strokeWidth: 0.5,
        color: Color.Black,
        startMargin: 50
      })
    }.width('100%')
    .height('100%')
  }
}