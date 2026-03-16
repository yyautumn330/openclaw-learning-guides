/*
 * 高德地图容器组件
 * 使用高德地图 HarmonyOS SDK (MapView)
 */

import {
  AMap,
  CameraPosition,
  LatLng,
  MapsInitializer,
  MapView,
  MapViewManager,
  MapViewCreateCallback,
  AMapPrivacyShowStatus,
  AMapPrivacyInfoStatus,
  AMapPrivacyAgreeStatus,
  MapType
} from '@amap/amap_lbs_map3d';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';

const TAG = 'AMapContainer';
const DOMAIN = 0x0000;
const MAP_VIEW_NAME = 'xiaobai_run_amap';

@Component
export struct AMapContainer {
  @Prop isDarkMode: boolean = false;
  @State mapInitialized: boolean = false;
  @State currentLat: number = 39.90923;
  @State currentLng: number = 116.397428;
  @State zoom: number = 15;
  
  private mapView?: MapView;
  private aMap?: AMap;
  private context: common.UIAbilityContext | null = null;
  
  // MapView 创建回调
  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }
    
    if (mapViewName !== MAP_VIEW_NAME) {
      return;
    }
    
    hilog.info(DOMAIN, TAG, 'MapView created');
    
    this.mapView = mapview;
    this.mapView.onCreate();
    
    this.mapView.getMapAsync((map) => {
      this.aMap = map;
      this.mapInitialized = true;
      
      hilog.info(DOMAIN, TAG, 'AMap instance got, zoom: %{public}f', map.getCameraPosition()?.zoom ?? 0);
      
      // 设置地图类型
      if (this.isDarkMode) {
        map.setMapType(MapType.MAP_TYPE_NIGHT);
      } else {
        map.setMapType(MapType.MAP_TYPE_NORMAL);
      }
      
      // 设置地图点击监听
      map?.setOnMapClickListener((point: LatLng) => {
        hilog.info(DOMAIN, TAG, 'Map clicked: %{public}f, %{public}f', point.latitude, point.longitude);
      });
      
      // 设置相机变化监听
      map?.setOnCameraChangeListener({
        onCameraChange: (position: CameraPosition) => {
          hilog.info(DOMAIN, TAG, 'Camera changing');
        },
        onCameraChangeFinish: (position: CameraPosition) => {
          hilog.info(DOMAIN, TAG, 'Camera changed: %{public}f, %{public}f', 
                     position.target.latitude, position.target.longitude);
          this.currentLat = position.target.latitude;
          this.currentLng = position.target.longitude;
        }
      });
    });
  };
  
  aboutToAppear() {
    hilog.info(DOMAIN, TAG, 'AMapContainer aboutToAppear');
    
    this.context = getContext(this) as common.UIAbilityContext;
    
    // 初始化高德地图 SDK
    this.initAMap();
    
    // 注册 MapView 创建回调
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
  }
  
  aboutToDisappear() {
    hilog.info(DOMAIN, TAG, 'AMapContainer aboutToDisappear');
    this.mapView?.onPause();
    MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
  }
  
  onPageShow() {
    this.mapView?.onResume();
  }
  
  onPageHide() {
    this.mapView?.onPause();
  }
  
  /**
   * 初始化高德地图 SDK
   */
  async initAMap(): Promise<void> {
    try {
      if (!this.context) {
        hilog.error(DOMAIN, TAG, 'Context is null');
        return;
      }
      
      // 设置隐私协议状态
      MapsInitializer.updatePrivacyShow(
        AMapPrivacyShowStatus.DidShow,
        AMapPrivacyInfoStatus.DidContain,
        this.context
      );
      MapsInitializer.updatePrivacyAgree(
        AMapPrivacyAgreeStatus.DidAgree,
        this.context
      );
      
      // 设置 API Key（用户已申请）
      const apiKey = 'YOUR_AMAP_API_KEY_HERE'; // 请替换为您申请的 API Key
      MapsInitializer.setApiKey(apiKey);
      MapsInitializer.setDebugMode(true);
      
      hilog.info(DOMAIN, TAG, 'AMap SDK initialized');
      
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Init AMap error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
  
  /**
   * 定位到指定位置
   */
  moveToLocation(lat: number, lng: number, zoomLevel?: number) {
    if (this.aMap) {
      const latLng = new LatLng(lat, lng);
      const zoom = zoomLevel ?? this.zoom;
      
      this.aMap.moveCamera({
        target: latLng,
        zoom: zoom,
        tilt: 0,
        bearing: 0
      });
      
      hilog.info(DOMAIN, TAG, 'Moved to: %{public}f, %{public}f', lat, lng);
    }
  }
  
  /**
   * 添加标记点
   */
  addMarker(lat: number, lng: number, title?: string) {
    // TODO: 实现标记点功能
  }
  
  @Builder
  build() {
    Stack() {
      // 地图视图
      MapViewComponent({ mapViewName: MAP_VIEW_NAME })
      
      // 未加载提示
      if (!this.mapInitialized) {
        Column() {
          Text('🗺️')
            .fontSize(40)
            .margin({ bottom: 8 })
          Text('加载地图中...')
            .fontSize(14)
            .fontColor('#FFFFFF')
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.5)')
      }
    }
    .width('100%')
    .height('100%')
  }
}
