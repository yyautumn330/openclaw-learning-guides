import { AMap,
  AMapUtils,
  BitmapDescriptorFactory,
  CameraUpdateFactory,
  LatLng,
  LatLngBoundsBuilder,
  MapView, MapViewComponent, MapViewCreateCallback, MapViewManager,
  Marker,
  MarkerOptions,
  OnMarkerDragListener,
  Polygon,
  PolygonOptions,} from "@amap/amap_lbs_map3d";
import { Constants } from "../../utils/Constants";

/**
 * 两点见距离计算 示例
 */
@Component
export struct CalculateDistanceController{
 
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  private mapView? : MapView;
  private aMap? : AMap;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
 
  private latLngA = new LatLng(39.926516, 116.389366);
  private latLngB = new LatLng(39.924870, 116.403270);
  private markerA: Marker | undefined = undefined;
  private markerB: Marker | undefined = undefined;
  private polygon: Polygon | undefined = undefined
  private isMoved: boolean = false
  @State distance: number = 0;
  @State area: number = 0
 
  onMarkDragStart = () => {
 
  }
 
  onMarkDrag = () => {
    if (this.markerA && this.markerB) {
      this.distance = AMapUtils.calculateLineDistance(this.markerA.getPosition(), this.markerB.getPosition())
      this.polygon?.remove()
 
      let pOption = new PolygonOptions()
      pOption.add(this.markerA.getPosition())
      pOption.add(new LatLng(this.markerA.getPosition().latitude, this.markerB.getPosition().longitude))
      pOption.add(this.markerB.getPosition())
      pOption.add(new LatLng(this.markerB.getPosition().latitude, this.markerA.getPosition().longitude))
      pOption.setStrokeWidth(4)
      this.polygon = this.aMap?.addPolygon(pOption)
      this.polygon?.setStrokeWidth(4)
      this.polygon?.setStrokeColor(0x32010101)
      this.polygon?.setFillColor(0x32010101)
 
      this.area = AMapUtils.calculateRectangleArea(this.markerA.getPosition(),this.markerB.getPosition())
 
    }
  }
 
  onMarkDragEnd = () => {
 
  }
 
  private markDragListener = new OnMarkerDragListener(this.onMarkDragStart, this.onMarkDrag, this.onMarkDragEnd)

  onPageShow(): void {
    this.mapView?.onResume();
  }

  onPageHide(): void {
    this.mapView?.onPause();
  }

  pageChange(changedPropertyName: string) {
    if (this.isPageHide === true) {
      this.onPageHide()
    } else {
      this.onPageShow()
    }
  }
 
  private setupMap() {
    const startOptions = new MarkerOptions().setPosition(this.latLngA);
    startOptions.setIcon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_ORANGE));
    this.markerA = this.aMap?.addMarker(startOptions)
    this.markerA?.setDraggable(true)
 
    const endOptions = new MarkerOptions().setPosition(this.latLngB);
    endOptions.setIcon(BitmapDescriptorFactory.defaultMarker(BitmapDescriptorFactory.HUE_CYAN));
    this.markerB = this.aMap?.addMarker(endOptions)
    this.markerB?.setDraggable(true)

    if (!this.isMoved) {
      this.aMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(39.925516, 116.395366), 15))
      this.isMoved = true
    }
    if (this.markerA && this.markerB) {
      this.distance = AMapUtils.calculateLineDistance(this.markerA.getPosition(), this.markerB.getPosition())
      this.area = AMapUtils.calculateRectangleArea(this.markerA.getPosition(),this.markerB.getPosition())
    }
    this.aMap?.setOnMarkerDragListener(this.markDragListener)
 
  }
 
 
  aboutToAppear(): void {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
    this.setupMap()
  }
 
  aboutToDisappear(): void {
    if (this.mapViewCreateCallback) {
      MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    }
 
    if (this.mapView) {
      this.mapView.onDestroy();
      this.mapView = undefined;
      this.aMap = undefined;
    }
  }
 
  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return;
    }
 
    if (mapViewName != Constants.MAP_CALCULATEDISTANCE_FUNC) {
      return;
    }
 
    this.mapView = mapview;
 
    this.mapView.onCreate();
    this.mapView.getMapAsync((map) => {
      this.aMap = map;
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true);
 
      this.setupMap();
    })
  }
 
  //显示地图
  @Builder
  buildMapShow() {
    MapViewComponent({mapViewName: Constants.MAP_CALCULATEDISTANCE_FUNC })
      .width("100%")
      .layoutWeight(1)
  }
 
  build() {
    NavDestination() {
      Stack() {
        this.buildMapShow();
        // 悬浮文本
        Text("长按Marker可拖动\n两点间距离为：" + this.distance.toFixed(4) + "m\n矩形面积为："+this.area.toFixed(4))
          .zIndex(1)
          .width('100%')
          .textAlign(TextAlign.Start)
          .position({ x: 0, y: 0 }) // 定位到左上角
          .padding({left: 10})
          .backgroundColor('#05FFFFAA') // 可选：半透明白色背景
      }
    }
    .title(Constants.MAP_CALCULATEDISTANCE_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop(); // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true;
    })
  }
}
