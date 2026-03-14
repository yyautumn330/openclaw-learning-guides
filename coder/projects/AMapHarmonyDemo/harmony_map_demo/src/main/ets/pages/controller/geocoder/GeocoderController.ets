import {
  MapView,
  AMap,
  AMapOptions,
  LatLng,
  MapViewCreateCallback,
  MapViewComponent,
  MapViewManager,
  CameraUpdateFactory,
  MarkerOptions,
  BitmapDescriptorFactory,
  Marker
} from "@amap/amap_lbs_map3d"
import { Constants } from "../../utils/Constants"
import { hilog } from "@kit.PerformanceAnalysisKit"
import {
  AMapException,
  GeocodeQuery,
  GeocodeResult,
  GeocodeSearch,
  OnGeocodeSearchListener,
  ReGeocodeResult
} from "@amap/amap_lbs_search"
import { ToastUtil } from "../../utils/ToastUtil"
import { AMapUtil } from "../../utils/AMapUtil"
import { Loading } from "../../utils/Loading"

/**
 * 地理编码功能介绍
 */
@Component
export struct GeocoderController {
  @Consume('pageInfos') pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  private mapView?: MapView
  private aMap?: AMap
  private geocoderSearch?: GeocodeSearch
  private geoMarker?: Marker
  /**
   * loading状态
   */
  @State isLoading: boolean = false

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

  aboutToAppear() {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback)
    hilog.info(0xff, Constants.MAP_GEOCODE_FUNC, "aboutToAppear")
    //初始化 GeocodeSearch 设置监听
    if (this.context) {
      this.geocoderSearch = new GeocodeSearch(this.context)
      this.geocoderSearch.setOnGeocodeSearchListener(this.onGeocodeSearchListener)
    }
  }

  aboutToDisappear(): void {
    if (this.mapViewCreateCallback) {
      MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback)
    }

    if (this.mapView) {
      this.mapView.onDestroy()
      this.mapView = undefined
      this.aMap = undefined
      hilog.info(0xff, Constants.MAP_GEOCODE_FUNC, "aboutToDisappear")
    }
  }

  /**
   * 请求地理编码
   * @param name 地址
   * @param city 城市
   */
  private requestGeocoder(name: string, city: string) {
    try {
      if (this.geocoderSearch) {
        this.isLoading = true
        let query = new GeocodeQuery(name, city) // 第一个参数表示地址，第二个参数表示查询城市，中文或者中文全拼，citycode、adcode，
        this.geocoderSearch.getFromLocationNameAsyn(query) // 设置同步地理编码请求
      }
    } catch (e) {
      this.isLoading = false
    }
  }

  /**
   * 接口请求数据回调
   */
  private onGeocodeSearchListener: OnGeocodeSearchListener = {
    onReGeocodeSearched: (reGeocodeResult: ReGeocodeResult | undefined, errorCode: number): void => {


    },
    onGeocodeSearched: (geocodeResult: GeocodeResult | undefined, errorCode: number): void => {
      this.isLoading = false
      if (errorCode === AMapException.CODE_AMAP_SUCCESS) {
        if (geocodeResult && geocodeResult.getGeocodeAddressList() &&
          geocodeResult.getGeocodeAddressList().length > 0) {
          let address = geocodeResult.getGeocodeAddressList()[0]
          if (address && this.aMap && this.geoMarker) {
            let latLng = address.getLatLonPoint()
            if (latLng) {
              this.aMap.animateCamera(CameraUpdateFactory.newLatLngZoom(AMapUtil.convertToLatLng(latLng), 15))
              this.geoMarker.setPosition(AMapUtil.convertToLatLng(latLng))
              let addressName = "经纬度值:" + address.getLatLonPoint() + "\n位置描述:" + address.getFormatAddress()
              ToastUtil.show(this.uiContext, addressName)
            }
          }
        } else {
          ToastUtil.show(this.uiContext, '对不起，没有搜索到相关数据！')
        }
      } else {
        ToastUtil.showError(this.uiContext, errorCode)
      }
    }
  }

  @Builder
  buildMapGeocoder() {
    Column() {

      Button('GeoCoding(北京市朝阳区方恒国际中心A座)').onClick(() => {
        // 请求 geocoder
        this.requestGeocoder('北京市朝阳区方恒国际中心A座', '010')
      }).width('100%').height(60)

      MapViewComponent({ mapViewName: Constants.MAP_GEOCODE_FUNC }).layoutWeight(1)

      Loading({
        isLoading: $isLoading
      })

    }.width('100%')
    .height('100%')
  }

  build() {
    NavDestination() {
      this.buildMapGeocoder()
    }
    .title(Constants.MAP_GEOCODE_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })

  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return
    }

    if (mapViewName !== Constants.MAP_GEOCODE_FUNC) {
      return
    }

    this.mapView = mapview

    this.mapView.onCreate()
    this.mapView.getMapAsync(async (map) => {
      this.aMap = map

      hilog.info(0xff, Constants.MAP_GEOCODE_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom)

      // 添加定位 marker
      if (this.context) {
        let options: MarkerOptions = new MarkerOptions()
        options.setAnchor(0.5, 0.5)
        let bitmapDes =
          await BitmapDescriptorFactory.fromRawfilePath(this.context, "common/marker_default.png")
        if (bitmapDes) {
          options.setIcon(bitmapDes)
        }
        this.geoMarker = map.addMarker(options)
      }

      this.aMap?.setOnMapClickListener((point: LatLng) => {
        hilog.info(0xff, Constants.MAP_GEOCODE_FUNC, `map click ${point.longitude} ${point.latitude}`)
      })
      this.aMap.getUiSettings()?.setScaleControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomPosition(AMapOptions.ZOOM_POSITION_RIGHT_BUTTOM)
      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
    })
  }
}