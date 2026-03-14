import {
  AMap,
  MapView,
  MapViewComponent,
  MapType,
  MapViewManager,
} from '@amap/amap_lbs_map3d'
import { Constants } from '../../utils/Constants'

@Component
export struct LanguageMapShowController {
  private mMapView?: MapView;
  private mAMap?: AMap
  public static readonly ENGLISH: string = "en";
  public static readonly CHINESE: string = "zh_cn";
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean

  pageChange(changedPropertyName: string) {
    if (this.isPageHide === true) {
      this.onPageHide()
    } else {
      this.onPageShow()
    }
  }

  aboutToAppear(): void {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
  }

  aboutToDisappear(): void {
    MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    this.mMapView?.onDestroy()
  }

  private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mMapView) {
      return;
    }

    if (mapViewName != Constants.MAP_EN_LANGUAGE_FUNC) {
      return;
    }

    this.mMapView = mapview;

    this.mMapView.onCreate();
    this.mMapView.getMapAsync((map) => {
      this.mAMap = map;
      this.init();
    })
  }

  init(): void {
    this.mAMap?.getUiSettings()?.setScaleControlsEnabled(true);
    this.mAMap?.getUiSettings()?.setZoomControlsEnabled(true);
  }

  onPageShow(): void {
    this.mMapView?.onResume();
  }
  onPageHide(): void {
    this.mMapView?.onPause();
  }

  build() {
    NavDestination() {
      Stack() {
        MapViewComponent({ mapViewName: Constants.MAP_EN_LANGUAGE_FUNC })
        Column() {
          Row() {
            Radio({ value: "中文", group: 'mapType' })
              .checked(false)
              .radioStyle({
                checkedBackgroundColor: Color.Pink
              })
              .onChange((checked: boolean) => {
                let amap = this.mAMap;
                if (amap) {
                  if (checked) {
                    amap.setMapType(MapType.MAP_TYPE_NORMAL);
                    amap.setMapLanguage(LanguageMapShowController.CHINESE);
                  }
                }
              })
            Text("中文")
          }

          Divider().strokeWidth(2).color('#ff030303')

          Row() {
            Radio({ value: "英文", group: 'mapType' })
              .checked(false)
              .radioStyle({
                checkedBackgroundColor: Color.Pink
              })
              .onChange((checked: boolean) => {
                let amap = this.mAMap;
                if (amap) {
                  if (checked) {
                    amap.setMapType(MapType.MAP_TYPE_NORMAL);
                    amap.setMapLanguage(LanguageMapShowController.ENGLISH);
                  }
                }
              })
            Text("英文")
          }
        }
        .position({ x: 10, y: 10 })
        .backgroundColor("#ccbebebe")
        .align(Alignment.TopStart)
        .alignItems(HorizontalAlign.Start)
        .width('20%')
      }
      .width('100%')
      .height('100%')
    }
    .title(Constants.MAP_EN_LANGUAGE_FUNC)
  }
}