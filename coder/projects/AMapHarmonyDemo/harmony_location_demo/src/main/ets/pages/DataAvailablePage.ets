import { CoordinateConverter, CoordType, DPoint, valueOfCoordType} from "@amap/amap_lbs_location";

@Builder
export function DataAvailablePageBuilder() {
  DataAvailablePage()
}

/**
 * 数据有效判断-示例
 */
@Component
export struct DataAvailablePage{

  //纬度
  latitude: number = 39.989646;
  //经度
  longitude: number = 116.480864;

  // latitude: number = 47.969541;
  // longitude: number = 106.799123;



  @State titleStr: string = '结果：'

  /**
   * 验证
   */
  private dataVerification(){
    console.log(`lat: ${this.latitude}, lng: ${this.longitude}`);
    const result = CoordinateConverter.isAMapDataAvailable(this.latitude, this.longitude);
    this.titleStr = `结果：${result ? "在大陆以及港、澳地区": "不在大陆以及港、澳地区" }`;
  }


  build() {
    NavDestination() {
      Column({space: 10}){
        Row(){
          Row(){
            Text('lat:').width(30)
            TextInput({text:this.latitude.toString(),})
              .layoutWeight(1)
              .type(InputType.NUMBER_DECIMAL)
              .onChange((value:string)=>{
                this.latitude = Number(value);
              })
          }.layoutWeight(1)
          Row(){
            Text('lng:').width(30)
            TextInput({text:this.longitude.toString()})
              .type(InputType.NUMBER_DECIMAL)
              .layoutWeight(1)
              .onChange((value:string)=>{
                this.longitude = Number(value);
              })
          }.layoutWeight(1)
        }.width('100%')

        Button("数据验证")
          .onClick((event: ClickEvent) => {
          this.dataVerification();
        })

        Text(this.titleStr)
      }

      .width("100%")
      .height("100%")
      .padding({left:15,right:15})
    }
    .title("判断位置所在区域")
  }

}