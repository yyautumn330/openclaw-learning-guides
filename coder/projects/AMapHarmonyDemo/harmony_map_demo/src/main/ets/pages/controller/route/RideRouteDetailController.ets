import { AMapUtil } from "../../utils/AMapUtil";
import { Constants } from "../../utils/Constants";
import { CustomTitleBar } from "../../utils/CustomTitleBar";

export class RideRouteParam {
  distance: string = "";
  time: string = "";
  routeDetailList: RideRouteDetail[] = []
  title?:string
}
export class RideRouteDetail{
  tag: string = ""
  textValue: string = ""
  constructor(tag: string, textValue: string) {
    this.tag = tag
    this.textValue = textValue
  }
}
@Builder
export function RideRouteDetailControllerBuilder(name: string, param: Object) {
  RideRouteDetailController()
}
@Component
export struct RideRouteDetailController{
  @Consume("pageInfos") pageInfos: NavPathStack
  @State
  private routeDetailList: RideRouteDetail[] = [];
  @State
  time: string = ""
  @State
  distance: string = ""

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
      let param = this.pageInfos.getParamByIndex(1) as RideRouteParam

      this.routeDetailList = JSON.parse(JSON.stringify(param.routeDetailList))
      this.routeDetailList.push(new RideRouteDetail('',''))
      this.routeDetailList.unshift(new RideRouteDetail('',''))
      this.time = param.time
      this.distance = param.distance
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
          .stroke(upLineVisible?'#b6b6b6':Color.White)
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
          .stroke(downLineVisible?'#b6b6b6':Color.White)
          .strokeWidth(3)
          .strokeLineCap(LineCapStyle.Round)
          .backgroundColor(Color.White)
      }
      .justifyContent(FlexAlign.Center)
      .width(60)
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
  buildMapRideRouteDetail() {
    Column() {
      CustomTitleBar({title:Constants.MAP_ROUTERIDE_DETAIL_FUNC,onPopClick:()=>{
        this.pageInfos.pop()
      }})
      Row(){
        Column(){
          Line()
            .width('100%')
            .height(0.5)
            .backgroundColor(Color.Black)
          Text(`${this.distance}`)
            .margin({left:30})
            .layoutWeight(1)
          Line()
            .width('100%')
            .height(0.5)
            .backgroundColor('#b6b6b6')
        }.backgroundColor(Color.White)
        .height("100%")
        .width(60)
        .justifyContent(FlexAlign.SpaceAround)
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
      }.justifyContent(FlexAlign.Start)
      .height(70)
      .width("100%")
      List() {
        ForEach(this.routeDetailList, (content: RideRouteDetail, index: number) => {
          ListItem() {
            if(index === 0){
              this.getListItem(false, $r("app.media.dir_start"), true, "出发")
            }else if(index === this.routeDetailList.length-1){
              this.getListItem(true, $r("app.media.dir_end"), false, "到达终点")
            }else{
              this.getListItem(true, AMapUtil.getDriveActionID(content.tag), true, content.textValue)
            }
          }
        })
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