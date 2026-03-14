import { AMapPrivacyAgreeStatus, AMapPrivacyInfoStatus, AMapPrivacyShowStatus, LogUtil } from "@amap/amap_lbs_common";
import {
  AMapLocation,
  AMapLocationManagerImpl,
  AMapLocationOption,
  AMapLocationReGeocodeLanguage,
  AMapLocationType,
  GeoFenceClient,
  IAMapLocationListener,
  Utils
} from "@amap/amap_lbs_location";
import { GeoFence,GeoFenceListener,DPoint,Constants,Handler, Message } from "@amap/amap_lbs_location";
import {
  AMap,
  BitmapDescriptorFactory,
  CameraUpdateFactory,
  CircleOptions,
  LatLng,
  LatLngBounds,
  LatLngBoundsBuilder,
  MapsInitializer,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
  Marker,
  MarkerOptions,
  MyLocationStyle,
  OnLocationChangedListener,
  PolygonOptions,
  Poi
} from "@amap/amap_lbs_map3d";
import { ArrayList, HashMap } from "@kit.ArkTS";
import { geoLocationManager } from "@kit.LocationKit";
import { PromptAction, UIContext } from "@ohos.arkui.UIContext";
import { emitter } from "@kit.BasicServicesKit";
import bundleManager from '@ohos.bundle.bundleManager';

const key = "此处替换官网申请的Key";

@Builder
export function GeoFencePageBuilder() {
  GeoFencePage()
}

const TAG = "GeoFencePage"

@Component
struct GeoFencePage {
  @State
  tips: string = ''
  @State
  GeoFenceType: number = 0
  @State
  activateAction: number = GeoFenceClient.GEOFENCE_IN
  @State
  tvResult: string = ''
  @State
  fenceList: ArrayList<GeoFence> = new ArrayList<GeoFence>();
  GeoSelectFenceType: boolean = false
  pageInfos: NavPathStack = new NavPathStack()
  mapView?: MapView
  aMap?: AMap
  centerPoint?: LatLng
  polygonPoints = new ArrayList<LatLng>()
  centerMarker?: Marker
  markerList: ArrayList<Marker> = new ArrayList<Marker>()
  etCustomerId: string = ''
  etRadius: number = 0
  etPoiType: string = ''
  etKeyword: string = ''
  etCity: string = ''
  etFenceSize: number = 0
  fenceClient?: GeoFenceClient
  boundsBuilder: LatLngBoundsBuilder = new LatLngBoundsBuilder()
  locationManger?: AMapLocationManagerImpl
  context: Context = getContext()
  locationMarker?: Marker
  scroller: Scroller = new Scroller()
  location?: AMapLocation
  uiContext: UIContext = this.getUIContext();
  promptAction: PromptAction = this.uiContext.getPromptAction();
  listenerListener?: OnLocationChangedListener

