import {
  AMap,
  HeatMapBuilder,
  HeatmapTileProvider,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewManager,
  TileOverlayOptions,
  TileOverlay
} from '@amap/amap_lbs_map3d';
import { Constants } from '../../utils/Constants';

@Component
export struct HeatMapController {
  private mMapView?: MapView;
  private mAMap?: AMap;
  private tileOverlay?: TileOverlay;

  @State private statusText: string = "地图加载中...";
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
    // 移除监听器防止内存泄漏
    if (this.mAMap) {
      // this.mAMap.removeOnMapReadyDelayListener(this.onMapReadyDelay);
    }
    MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    this.mMapView?.onDestroy();
  }

  onPageShow(): void {
    this.mMapView?.onResume();
  }

  onPageHide(): void {
    this.mMapView?.onPause();
  }

  // 地图创建回调
  private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string): void => {
    if (!mapview || this.mMapView) return;
    if (mapViewName !== Constants.MAP_HEAT_PICTURES) return;

    this.mMapView = mapview;
    this.mMapView.onCreate();

    this.mMapView.getMapAsync((map) => {
      this.mAMap = map;
      this.mAMap.addOnMapReadyDelayListener(this.onMapReadyDelay);
      const uiSettings = this.mAMap.getUiSettings();
      if (uiSettings) {
        uiSettings.setZoomControlsEnabled(true);
      }
      this.statusText = "地图准备就绪";
    });
  };


  private onMapReadyDelay = (): void => {
    console.log(' 地图完全稳定，开始自动加载热力图');
    this.loadHeatmapData();
  };

  /**
   * 加载热力图数据
   */
  private async loadHeatmapData(): Promise<void> {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        try {
          const latlngs: LatLng[] = [];
          const centerX = 39.904979;
          const centerY = 116.40964;

          for (let i = 0; i < 100; i++) {
            const offsetX = Math.random() * 0.5 - 0.25;
            const offsetY = Math.random() * 0.5 - 0.25;
            latlngs.push(new LatLng(centerX + offsetX, centerY + offsetY));
          }

          const builder = new HeatMapBuilder();
          builder.setData(latlngs);
          // builder.setRadius(200);

          const provider = builder.build();
          if (!provider) throw new Error("HeatmapTileProvider 构建失败");

          const options = new TileOverlayOptions();
          options.tileProvider(provider);

          if (this.tileOverlay) {
            this.tileOverlay.remove();
          }

          this.tileOverlay = this.mAMap?.addTileOverlay(options);
          console.log(` 热力图已添加，共 ${latlngs.length} 个点`);
          this.statusText = "热力图已加载";

          resolve();
        } catch (e) {
          console.error(' 加载热力图失败:', e);
          this.statusText = "加载失败";
          reject(e);
        }
      }, 0);
    });
  }

  build() {
    NavDestination() {
      Stack() {
        // 地图组件
        MapViewComponent({ mapViewName: Constants.MAP_HEAT_PICTURES })
          .width('100%')
          .height('100%')

        // 状态提示
        Text(this.statusText)
          .fontSize(12)
          .fontColor('#FFFFFF')
          .backgroundColor('#00000088')
          .padding({ left: 10, right: 10, top: 6, bottom: 6 })
          .borderRadius(6)
          .position({ left: 10, top: 10 })

        // 控制按钮
        Button("隐藏/显示")
          .width(100)
          .height(40)
          .fontSize(14)
          .onClick(() => {
            if (this.tileOverlay) {
              const isVisible = !this.tileOverlay.isVisible();
              this.tileOverlay.setVisible(isVisible);
              console.info(`热力图可见性: ${isVisible}`);
            }
          })
          .position({ left: 10, top: 60 })
      }
      .width('100%')
      .height('100%')
    }
    .title(Constants.MAP_HEAT_PICTURES)
  }
}
