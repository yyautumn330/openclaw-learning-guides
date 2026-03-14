import { MapsInitializer } from '@amap/amap_lbs_map3d'
import { Constants } from '../../utils/Constants';
 
@Component
export struct MapGlobalOptionController {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State isTerrainEnable: boolean = false;
 
  @Builder
  buildGlobalOptions() {
    Column() {
      Row() {
        Checkbox({ name: "设置开关" })
          .select(this.isTerrainEnable)
          .shape(CheckBoxShape.ROUNDED_SQUARE)
          .selectedColor(0x39a2db)
          .onChange((checked: boolean) => {
            this.isTerrainEnable = checked
            MapsInitializer.setTerrainEnable(checked)
          })
        Text("地形图")
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
    }
    .width('100%')
    .height('100%')
  }
 
  aboutToAppear(): void {
    this.isTerrainEnable = MapsInitializer.isTerrainEnable()
  }
 
  build() {
    NavDestination() {
      this.buildGlobalOptions();
    }
    .title(Constants.MAP_SETTING_SWITCH_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
 
  }
}