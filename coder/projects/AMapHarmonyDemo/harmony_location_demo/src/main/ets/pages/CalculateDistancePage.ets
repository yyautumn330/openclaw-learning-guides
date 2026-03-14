import {
  AMap,
  BitmapDescriptorFactory,
  CameraUpdateFactory,
  LatLng,
  MapView,
  MapViewComponent,
  MapViewCreateCallback,
  MapViewManager,
  Marker,
  MarkerOptions,
  OnMarkerDragListener,
  Polygon,
  PolygonOptions
} from "@amap/amap_lbs_map3d";
import { AMapLocationManagerImpl, CoordinateConverter, DPoint } from "@amap/amap_lbs_location";
import { AMapPrivacyAgreeStatus, AMapPrivacyInfoStatus, AMapPrivacyShowStatus } from "@amap/amap_lbs_common";

const calculateDistanceTitle: string = "两点间距离计算";

@Builder
export function CalculateDistancePageBuilder() {
  CalculateDistancePage()
}

/**
 * 两点间距离计算 示例
 */
@Component
export struct CalculateDistancePage {
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  private mapView?: MapView;
  private aMap?: AMap;
  private latLngA = new DPoint(39.926516, 116.389366);
  private latLngB = new DPoint(39.924870, 116.403270);
  private markerA: Marker | undefined = undefined;
  private markerB: Marker | undefined = undefined;
  private polygon: Polygon | undefined = undefined
  @State distance: number = 0;
  onMarkDragStart = () => {

  }
  onMarkDrag = () => {
    if (this.markerA && this.markerB) {
      //计算两点间距离
      const positionA = this.markerA.getPosition();
      const positionB = this.markerB.getPosition();
      this.distance =
        CoordinateConverter.calculateLineDistance(new DPoint(positionA.latitude, positionA.longitude),
          new DPoint(positionB.latitude, positionB.longitude));
      console.log(`两点间距离：${this.distance}`);
    }
  }
  onMarkDragEnd = () => {

  }
  private markDragListener = new OnMarkerDragListener(this.onMarkDragStart, this.onMarkDrag, this.onMarkDragEnd)

  private setupMap() {
    const startOptions =
      new MarkerOptions().setPosition(new LatLng(this.latLngA.getLatitude(), this.latLngA.getLongitude()));
    const startIcon = BitmapDescriptorFactory.fromRawfilePathSync(this.context!, "common/RED.png");
    startOptions.setIcon(startIcon!);
    this.markerA = this.aMap?.addMarker(startOptions)
    this.markerA?.setDraggable(true)

    const endOptions =
      new MarkerOptions().setPosition(new LatLng(this.latLngB.getLatitude(), this.latLngB.getLongitude()));
    const endIcon = BitmapDescriptorFactory.fromRawfilePathSync(this.context!, "common/BLUE.png");
    endOptions.setIcon(endIcon!);
    this.markerB = this.aMap?.addMarker(endOptions)
    this.markerB?.setDraggable(true)

    this.aMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(39.925516, 116.395366), 15))
    if (this.markerA && this.markerB) {
      this.distance = CoordinateConverter.calculateLineDistance(this.latLngA, this.latLngB)
    }
    this.aMap?.setOnMarkerDragListener(this.markDragListener)

  }

  aboutToAppear(): void {
    const context = this.getUIContext().getHostContext();

    if (!context) {
      console.error('Context is null or undefined!');
      return;
    }
    AMapLocationManagerImpl.setApiKey("此处替换为官网key"); // 替换为你自己的 key

    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback);
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

    if (mapViewName != calculateDistanceTitle) {
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
    MapViewComponent({ mapViewName: calculateDistanceTitle })
      .width("100%")
      .layoutWeight(1)
  }

  build() {
    NavDestination() {
      Stack() {
        this.buildMapShow();
        // 悬浮文本
        Text("长按Marker可拖动\n两点间距离为：" + this.distance.toFixed(4) + "m")
          .zIndex(1)
          .width('100%')
          .textAlign(TextAlign.Start)
          .position({ x: 0, y: 0 })// 定位到左上角
          .padding({ left: 10 })
          .backgroundColor('#05FFFFAA') // 可选：半透明白色背景
      }
    }
    .title(calculateDistanceTitle)
  }
}