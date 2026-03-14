import { Constants } from './utils/Constants';
import { MapShowController } from './controller/show/MapShowController';
import { MapBoundLimitController } from './controller/boundlimit/MapBoundLimitController';
import { MapMultiController } from './controller/multi/MapMultiController';
import { MapOverlayZIndexController } from './controller/overlayzindex/MapOverlayZIndexController';
import { MapMarkerController } from './controller/marker/MapMarkerController';
import { MapInfoWindowController } from './controller/infowindow/MapInfoWindowController';
import { MapPolygonController } from './controller/polygon/MapPolygonController';
import { MapCircleController } from './controller/circle/MapCircleController';
import { MapGL3DModelController } from './controller/gl3dmodel/MapGL3DModelController';
import { MapMyLocationController } from './controller/mylocation/MapMyLocationController';
import { MapUiSettingsController } from './controller/uisettings/MapUiSettingsController';
import { MapGestureController } from './controller/gesture/MapGestureController';
import { MapLayersController } from './controller/layers/MapLayersController';
import { MapProjectionController } from './controller/projection/MapProjectionController';
import { MapCameraUpdateController } from './controller/cameraupdate/MapCameraUpdateController';
import { MapPolylineController } from './controller/polyline/MapPolylineController';
import { MapsInitializer } from '@amap/amap_lbs_map3d';
import { MapWeatherSearchController } from './controller/weather/MapWeatherSearchController';
import { DriveRouteController } from './controller/route/DriveRouteController';
import { DriveRouteControllerV2 } from './controller/route/DriveRouteControllerV2';
import { ServiceSettings } from '@amap/amap_lbs_search';
import { AMapPrivacyInfoStatus, AMapPrivacyShowStatus } from '@amap/amap_lbs_common';
import { AMapPrivacyAgreeStatus } from '@amap/amap_lbs_common';
import { MapDriveRoutePlanController } from './controller/route/MapDriveRoutePlanController';
import { WalkRouteController } from './controller/route/WalkRouteController';
import { WalkRouteControllerV2 } from './controller/route/WalkRouteControllerV2';
import { RideRouteController } from './controller/route/RideRouteController';
import { RideRouteControllerV2 } from './controller/route/RideRouteControllerV2';
import { GeocoderController } from './controller/geocoder/GeocoderController';
import { ReGeocoderController } from './controller/geocoder/ReGeocoderController';
import { MapInputtipsController } from './controller/poisearch/MapInputtipsController';
import { MapPOIKeywordSearchController } from './controller/poisearch/MapPOIKeywordSearchController';
import { MapPOIAroundSearchController } from './controller/poisearch/MapPOIAroundSearchController';
import { MapRoutePoiController } from './controller/routepoi/MapRoutePoiController';
import { MapPOIIDSearchController } from './controller/poisearch/MapPOIIDSearchController';
import { MapOfflineMapController } from './controller/offlineMap/MapOfflineMapController';
import { TruckRouteController } from './controller/route/TruckRouteController';
import { MultiPointOverlayController } from './controller/multipointoverlay/MultiPointOverlayController';
import { ScreenshotController } from './controller/screenshot/ScreenShotController';
import { DistrictController } from './controller/district/DistrictController';
import { DistrictWithBoundaryController } from './controller/district/DistrictWithBoundaryController';
import { MapGroundOverlayController } from './controller/groundoverlay/GroundOverlayController';
import { RouteDistanceController } from './controller/route/RouteDistanceController';

import { SmoothMoveController } from './controller/smooth/SmoothMoveController';
import { BusRoutePathsController } from './controller/route/BusRoutePathsController';
import { BusRoutePathsControllerV2 } from './controller/route/BusRoutePathsControllerV2';
import { HeatMapController } from './controller/heatmap/HeatMapController';
import { MapArcController } from './controller/arc/MapArcController';
import { MapGlobalOptionController } from './controller/globalOptions/MapGlobalOptionController';
import { CalculateDistanceController } from './controller/tools/CalculateDistanceController';
import { BusStationController } from './controller/busline/BusStationController';
import { BusLineController } from './controller/busline/BusLineController';
import { abilityAccessCtrl, bundleManager, common, PermissionRequestResult, Permissions } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { CoordConverComponent } from './controller/tools/CoordConverComponent';
import { TraceComponent } from './controller/trace/TraceComponent';
import { TraceSimpleComponent } from './controller/trace/TraceSimpleComponent';
import { MapMarkerAnimationController } from './controller/marker/MapMarkerAnimationController';
import { MapMarkerClickController } from './controller/marker/MapMarkerClickController';
import { CustomMarkerController } from './controller/marker/CustomMarkerController';
import { HoneycombHeatMapController } from './controller/honeycombHeatMap/HoneycombHeatMapController';
import { IndoorMapController } from './controller/indoor/IndoorMapController';
import { LanguageMapShowController } from './controller/language/LanguageMapShowController';

