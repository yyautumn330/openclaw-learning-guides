import {
  AMapException,
  Tip,
  InputtipsQuery,
  Inputtips,
  InputtipsListener,
} from "@amap/amap_lbs_search"
import { Constants } from "../../utils/Constants"
import { ArrayList, HashMap } from "@kit.ArkTS"
import { ToastUtil } from "../../utils/ToastUtil"

/**
 * 输入内容自动提示
 */
@Component
export struct MapInputtipsController {
  @Consume('pageInfos') pageInfos: NavPathStack
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()

  @State @Watch("keywordChange") keyword: string = "";

  @State tipsList: ArrayList<Tip> = new ArrayList<Tip>();

  keywordChange(){
    this.doInputtipsRequest();
  }

  aboutToAppear(): void {
  }

  build() {
    NavDestination() {
      Column() {
        this.buildSearchView()
        this.buildContentView()
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F0F0F0')
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
    .title(Constants.MAP_INPUT_TIPS_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }

  //关键字搜索视图
  @Builder
  buildSearchView(){
    Column({space: 10}){
      Row(){
        Text("关键字：")
        TextInput({
          placeholder: "关键字",
          text: $$this.keyword
        })
          .layoutWeight(1)
          .height(40)
      }
      .width("100%")
      .height(44)
    }
    .padding({left: 20, right: 20})
  }

  @Builder
  buildItemView(tip: Tip){
    Column(){
      Column({space: 5}){
        Text(tip.getName())
          .fontSize(14)
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
        Text(tip.getDistrict())
          .fontSize(14)
          .fontColor(Color.Gray)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .width('100%')
      }
      .width("100%")
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .padding({left: 20, right: 20, top: 5, bottom: 5})
      Divider().color("#CCC")
    }
    .width("100%")
  }

  @Builder
  buildContentView(){
    List(){
      ForEach(this.tipsList.convertToArray(), (tip: Tip, index: number) => {
        ListItem(){
          this.buildItemView(tip)
        }
      }, (tip: Tip, index: number) => JSON.stringify(tip) + index)
    }
    .width("100%")
    .layoutWeight(1)
    .backgroundColor(Color.White)
  }

  /**
   * 接口回调
   */
  private inputtipsListener: InputtipsListener = {
    onGetInputtips: (inputTips: ArrayList<Tip>, resultID: number) => {
      if (resultID === AMapException.CODE_AMAP_SUCCESS) {
        if (inputTips.length > 0) {
          this.tipsList = inputTips;
        } else {
          ToastUtil.show(this.uiContext, '对不起，没有搜索到相关数据！')
          this.tipsList = new ArrayList<Tip>();
        }
      } else {
        ToastUtil.showError(this.uiContext, resultID)
        this.tipsList = new ArrayList<Tip>();
      }
    }
  };

  /**
   * 关键字请求
   */
  doInputtipsRequest() {
    if (this.keyword.trim().length > 0) {
      try{
        let query = new InputtipsQuery(this.keyword, "北京");
        // query.setType("05");
        query.setCityLimit(true);

        const inputtips = new Inputtips(this.context!, this.inputtipsListener, query);
        inputtips.requestInputtipsAsyn();
      }catch (e){
        console.log(`doPoiSearchRequest error: ${JSON.stringify(e)}}`);
      }
    }else{
      this.tipsList = new ArrayList<Tip>();
    }
  }
}