import { AMap, CameraUpdateFactory,
  Gradient,
  HeatMapLayer,
  HeatMapLayerOptions,
  LatLng, MapView, MapViewComponent, MapViewManager,
  WeightedLatLng } from "@amap/amap_lbs_map3d";
import { Constants } from "../../utils/Constants";
import { ArrayList } from "@kit.ArkTS";
import { ColorUtil } from "../../utils/ColorUtil";
import { Utils } from "@amap/amap_lbs_common";
import { HeatMapItem } from "@amap/amap_lbs_map3d";
import { hilog } from "@kit.PerformanceAnalysisKit";

@Component
export struct HoneycombHeatMapController {
  private mMapView?: MapView;
  private mAMap?: AMap;
  private loadHoney?: number

  @State
  heatDetail: string = ""

  private layer?: HeatMapLayer

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
    if (this.loadHoney) {
      clearInterval(this.loadHoney) // 注意：这里是 clearInterval，但你用的是 setTimeout，应为 clearTimeout
    }
    MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback);
    this.mMapView?.onDestroy()
  }

  private mapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mMapView) {
      return;
    }

    if (mapViewName != Constants.MAP_HEAT_HONEY) {
      return;
    }

    this.mMapView = mapview;
    this.mMapView.onCreate();

    this.mMapView.getMapAsync((map) => {
      this.mAMap = map;
      this.mAMap.getUiSettings()?.setZoomControlsEnabled(true);

      this.mAMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(36.673927, 119.996751), 8.5));

      this.loadHoney = setTimeout(() => {
        this.testHeatMapOverlay();
      });
    });
  }

  private testHeatMapOverlay() {

    this.mAMap?.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(36.673927, 119.996751), 8.5));

    let heatMapStr = Utils.uint8ArrayToString(HoneycombHeatMapController.readFileContentsFromAssets(getContext(), "heatmap/heatmap_honey.data"));
    let heatMapStrs = heatMapStr.split("\n");

    let weightlatlngs = new ArrayList<WeightedLatLng>();
    for (let str of heatMapStrs) {
      let dataItem = str.split(",");
      if (dataItem && dataItem.length == 3) {
        weightlatlngs.add(new WeightedLatLng(new LatLng(Number.parseFloat(dataItem[1]), Number.parseFloat(dataItem[0])), Number.parseFloat(dataItem[2])));
      } else {
        hilog.info(0xff, Constants.MAP_HEAT_HONEY, "read file failed");
      }
    }

    let colors = [
      ColorUtil.colorStringToNumber("#ecda9a"),
      ColorUtil.colorStringToNumber("#efc47e"),
      ColorUtil.colorStringToNumber("#f3ad6a"),
      ColorUtil.colorStringToNumber("#f7945d"),
      ColorUtil.colorStringToNumber("#f97b57"),
      ColorUtil.colorStringToNumber("#f66356"),
      ColorUtil.colorStringToNumber("#ee4d5a")
    ];
    let startPoints = new Array<number>(colors.length);
    for (let i = 0; i < startPoints.length; i++) {
      startPoints[i] = i * 1.0 / startPoints.length
    }

    let heatMapLayerOptions = new HeatMapLayerOptions();
    heatMapLayerOptions.weightedData(weightlatlngs);
    let gradient = new Gradient(colors, startPoints);
    heatMapLayerOptions.gradient(gradient);
    heatMapLayerOptions.size(6000);
    heatMapLayerOptions.gap(300);
    heatMapLayerOptions.setMinZoom(5);
    heatMapLayerOptions.setMaxZoom(19);
    heatMapLayerOptions.opacity(0.85);
    heatMapLayerOptions.setType(HeatMapLayerOptions.TYPE_HEXAGON);
    heatMapLayerOptions.setZIndex(1);

    this.layer = this.mAMap?.addHeatMapLayer(heatMapLayerOptions);

    // 点击事件保持原样
    this.mAMap?.setOnMapClickListener((latLng: LatLng) => {
      if (this.layer && this.mAMap && latLng) {
        let item: HeatMapItem | undefined = this.layer.getHeatMapItem(latLng);
        if (item) {
          let stringBuffer = "";
          stringBuffer += "热力中心：";
          stringBuffer += (item.getCenter() + "\n");
          stringBuffer += "热力值：";
          stringBuffer += (item.getIntensity() + "\n");
          let indexes = "";
          for (let integer of item.getIndexes()) {
            indexes += integer + ",";
          }
          stringBuffer += ("热力索引：" + indexes + "\n");
          stringBuffer += ("数据数量：" + item.getIndexes().length);
          this.updateHeatItemTv(stringBuffer.toString());
        } else {
          this.updateHeatItemTv("未找到热力信息");
        }
      }
    });
  }

  private updateHeatItemTv(text: string) {
    setTimeout(() => {
      if (text) {
        this.heatDetail = text;
      }
    }, 0);
  }

  public static readFileContentsFromAssets(context: Context, assetsPath: string) {
    const rawData: Uint8Array = context.resourceManager.getRawFileContentSync(assetsPath);
    return rawData;
  }

  onPageShow(): void {
    this.mMapView?.onResume();
  }

  onPageHide(): void {
    this.mMapView?.onPause();
  }

  @Builder heatDetailOverlay() {
    Column() {
      Text(`${this.heatDetail}`)
    }
    .width('100%')
    .height('100%')
    .alignItems(HorizontalAlign.Start)
    .hitTestBehavior(HitTestMode.Transparent)
  }

  build() {
    NavDestination() {
      Stack({ alignContent: Alignment.TopStart }) {
        MapViewComponent({ mapViewName: Constants.MAP_HEAT_HONEY })
          .overlay(this.heatDetailOverlay(), { align: Alignment.TopStart })
      }
      .width('100%')
      .height('100%')
      .align(Alignment.TopStart)
    }
    .title(Constants.MAP_HEAT_HONEY)
  }
}