const key = "此处替换官网申请的Key";


MapsInitializer.updatePrivacyShow(AMapPrivacyShowStatus.DidShow, AMapPrivacyInfoStatus.DidContain, getContext())
MapsInitializer.updatePrivacyAgree(AMapPrivacyAgreeStatus.DidAgree, getContext())

class ListItemContent {
  title: string = '';
  info: string = '';
}

@Entry
@Component
struct Index {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack()
  @Provide('isPageHide') isPageHide: boolean = false

  aboutToAppear(): void {
    MapsInitializer.setApiKey(key);
    MapsInitializer.setDebugMode(true);
    //todo 世界地图默认关闭
    MapsInitializer.setLoadWorldVectorMap(false);
  }

  @Builder
  buildMap(title: string, index: number) {
    if (title == Constants.MAP_SHOW_FUNC) {
      MapShowController();
    } else if (title == Constants.MAP_SETTING_SWITCH_FUNC) {
      MapGlobalOptionController();
    } else if (title == Constants.MAP_MULTI_FUNC) {
      MapMultiController();
    } else if (title == Constants.MAP_BOUND_LIMIT_FUNC) {
      MapBoundLimitController();
    } else if (title == Constants.MAP_INDOOR_FUNC) {
      IndoorMapController();
    } else if (title == Constants.MAP_OVERLAY_ZINDEX_FUNC) {
      MapOverlayZIndexController();
    } else if (title == Constants.MAP_EN_LANGUAGE_FUNC) {
      LanguageMapShowController();
    } else if (title == Constants.MAP_MARKER_FUNC) {
      MapMarkerController();
    } else if(title == Constants.MAP_MARKER_ANIMATION_FUNC){
      MapMarkerAnimationController();
    } else if (title == Constants.MAP_MARKER_CLICK_FUNC) {
      MapMarkerClickController();
    }else if (title == Constants.MAP_MARKER_CUSTOM_FUNC) {
      CustomMarkerController();
    } else if (title == Constants.MAP_INFOWINDOW_FUNC) {
      MapInfoWindowController();
    } else if (title == Constants.MAP_POLYLINE_FUNC) {
      MapPolylineController();
    } else if (title == Constants.MAP_POLYGON_FUNC) {
      MapPolygonController();
    } else if (title == Constants.MAP_CIRCLE_FUNC) {
      MapCircleController();
    } else if (title == Constants.MAP_GL3DMODEL_FUNC) {
      MapGL3DModelController();
    } else if (title == Constants.MAP_MYLOCATION_FUNC) {
      MapMyLocationController();
    } else if (title == Constants.MAP_UISETTINGS_FUNC) {
      MapUiSettingsController();
    } else if (title == Constants.MAP_GESTURE_FUNC) {
      MapGestureController();
    } else if (title == Constants.MAP_LAYER_FUNC) {
      MapLayersController();
    } else if (title == Constants.MAP_PROJECTION_FUNC) {
      MapProjectionController();
    } else if (title == Constants.MAP_CAMERA_UPDATE_FUNC) {
      MapCameraUpdateController();
    } else if (title == Constants.MAP_ROUTEDRIVE_FUNC) {
      DriveRouteController()
    } else if (title == Constants.MAP_ROUTEDRIVEV2_FUNC) {
      DriveRouteControllerV2()
    } else if (title == Constants.MAP_WEATHER_SEARCH_FUNC) {
      MapWeatherSearchController();
    } else if (title == Constants.MAP_ROUTEDRIVE_PLAN_FUNC) {
      MapDriveRoutePlanController()
    } else if (title == Constants.MAP_ROUTEWALK_FUNC) {
      WalkRouteController()
    } else if (title == Constants.MAP_ROUTEWALKV2_FUNC) {
      WalkRouteControllerV2()
    } else if (title == Constants.MAP_ROUTERIDE_FUNC) {
      RideRouteController()
    } else if (title == Constants.MAP_ROUTERIDE2_FUNC) {
      RideRouteControllerV2()
    } else if (title == Constants.MAP_GEOCODE_FUNC) {
      GeocoderController()
    } else if (title == Constants.MAP_REGEOCODE_FUNC) {
      ReGeocoderController()
    } else if (title == Constants.MAP_POI_KEYWORD_SEARCH_FUNC) {
      MapPOIKeywordSearchController();
    } else if (title == Constants.MAP_POI_AROUND_SEARCH_FUNC) {
      MapPOIAroundSearchController();
    } else if (title == Constants.MAP_POI_ID_SEARCH_FUNC) {
      MapPOIIDSearchController();
    } else if (title == Constants.MAP_ROUTEPOI_FUNC) {
      MapRoutePoiController();
    } else if (title == Constants.MAP_INPUT_TIPS_FUNC) {
      MapInputtipsController();
    }else if (title == Constants.MAP_OFFLINEMAP_FUNC){
      MapOfflineMapController()
    } else if (title == Constants.MAP_ROUTEDISTANCE_FUNC) {
      RouteDistanceController();
    } else if (title == Constants.MAP_ROUTETRUCK_FUNC) {
      TruckRouteController()
    } else if (title == Constants.MAP_MULTIPOINTOVERLAY_FUNC) {
      MultiPointOverlayController()
    } else if (title == Constants.MAP_SCREENSHOT_FUNC) {
      ScreenshotController()
    } else if (title == Constants.MAP_HEAT_PICTURES) {
      HeatMapController()
    } else if (title == Constants.MAP_DISTRICT_FUNC) {
      DistrictController()
    } else if (title == Constants.MAP_DISTRICT_WITH_BOUNDARY_FUNC) {
      DistrictWithBoundaryController()
    } else if (title == Constants.MAP_GROUNDOVERLAY_FUNC){
      MapGroundOverlayController()
    } else if (title == Constants.MAP_SMOOTHMOVING_FUNC) {
      SmoothMoveController()
    } else if (title == Constants.MAP_ARC_FUNC) {
      MapArcController()
    } else if (title == Constants.MAP_ROUTEBUSV2_FUNC) {
      BusRoutePathsControllerV2()
    } else if (title == Constants.MAP_ROUTEBUS_FUNC) {
      BusRoutePathsController()
    } else if (title == Constants.MAP_CALCULATEDISTANCE_FUNC) {
      CalculateDistanceController()
    } else if (title == Constants.MAP_BUSSTATIONQUERY_FUNC) {
      BusStationController()
    } else if (title == Constants.MAP_BUS_LINE_QUERY_FUNC) {
      BusLineController()
    }else if (title == Constants.MAP_TOOLSCOORDCONVER_FUNC) {
      CoordConverComponent()
    }else if (title == Constants.MAP_TRACE_FUNC){
      TraceComponent()
    }else if (title == Constants.MAP_TRACE_SIMPLE_FUNC){
      TraceSimpleComponent()
    } else if (title == Constants.MAP_HEAT_HONEY){
      HoneycombHeatMapController()
    }
  }

