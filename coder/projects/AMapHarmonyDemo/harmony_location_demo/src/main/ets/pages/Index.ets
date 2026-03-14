import { AMapPrivacyAgreeStatus, AMapPrivacyInfoStatus, AMapPrivacyShowStatus } from '@amap/amap_lbs_common';
import { AMapLocationManagerImpl } from '@amap/amap_lbs_location';

@Entry
@Component
struct Index {
  pageInfos: NavPathStack = new NavPathStack();

  aboutToAppear(): void {
    AMapLocationManagerImpl.updatePrivacyShow(AMapPrivacyShowStatus.DidShow, AMapPrivacyInfoStatus.DidContain, getContext(this))
    AMapLocationManagerImpl.updatePrivacyAgree(AMapPrivacyAgreeStatus.DidAgree, getContext(this))
  }

  build() {
    Navigation(this.pageInfos) {
      Scroll() {
        Column() {
          Button('定位')
            .ButtonCommonStyle()
            .padding(16)
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'LocationPage' });
            })
          Divider()

          Button('地理围栏')
            .ButtonCommonStyle()
            .padding(16)
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'GeoFenceMainPage' });
            })
          Divider()

          Button('两点间距离计算')
            .ButtonCommonStyle()
            .padding(16)
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'CalculateDistancePage' });
            })
          Divider()

          Button('坐标转换')
            .ButtonCommonStyle()
            .padding(16)
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'CoordConverPage' });
            })
          Divider()

          Button('判断位置所在区域')
            .ButtonCommonStyle()
            .padding(16)
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'DataAvailablePage' });
            })
          Divider()
        }
      }
    }
  }
}

@Extend(Button)
function ButtonCommonStyle() {
  .stateEffect(true)
  .type( ButtonType.Normal )
  .width('100%')
  .backgroundColor(Color.Transparent)
  .align(Alignment.Start)
  .fontColor(Color.Black)
  .padding({ left:32,top:16,bottom:16,right:16})
  .backgroundColor(Color.White)
}