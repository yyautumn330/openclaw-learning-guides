/*
 * 跑步地图组件
 * 使用高德地图 SDK 显示实时轨迹
 */

import {
  AMap,
  CameraUpdateFactory,
  LatLng,
  MapsInitializer,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
  MapType,
  OnCameraChangeListener,
  Polyline,
  PolylineOptions
} from '@amap/amap_lbs_map3d';
import { AMapPrivacyShowStatus, AMapPrivacyInfoStatus, AMapPrivacyAgreeStatus } from '@amap/amap_lbs_common';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';
import { ArrayList } from '@kit.ArkTS';

const TAG = 'RunMapComponent';
const DOMAIN = 0x0000;
const MAP_VIEW_NAME = 'xiaobai_run_map';

@Component
export struct RunMapComponent {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') isPageHide: boolean = false;
  
  private mapView?: MapView;
  private aMap?: AMap;
  private polyline?: Polyline;
  private context: common.UIAbilityContext | null = null;
  private trajectoryPoints: LatLng[] = [];
  @State mapInitialized: boolean = false;
  
  // 回调：位置更新
  public onLocationUpdate?: (lat: number, lng: number) => void;
  // 回调：地图初始化完成
  public onMapReady?: (aMap: AMap) => void;
  
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
      
      hilog.info(DOMAIN, TAG, 'AMap instance got');
      
      map.setMapType(MapType.MAP_TYPE_NORMAL);
      
      // 设置相机变化监听
      const listener: OnCameraChangeListener = new OnCameraChangeListener(
        (position: CameraPosition) => {},
        (position: CameraPosition) => {
          hilog.info(DOMAIN, TAG, 'Camera changed');
        }
      );
      map?.setOnCameraChangeListener(listener);
      
      // 回调
      if (this.onMapReady) {
        this.onMapReady(map);
      }
    });
  };
  
  aboutToAppear() {
    hilog.info(DOMAIN, TAG, 'RunMapComponent aboutToAppear');
    
    this.context = getContext(this) as common.UIAbilityContext;
    
    // 初始化高德地图 SDK
    this.initAMap();
    
    // 注册回调
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
  }
  
  aboutToDisappear() {
    hilog.info(DOMAIN, TAG, 'RunMapComponent aboutToDisappear');
    this.mapView?.onPause();
    MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
  }
  
  onPageShow() {
    this.mapView?.onResume();
  }
  
  onPageHide() {
    this.mapView?.onPause();
  }
  
  async initAMap(): Promise<void> {
    try {
      if (!this.context) return;
      
      MapsInitializer.updatePrivacyShow(
        AMapPrivacyShowStatus.DidShow,
        AMapPrivacyInfoStatus.DidContain,
        this.context
      );
      MapsInitializer.updatePrivacyAgree(
        AMapPrivacyAgreeStatus.DidAgree,
        this.context
      );
      
      // API Key
      const apiKey = '1b1487f32d95f0bd6a418f1337503eb3';
      MapsInitializer.setApiKey(apiKey);
      MapsInitializer.setDebugMode(true);
      
      hilog.info(DOMAIN, TAG, 'AMap SDK initialized');
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Init error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
  
  /**
   * 移动到指定位置
   */
  moveToLocation(lat: number, lng: number): void {
    if (this.aMap) {
      const latLng = new LatLng(lat, lng);
      this.aMap.moveCamera(CameraUpdateFactory.newLatLngZoom(latLng, 16));
    }
  }
  
  /**
   * 更新轨迹
   */
  updateTrajectory(lat: number, lng: number): void {
    if (this.aMap) {
      this.trajectoryPoints.push(new LatLng(lat, lng));
      
      if (this.polyline) {
        this.polyline.remove();
      }
      
      if (this.trajectoryPoints.length >= 2) {
        this.polyline = this.aMap.addPolyline(new PolylineOptions()
          .setColor(0xFFFF6B6B)
          .setWidth(8));
        
        const pointList = new ArrayList<LatLng>();
        for (const point of this.trajectoryPoints) {
          pointList.add(point);
        }
        this.polyline?.setPoints(pointList);
      }
    }
  }
  
  build() {
    NavDestination() {
      Stack() {
        MapViewComponent({ mapViewName: MAP_VIEW_NAME })
        
        if (!this.mapInitialized) {
          Column() {
            Text('🗺️').fontSize(40).margin({ bottom: 8 })
            Text('加载地图中...').fontSize(14).fontColor('#FFFFFF')
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0,0,0,0.5)')
        }
      }
    }
    .hideTitleBar(true)
  }
}