  private pages: ListItemContent[] = [
    { title: Constants.MAP_SHOW_FUNC, info: '介绍创建一个地图' },
    { title: Constants.MAP_SETTING_SWITCH_FUNC, info: '设置全局开关' },
    { title: Constants.MAP_MULTI_FUNC, info: '介绍地图多实例' },
    { title: Constants.MAP_BOUND_LIMIT_FUNC, info: '限制显示区域' },
    { title: Constants.MAP_INDOOR_FUNC, info: '室内地图功能' },
    { title: Constants.MAP_OVERLAY_ZINDEX_FUNC, info: '覆盖物层级功能' },
    { title: Constants.MAP_EN_LANGUAGE_FUNC, info: '英文地图功能' },
    { title: Constants.MAP_MARKER_FUNC, info: '介绍Marker功能' },
    { title: Constants.MAP_MARKER_CLICK_FUNC, info: '介绍Marker点击回调功能' },
    { title: Constants.MAP_MARKER_ANIMATION_FUNC, info: '介绍Marker动画功能' },
    { title: Constants.MAP_MARKER_CUSTOM_FUNC, info: '介绍Marker功能' },
    { title: Constants.MAP_INFOWINDOW_FUNC, info: '介绍infowindow功能' },
    { title: Constants.MAP_POLYLINE_FUNC, info: '介绍线功能' },
    { title: Constants.MAP_POLYGON_FUNC, info: '介绍面功能' },
    { title: Constants.MAP_CIRCLE_FUNC, info: '介绍Circle功能' },
    { title: Constants.MAP_GL3DMODEL_FUNC, info: 'GL3DModel功能' },
    { title: Constants.MAP_MYLOCATION_FUNC, info: '介绍定位蓝点功能' },
    { title: Constants.MAP_UISETTINGS_FUNC, info: '介绍UiSettings功能' },
    { title: Constants.MAP_GESTURE_FUNC, info: '手势功能' },
    { title: Constants.MAP_LAYER_FUNC, info: 'layers功能' },
    // { title: Constants.MAP_PROJECTION_FUNC, info: 'projection功能' },
    { title: Constants.MAP_CAMERA_UPDATE_FUNC, info: 'CameraUpdate功能' },
    { title: Constants.MAP_ROUTEDRIVE_FUNC, info: '驾车路线规划功能' },
    { title: Constants.MAP_ROUTEDRIVEV2_FUNC, info: '驾车路线规划功能V2' },
    { title: Constants.MAP_WEATHER_SEARCH_FUNC, info: '天气查询功能' },
    { title: Constants.MAP_ROUTEDRIVE_PLAN_FUNC, info: '计划驾车路线规划功能' },
    { title: Constants.MAP_ROUTEWALK_FUNC, info: '步行路线规划功能' },
    { title: Constants.MAP_ROUTEWALKV2_FUNC, info: '步行路线规划功能V2' },
    { title: Constants.MAP_ROUTERIDE_FUNC, info: '骑行路线规划' },
    { title: Constants.MAP_ROUTERIDE2_FUNC, info: '骑行路线规划V2' },
    { title: Constants.MAP_GEOCODE_FUNC, info: '地理编码' },
    { title: Constants.MAP_REGEOCODE_FUNC, info: '逆地理编码' },
    { title: Constants.MAP_POI_KEYWORD_SEARCH_FUNC, info: 'poi关键字搜索' },
    { title: Constants.MAP_POI_AROUND_SEARCH_FUNC, info: 'poi周边搜索' },
    { title: Constants.MAP_POI_ID_SEARCH_FUNC, info: 'poiID搜索' },
    { title: Constants.MAP_ROUTEPOI_FUNC, info: '道路沿途搜索' },
    { title: Constants.MAP_INPUT_TIPS_FUNC, info: '输入内容自动提示' },
    { title: Constants.MAP_OFFLINEMAP_FUNC, info: '使用离线地图' },
    { title: Constants.MAP_ROUTEDISTANCE_FUNC, info: '距离测量' },
    { title: Constants.MAP_ROUTETRUCK_FUNC, info: '货车路线规划功能' },
    { title: Constants.MAP_MULTIPOINTOVERLAY_FUNC, info: '海量点显示' },
    { title: Constants.MAP_HEAT_PICTURES, info: '热力图功能' },
    { title: Constants.MAP_SCREENSHOT_FUNC, info: '地图截图功能' },
    { title: Constants.MAP_DISTRICT_FUNC, info: '行政区划查询' },
    { title: Constants.MAP_DISTRICT_WITH_BOUNDARY_FUNC, info: '行政区划边界查询' },
    { title: Constants.MAP_GROUNDOVERLAY_FUNC, info: '绘制自定义图层' },
    { title: Constants.MAP_SMOOTHMOVING_FUNC, info: '演示点平滑移动的效果' },
    { title: Constants.MAP_ARC_FUNC, info: '绘制弧线'},
    { title: Constants.MAP_ROUTEBUS_FUNC, info: '公交路线规划功能' },
    { title: Constants.MAP_ROUTEBUSV2_FUNC, info: '公交路线规划功能V2' },
    { title: Constants.MAP_CALCULATEDISTANCE_FUNC, info: '两点间距离' },
    { title: Constants.MAP_BUSSTATIONQUERY_FUNC, info: '公交站点查询' },
    { title: Constants.MAP_BUS_LINE_QUERY_FUNC, info: 'Busline公交查询' },
    { title: Constants.MAP_TOOLSCOORDCONVER_FUNC, info: '坐标系转换' },
    { title: Constants.MAP_TRACE_FUNC, info: '轨迹纠偏功能'},
    { title: Constants.MAP_TRACE_SIMPLE_FUNC, info: '轨迹纠偏功能_便捷版'},
    { title: Constants.MAP_HEAT_HONEY, info: '蜂窝热力图' },

  ];

