import { OfflineMapPage } from "@amap/amap_lbs_map3d"
import { Constants } from "../../utils/Constants"

@Entry
@Component
export struct MapOfflineMapController {
  @Consume('pageInfos') pageInfos: NavPathStack
  build() {
    NavDestination() {
      OfflineMapPage()
    }
    .title("离线地图")
    .onBackPressed(() => {
      this.pageInfos.pop()
      return true
    })
  }

  aboutToAppear(): void {
  }
}