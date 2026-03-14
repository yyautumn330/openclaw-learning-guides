import { CoordinateConverter, CoordType, LatLng, valueOfCoordType } from "@amap/amap_lbs_map3d";
import { Constants } from "../../utils/Constants";

@Component
export struct  CoordConverComponent{

  private  sourceLatLng:LatLng = new LatLng(39.989646,116.480864,true);
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State desLatLng:LatLng|undefined = undefined
  @State titleStr: string = 'BAIDU'

  @State latitude:string = '39.989646'
  @State longitude: string = '116.480864'

  private  itemCoords: string[] = ["BAIDU","GPS", "MAPBAR", "MAPABC", "SOSOMAP", "ALIYUN", "GOOGLE" ]

  aboutToAppear(): void {
    this.desLatLng = this.convert(this.sourceLatLng,CoordType.BAIDU)
  }

  /**
   * 根据类型 转换 坐标
   */
  private  convert(sourceLatLng:LatLng,coord:CoordType ):LatLng|undefined {
  const  converter  = new CoordinateConverter(getContext(this).getApplicationContext())
  // CoordType.GPS 待转换坐标类型
  converter.from(coord);
  // sourceLatLng待转换坐标点
  converter.coord(sourceLatLng);
  // 执行转换操作
  const  desLatLng = converter.convert()

  return desLatLng;
}


  @Builder
  SubMenu() {
    Menu() {
      ForEach(this.itemCoords, (content: string, index: number) => {
        MenuItem({ content: content })
          .onClick(()=>{
            let  latitude = Number(this.latitude)
            let longitude = Number(this.longitude)
            if (this.latitude.trim() == '' ) {
              latitude = 39.989646
              this.latitude = '39.989646'
            }
            if (this.longitude.trim() == '') {
              longitude = 116.480864
              this.longitude = '116.480864'
            }
            this.sourceLatLng = new LatLng(latitude,longitude,true)
            this.desLatLng = this.convert(this.sourceLatLng,valueOfCoordType(this.itemCoords[index]))
            this.titleStr = content
          })
      })
    }
  }

  build() {
    NavDestination() {
      Column({space: 10}){
        Row(){
          Row(){
            Text('lat:')
              .width(30)
            TextInput({text:this.latitude})
              .type(InputType.NUMBER_DECIMAL)
              .layoutWeight(1)
              .onChange((value:string)=>{
                this.latitude = value
              })
          }.layoutWeight(1)
          Row(){
            Text('lng:')
              .width(30)
            TextInput({text:this.longitude})
              .type(InputType.NUMBER_DECIMAL)
              .layoutWeight(1)
              .onChange((value:string)=>{
                this.longitude = value
              })
          }.layoutWeight(1)

        }.width('100%')

        Row({space: 10}){

          Text(this.titleStr + '⬇️')
            .bindMenu(this.SubMenu())


          Text('转换为高德坐标系')
        }.width("100%")
        if (this.desLatLng){
          Text(`lat/lng:(${this.desLatLng.latitude},${this.desLatLng.longitude})`)
            .width('100%')
        }
      }

      .width("100%")
      .height("100%")
      .padding({left:15,right:15})
    }


    .title(Constants.MAP_TOOLSCOORDCONVER_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })



  }

}