  build() {
    Column() {
      Navigation(this.pageInfos) {
        List() {
          ForEach(this.pages, (content: ListItemContent, index: number) => {
            ListItem() {
              Column() {
                Text(content.title)
                  .width("100%")
                  .height(50)
                  .backgroundColor('#FFFFFF')
                  .borderRadius(24)
                  .fontSize(16)
                  .fontWeight(50)
                  .textAlign(TextAlign.Start)
                  .padding({
                    left: 20
                  })
                Text(content.info)
                  .width('100%')
                  .height(20)
                  .fontSize(12)
                  .textAlign(TextAlign.Start)
                  .fontColor(Color.Gray)
                  .padding({
                    left: 20
                  })
              }.onClick(() => {
                this.pageInfos.pushPath({ name: content.title, param: index })
              })
            }
          })
        }.width('100%')
        .height('100%')
        .divider({
          strokeWidth: 0.5,
          color: Color.Black
        })
      }.title('地图示例')
      .navDestination(this.buildMap)
      .titleMode(NavigationTitleMode.Mini)
      .mode(NavigationMode.Auto)
    }.backgroundColor(Color.Transparent)
  }

  onPageShow(): void {
    this.checkPermissions()
    this.isPageHide = false
  }

  onPageHide(): void {
    this.isPageHide = true
  }