  build() {
    NavDestination() {
      Flex({ direction: FlexDirection.Column }) {
        Column({ space: 20 }) {
          if (this.GeoSelectFenceType) {
            Scroll(this.scroller) {
              Row({ space: 5 }) {
                Radio({ value: '1', group: 'geoFenceTypeGroup' })
                  .checked(true)
                  .onChange((isChecked: boolean) => {
                    if (isChecked) {
                      this.GeoFenceType = 1
                    }
                  })
                Text("圆形围栏")
                Radio({ value: '2', group: 'geoFenceTypeGroup' })
                  .checked(false)
                  .onChange((isChecked: boolean) => {
                    if (isChecked) {
                      this.GeoFenceType = 2
                    }
                  })
                Text("多边形围栏")
                Radio({ value: '3', group: 'geoFenceTypeGroup' })
                  .checked(false)
                  .onChange((isChecked: boolean) => {
                    if (isChecked) {
                      this.GeoFenceType = 3
                    }
                  })
                Text("关键字围栏")
                Radio({ value: '4', group: 'geoFenceTypeGroup' })
                  .checked(false)
                  .onChange((isChecked: boolean) => {
                    if (isChecked) {
                      this.GeoFenceType = 4
                    }
                  })
                Text("周边围栏")
                Radio({ value: '5', group: 'geoFenceTypeGroup' })
                  .checked(false)
                  .onChange((isChecked: boolean) => {
                    if (isChecked) {
                      this.GeoFenceType = 5
                    }
                  })
                Text("行政区划围栏")
              }.justifyContent(FlexAlign.SpaceBetween)
            }
            .width('100%')
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
          }

          TextInput({ placeholder: '业务ID' })
            .onChange((value: string) => {
              this.etCustomerId = value
            })
          if ([3, 4, 5].includes(this.GeoFenceType)) {
            TextInput({ placeholder: '关键字' })
              .onChange((value: string) => {
                this.etKeyword = value
              })
          }
          if ([3].includes(this.GeoFenceType)) {
            TextInput({ placeholder: '城市' })
              .onChange((value: string) => {
                this.etCity = value
              })
          }
          if ([3, 4].includes(this.GeoFenceType)) {
            TextInput({ placeholder: 'POI类型' })
              .onChange((value: string) => {
                this.etPoiType = value
              })
          }
          if ([1, 4].includes(this.GeoFenceType)) {
            TextInput({ placeholder: '围栏半径' }).type(InputType.NUMBER_DECIMAL)
              .onChange((value: string) => {
                this.etRadius = Number.parseFloat(value)
              })
          }
          if ([3, 4].includes(this.GeoFenceType)) {
            TextInput({ placeholder: '最大围栏数量' }).type(InputType.Number)
              .onChange((value: string) => {
                this.etFenceSize = Number.parseInt(value)
              })
          }


          Row({ space: 5 }) {
            Text("触发条件：")
            Checkbox({ name: '进入', group: 'radioGroup' })
              .select(true)
              .shape(CheckBoxShape.ROUNDED_SQUARE)
              .onChange((isChecked: boolean) => {
                if (isChecked) {
                  this.activateAction |= GeoFenceClient.GEOFENCE_IN;
                } else {
                  this.activateAction = this.activateAction
                    & (GeoFenceClient.GEOFENCE_OUT
                      | GeoFenceClient.GEOFENCE_STAYED);
                }

                this.fenceClient?.setActivateAction(this.activateAction)
                this.checkFence()
              })
            Text("进入")
            Checkbox({ name: '离开', group: 'radioGroup' })
              .select(false)
              .shape(CheckBoxShape.ROUNDED_SQUARE)
              .onChange((isChecked: boolean) => {
                if (isChecked) {
                  this.activateAction |= GeoFenceClient.GEOFENCE_OUT;
                } else {
                  this.activateAction = this.activateAction
                    & (GeoFenceClient.GEOFENCE_IN
                      | GeoFenceClient.GEOFENCE_STAYED);
                }
                this.fenceClient?.setActivateAction(this.activateAction)
                this.checkFence()
              })
            Text("离开")
            Checkbox({ name: '停留', group: 'radioGroup' })
              .select(false)
              .shape(CheckBoxShape.ROUNDED_SQUARE)
              .onChange((isChecked: boolean) => {
                if (isChecked) {
                  this.activateAction |= GeoFenceClient.GEOFENCE_STAYED;
                } else {
                  this.activateAction = this.activateAction
                    & (GeoFenceClient.GEOFENCE_IN
                      | GeoFenceClient.GEOFENCE_OUT);
                }
                this.fenceClient?.setActivateAction(this.activateAction)
                this.checkFence()
              })
            Text("停留")
          }.justifyContent(FlexAlign.SpaceBetween)

          if (this.GeoFenceType === 1 || this.GeoFenceType === 2 || this.GeoFenceType === 4) {
            Text(this.tips)
          }

          Row({ space: 10 }) {
            Button("添加围栏")
              .onClick(() => {
                if (this.GeoFenceType === 1) {
                  if (!this.centerPoint) {
                    AlertDialog.show({ message: "请获取中心点坐标" })
                    return
                  }
                  this.addRoundFence()
                } else if (this.GeoFenceType === 2) {
                  if (this.polygonPoints.length < 3) {
                    AlertDialog.show({ message: "请选择至少3个点" })
                    return
                  }
                  this.addPolygonFence()
                } else if (this.GeoFenceType === 3) {
                  this.addKeywordFence()
                } else if (this.GeoFenceType === 4) {
                  if (!this.centerPoint) {
                    AlertDialog.show({ message: "请获取中心点坐标" })
                    return
                  }
                  this.addNearbyFence()
                } else if (this.GeoFenceType === 5) {
                  this.addDistrictFence()
                }
              })
            Button("模拟导航")
              .onClick(() => {
                this.mockLocation()
              })
            /*Button("获取全部围栏")
              .onClick(() => {
                this.getAllGeoFence()
              })*/
          }
          .width("100%")
          .justifyContent(FlexAlign.Center)

        }
        .width("100%")
        .padding(10)
        .backgroundColor("#ffffff")
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Start)
        .opacity(0.8)
        .flexShrink(0)

        Stack() {
          MapViewComponent({ mapViewName: "GeoFencePage" })
            .width('100%')
            .height('100%')
          Column() {
            if (this.fenceList && this.fenceList.length > 0) {
              Row({ space: 10 }) {
                ForEach(this.fenceList.convertToArray(), (item: GeoFence) => {
                  Button("删除围栏：" + item.getCustomId()).onClick(() => {
                    this.fenceClient?.removeSpecifyGeoFence(item)
                  })
                })
              }
              .width("100%")
              .backgroundColor("#ffffff")
              .opacity(0.8)
              .position({ top: 0, right: 0 })
              .justifyContent(FlexAlign.Start)
            }
            if (this.tvResult) {
              Column() {
                Text(this.tvResult)
              }
              .alignItems(HorizontalAlign.Start)
              .width("100%")
              .backgroundColor("#ffffff")
              .opacity(0.8)
              .position({ bottom: 0, right: 0 })
            }
          }
          .width("100%")
          .height("100%")
          .hitTestBehavior(HitTestMode.Transparent)
        }
        .width("100%")
      }
      .width("100%")
      .height("100%")
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
      this.GeoFenceType = this.pageInfos.getParamByName("GeoFencePage")[0] as number
      if (this.GeoFenceType === 6) {
        this.GeoSelectFenceType = true
        this.GeoFenceType = 1
      }
      this.tips = this.GeoFenceType === 2 ? '请点击地图选择围栏的边界点，至少3个' : '请点击地图选择围栏的中心点'
    })
  }

  aboutToAppear(): void {
    let flag = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_SIGNATURE_INFO;
    let bundleInfo = bundleManager.getBundleInfoForSelfSync(flag)
    let appId = bundleInfo.signatureInfo.appId;
    console.log("appid==="+appId)

    //初始化地图相关
    MapsInitializer.setDebugMode(true);
    MapsInitializer.setApiKey(key);
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);

    // 初始化地理围栏
    this.fenceClient = new GeoFenceClient(this.context);
    //设置添加围栏监听
    this.fenceClient.setGeoFenceListener(this.geoFenceListener);
    //默认监听进入围栏
    this.fenceClient.setActivateAction(GeoFenceClient.GEOFENCE_IN);

    //定位相关配置
    AMapLocationManagerImpl.setApiKey(key);
    if (this.locationManger === undefined) {
      this.locationManger = new AMapLocationManagerImpl(this.context);
    }

    //订阅广播
    const EVENT_NAME = 'GeoFence';
    // 收到eventId为1的事件后执行回调函数
    emitter.on(EVENT_NAME, this.emitterCallback);

  }

  aboutToDisappear(): void {
    MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    this.mapView?.onDestroy();
    this.fenceClient?.removeGeoFence();
    this.fenceClient = undefined
    this.handler.removeAllMessage()
    emitter.off('GeoFence')
  }

  //地图回调
  mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }

    if (mapViewName != "GeoFencePage") {
      return;
    }
    
    this.mapView = mapview;
    this.mapView.onCreate();
    this.mapView.getMapAsync(async (map) => {
      this.aMap = map;
      this.aMap.moveCamera(CameraUpdateFactory.zoomBy(6))
      this.aMap.getUiSettings()?.setRotateGesturesEnabled(false)
      this.aMap.getUiSettings()?.setMyLocationButtonEnabled(true)
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true)

      let locationStyle: MyLocationStyle = new MyLocationStyle();
      let icon = await BitmapDescriptorFactory.fromRawfilePath(this.context, "common/location_map_gps_locked.png");
      if (icon) {
        locationStyle.myLocationIcon(icon);
      }
      locationStyle.radiusFillColor(Utils.argb(0, 0, 0, 0));
      locationStyle.strokeColor(Utils.argb(0, 0, 0, 0));
      locationStyle.myLocationType(MyLocationStyle.LOCATION_TYPE_LOCATE);
      this.aMap.setMyLocationStyle(locationStyle);
      this.aMap.setLocationSource(this);
      this.aMap.setMyLocationEnabled(true)
      //设置点击地图监听
      this.aMap.setOnMapClickListener((point: LatLng) => {
        switch (this.GeoFenceType) {
          case 1:
          case 4:
            this.centerPoint = point
            this.tips = "选中的坐标：" + point.longitude + "," + point.latitude
            this.addCenterMarker(point)
            break
          case 2:
            this.polygonPoints.add(point);
            this.tips = "已选择" + this.polygonPoints.length + "个点"
            this.addPolygonMarker(point)
            break
          default:
            break
        }
      })
      //设置点击兴趣点监听
      this.aMap.addOnPOIClickListener((poi: Poi) => {
        let clickdedPoint = poi.getClickedCoordinate()
        let point = clickdedPoint
        if(point == undefined){
          console.log(Constants.MODULETAG, TAG + " ====> <addOnPOIClickListener> error ,point == undefined");
          return;
        }
        switch (this.GeoFenceType) {
          case 1:
          case 4:
            this.centerPoint = point
            this.tips = "选中的坐标：" + point.longitude + "," + point.latitude
            this.addCenterMarker(point)
            break
          case 2:
            this.polygonPoints.add(point);
            this.tips = "已选择" + this.polygonPoints.length + "个点"
            this.addPolygonMarker(point)
            break
          default:
            break
        }
      })
    })
  };
  //定位回调
  locationlistener: IAMapLocationListener = {
    onLocationChanged: async (location) => {
      this.location = location
      if (this.listenerListener) {
        this.listenerListener.onLocationChanged(this.location);
      }
      this.fenceClient?.doCheckFence(this.location)
    }, onLocationError: (error) => {
      let errText: string = "定位失败," + error.errorCode + ": " + error.errorMsg;
      this.tvResult += errText
    }
  }
  //定位配置
  locationOptions: AMapLocationOption = {
    priority: geoLocationManager.LocationRequestPriority.FIRST_FIX,
    scenario: geoLocationManager.LocationRequestScenario.UNSET,
    maxAccuracy: 0,
    singleLocationTimeout: 3000,
    allowsBackgroundLocationUpdates: false,
    locatingWithReGeocode: false,
    reGeocodeLanguage: AMapLocationReGeocodeLanguage.Chinese,
    isOffset: true
  }
  //地理围栏回调
  geoFenceListener: GeoFenceListener = {
    onGeoFenceCreateFinished: (geoFenceList: ArrayList<GeoFence>, errorCode: number, customId: string): void => {
      if (errorCode == GeoFence.ADDGEOFENCE_SUCCESS) {
        this.promptAction.showToast({ message: '添加围栏成功' })
        for (let geoFence of geoFenceList) {
          if (this.GeoFenceType == 1 || this.GeoFenceType == 3 || this.GeoFenceType == 4) {
            this.drawCircle(geoFence)
          } else if (this.GeoFenceType == 2 || this.GeoFenceType == 5) {
            this.drawPolygon(geoFence)
          }
        }
        // 设置所有maker显示在当前可视区域地图中
        let bounds: LatLngBounds | undefined = this.boundsBuilder.build();
        if (this.aMap && bounds) {
          this.aMap.moveCamera(CameraUpdateFactory.newLatLngBounds(bounds, 150));
        }
        this.checkFence()
        this.removeMarkers()
      } else {
        this.promptAction.showToast({ message: '添加围栏失败' + errorCode })
      }
      /*this.getAllGeoFence()*/
    }
  }
  //广播回调
  emitterCallback: Callback<emitter.EventData> = (eventData: emitter.EventData) => {
    if (eventData?.data) {
      let geoFence: object = JSON.parse(eventData?.data['geoFence'])
      switch (Number.parseInt(geoFence['status'])) {
        case GeoFence.STATUS_IN:
          this.tvResult = this.tvResult + "当前位置进入" + geoFence['customId'] + "围栏\n"
          break;
        case GeoFence.STATUS_OUT:
          this.tvResult = this.tvResult + "当前位置离开" + geoFence['customId'] + "围栏\n"
          break;
        case GeoFence.STATUS_STAYED:
          this.tvResult = this.tvResult + "当前位置停留在" + geoFence['customId'] + "围栏\n"
          break;
        default:
          break
      }
    }
  }
  /**
   * 消息通知
   */
  handler: Handler = new Handler((message: Message) => {
    try {
      let bundle: HashMap<string, ESObject> | undefined = message.getBundle()
      switch (message.what) {
        case 0:
          //单次定位
          this.locationManger?.setLocationOption(AMapLocationType.Single, this.locationOptions)
          this.locationManger?.setLocationListener(AMapLocationType.Single, this.locationlistener)
          this.locationManger?.requestSingleLocation()
          break;
        case 1:
          //连续定位
          this.locationManger?.setLocationOption(AMapLocationType.Updating, this.locationOptions)
          this.locationManger?.setLocationListener(AMapLocationType.Updating, this.locationlistener)
          this.locationManger?.startUpdatingLocation()
          break;
        case 2:
          //模拟定位
          this.locationManger?.stopUpdatingLocation()
          this.locationlistener.onLocationChanged(bundle?.get('location'))
          break;
        case 3:
          break;
        default:
          break;
      }
    } catch (e) {
      LogUtil.e(Constants.MODULETAG, TAG + " ====> <handler>", e)
    }
  })

  activate(listener: OnLocationChangedListener): void {
    this.listenerListener = listener
    let msg: Message = new Message(1)
    this.handler.sendMessage(msg)
  }

  deactivate() {
  }

  /**
   * 添加中心点marker
   */
  async addCenterMarker(latlng: LatLng) {
    //设置mark样式
    let markerOption: MarkerOptions = new MarkerOptions()
    let icon = await BitmapDescriptorFactory.fromRawfilePath(this.context, "common/YELLOW.png")
    if (icon) {
      markerOption.setIcon(icon)
    }
    if (!this.centerMarker) {
      this.centerMarker = this.aMap?.addMarker(markerOption);
    }
    this.centerMarker?.setPosition(latlng);
    this.centerMarker?.setVisible(true);
    this.markerList.add(this.centerMarker);
  }

  /**
   * 添加多边形的边界点marker
   * @param latlng
   */
  async addPolygonMarker(latlng: LatLng) {
    //设置mark样式
    let markerOption: MarkerOptions = new MarkerOptions()
    let icon = await BitmapDescriptorFactory.fromRawfilePath(this.context, "common/YELLOW.png")
    if (icon) {
      markerOption.setIcon(icon)
    }
    markerOption.setPosition(latlng);
    let marker: Marker | undefined = this.aMap?.addMarker(markerOption);
    this.markerList.add(marker);
  }

  /**
   * 删除marker
   */
  removeMarkers() {
    if (this.centerMarker) {
      this.centerMarker.remove();
      this.centerMarker = undefined
    }
    if (this.markerList && this.markerList.length > 0) {
      for (let marker of this.markerList) {
        marker.remove();
      }
      this.markerList.clear();
    }
  }

  /**
   * 添加圆形围栏
   */
  addRoundFence() {
    let centerPoint: DPoint = new DPoint(this.centerPoint?.latitude, this.centerPoint?.longitude)
    this.fenceClient?.addRoundGeoFence(centerPoint, this.etRadius, this.etCustomerId)
  }

  /**
   * 添加多边形围栏
   */
  addPolygonFence() {
    let pointList = new ArrayList<DPoint>();
    for (let latLng of this.polygonPoints) {
      pointList.add(new DPoint(latLng.latitude, latLng.longitude));
    }
    this.fenceClient?.addPolygonGeoFence(pointList, this.etCustomerId);
  }

  /**
   * 添加关键字围栏
   */
  addKeywordFence() {
    this.fenceClient?.addKeywordGeoFence(this.etKeyword, this.etPoiType, this.etCity,
      this.etFenceSize != 0 ? this.etFenceSize : 10, this.etCustomerId);
  }

  /**
   *添加周边围栏
   */
  addNearbyFence() {
    this.fenceClient?.addNearbyGeoFence(this.etKeyword, this.etPoiType,
      new DPoint(this.centerPoint?.latitude, this.centerPoint?.longitude), this.etRadius,
      this.etFenceSize != 0 ? this.etFenceSize : 10, this.etCustomerId);
  }

  /**
   *添加行政区围栏
   */
  addDistrictFence() {
    this.fenceClient?.addDistrictGeoFence(this.etKeyword, this.etCustomerId);
  }

  /**
   * 绘制圆形围栏
   */
  drawCircle(fence: GeoFence) {
    let centerPoint: DPoint | undefined = fence.getCenter()
    if (centerPoint) {
      let center: LatLng = new LatLng(centerPoint.getLatitude(), centerPoint.getLongitude());
      // 绘制一个圆形
      this.aMap?.addCircle(
        new CircleOptions()
          .setCenter(center)
          .setRadius(fence.getRadius())
          .setStrokeColor(Utils.argb(180, 63, 145, 252))
          .setFillColor(Utils.argb(163, 118, 212, 243))
          .setStrokeWidth(5));
      this.boundsBuilder.include(center);
    }
  }

  /**
   * 绘制多边形围栏
   */
  drawPolygon(fence: GeoFence) {
    let pointList = fence.getPointList();
    if (!pointList || pointList.length == 0) {
      return;
    }
    for (let subList of pointList) {
      let lst: LatLng[] = []

      let polygonOption = new PolygonOptions();
      for (let point of subList) {
        lst.push(new LatLng(point.getLatitude(), point.getLongitude()));
        this.boundsBuilder.include(
          new LatLng(point.getLatitude(), point.getLongitude()));
      }
      polygonOption
        .add(...lst)
        .setZIndex(0)
        .setStrokeColor(Utils.argb(180, 63, 145, 252))
        .setFillColor(Utils.argb(163, 118, 212, 243))
        .setStrokeWidth(5);
      this.aMap?.addPolygon(polygonOption);
    }
  }

  /**
   * 校验围栏
   */
  checkFence() {
    //校验当前位置是否在围栏中
    this.fenceClient?.doCheckFence(this.location)
  }

  /**
   * 获取所有围栏
   */
  getAllGeoFence() {
    let geoFenceList = this.fenceClient?.getAllGeoFence()
    if (geoFenceList) {
      this.fenceList = geoFenceList
    }
  }

  /**
   * 模拟定位导航
   */
  async mockLocation() {
    let mockLocation: string[] =
      ['116.490069,40.002724', '116.49037,40.002874', '116.489851,40.003414', '116.489851,40.003414',
        '116.489235,40.004068', '116.488978,40.003796', '116.488817,40.003656', '116.488523,40.003393',
        '116.488093,40.00299', '116.487821,40.002754', '116.487152,40.002332', '116.486956,40.002131',
        '116.486782,40.001982', '116.4862,40.001456']
    for (let loc of mockLocation) {
      let latitude: number = Number.parseFloat(loc.split(',')[1])
      let longitude: number = Number.parseFloat(loc.split(',')[0])
      let location: AMapLocation = {
        latitude: latitude,
        longitude: longitude,
        altitude: 0,
        accuracy: 12,
        speed: 0,
        timeStamp: new Date().getTime(),
        direction: 0,
        timeSinceBoot: new Date().getTime(),
        isOffset: false
      }

      if (this.handler) {
        let msg: Message = new Message(2)
        let bundle: HashMap<string, ESObject> = new HashMap<string, ESObject>()
        bundle.set('location', location)
        msg.setBundle(bundle)
        this.handler.sendMessage(msg);
      }

      await this.delay(1000)
    }
  }

  delay(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
}