  async checkPermissions(): Promise<void> {
    const permissions: Array<Permissions> = ['ohos.permission.LOCATION'];
    let grantStatus: abilityAccessCtrl.GrantStatus = await this.checkAccessToken(permissions[0]);

    if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      // 已经授权，可以继续访问目标操作
    } else {
      // 申请日历权限
      const permissions: Array<Permissions> = ['ohos.permission.LOCATION'];

      this.reqPermissionsFromUser([
        'ohos.permission.APPROXIMATELY_LOCATION',
        'ohos.permission.LOCATION',
      ]);
    }
  }

  async checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;

    // 获取应用程序的accessTokenID
    let tokenId: number = 0;
    try {
      let bundleInfo: bundleManager.BundleInfo = await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      tokenId = appInfo.accessTokenId;
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      console.error(`Failed to get bundle info for self. Code is ${err.code}, message is ${err.message}`);
    }

    // 校验应用是否被授予权限
    try {
      grantStatus = await atManager.checkAccessToken(tokenId, permission);
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      console.error(`Failed to check access token. Code is ${err.code}, message is ${err.message}`);
    }

    return grantStatus;
  }

  reqPermissionsFromUser(permissions: Array<Permissions>): void {
    let context: Context = getContext(this) as common.UIAbilityContext;
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    atManager.requestPermissionsFromUser(context, permissions).then((data: PermissionRequestResult) => {
      let grantStatus: Array<number> = data.authResults;
      let length: number = grantStatus.length;
      for (let i = 0; i < length; i++) {
        if (grantStatus[i] === 0) {
          // 用户授权，可以继续访问目标操作
        } else {
          // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
          // this.openPermissionsInSystemSettings()
          return;
        }
      }
      // 授权成功
    }).catch((err: BusinessError) => {
      console.error(`Failed to request permissions from user. Code is ${err.code}, message is ${err.message}`);
    })
  }
}