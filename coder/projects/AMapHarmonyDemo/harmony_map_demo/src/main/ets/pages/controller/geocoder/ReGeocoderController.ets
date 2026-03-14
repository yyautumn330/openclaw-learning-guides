import {
  MapViewManager,
  MapViewComponent,
  MapViewCreateCallback,
  MapView,
  LatLng,
  AMapOptions,
  AMap,
  CameraUpdateFactory,
  Marker,
  BitmapDescriptorFactory,
  MarkerOptions
} from "@amap/amap_lbs_map3d"
import { Constants } from "../../utils/Constants"
import { hilog } from "@kit.PerformanceAnalysisKit"
import {
  AMapException,
  GeocodeResult,
  GeocodeSearch,
  LatLonPoint,
  OnGeocodeSearchListener,
  ReGeocodeQuery,
  ReGeocodeResult
} from "@amap/amap_lbs_search"
import { AMapUtil } from "../../utils/AMapUtil"
import { ToastUtil } from "../../utils/ToastUtil"
import { ArrayList } from "@kit.ArkTS"
import { Loading } from "../../utils/Loading"

/**
 * 逆地理编码功能介绍
 */
@Component
export struct ReGeocoderController {
  @Consume('pageInfos') pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  private mapView?: MapView
  private aMap?: AMap
  private geocoderSearch?: GeocodeSearch
  private latLonPoint = new LatLonPoint(39.90865, 116.39751)
  private reGeoMarker?: Marker
  /**
   * loading状态
   */
  @State isLoading: boolean = false
  /**
   * 批量添加 逆地理编码 marker
   */
  private coords: Array<number> =
    [116.339925, 39.976587, 116.328467, 39.976357, 116.345289, 39.966556, 116.321428, 39.967477, 116.358421, 39.961556,
      116.366146, 39.961293, 116.359666, 39.953234, 116.373013, 39.948628, 116.355374, 39.94037, 116.41713, 39.940666,
      116.433309, 39.940929, 116.461933, 39.949319, 116.473907, 39.938461, 116.478971, 39.933854, 116.491631, 39.96603,
      116.489399, 39.971029, 116.495364, 39.98517, 116.530812, 39.99556, 116.5607, 39.996023, 116.525982, 40.022825,
      116.568511, 40.016843, 116.584046, 40.014608, 116.422599, 40.012439, 116.44131, 40.00616, 116.39303, 40.026998,
      116.384147, 40.039222, 116.388352, 39.928242]

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

  private readLatLonPoints() {
    let points: ArrayList<LatLonPoint> = new ArrayList<LatLonPoint>()
    for (let i = 0; i < this.coords.length; i += 2) {
      points.add(new LatLonPoint(this.coords[i+1], this.coords[i]))
    }
    return points
  }

  aboutToAppear() {
    MapViewManager.getInstance().registerMapViewCreatedCallback(this.mapViewCreateCallback)
    hilog.info(0xff, Constants.MAP_REGEOCODE_FUNC, "aboutToAppear")
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
      hilog.info(0xff, Constants.MAP_REGEOCODE_FUNC, "aboutToDisappear")
    }
  }

  /**
   * 逆地理编码 请求一个地址
   */
  private requestReGeocoder(latLonPoint: LatLonPoint) {
    if (this.geocoderSearch) {
      this.isLoading = true
      let query =
        new ReGeocodeQuery(latLonPoint, 200, GeocodeSearch.AMAP) // 第一个参数表示一个Latlng，第二参数表示范围多少米，第三个参数表示是火系坐标系还是GPS原生坐标系
      this.geocoderSearch.getFromLocationAsyn(query) // 设置异步逆地理编码请求
    }
  }

  /**
   * 逆地理编码 一次请求多个
   */
  private requestReGeocoderMultiple() {
    this.isLoading = true
    let reGeoPointList = this.readLatLonPoints()
    reGeoPointList.forEach(async (latLonPoint) => {
      if (latLonPoint && this.geocoderSearch && this.aMap) {
        try {
          // 第一个参数表示一个Latlng，第二参数表示范围多少米，第三个参数表示是火系坐标系还是GPS原生坐标系
          let query = new ReGeocodeQuery(latLonPoint, 200, GeocodeSearch.AMAP)
          // 设置同步逆地理编码请求
          let result = await this.geocoderSearch.getFromLocation(query)
          if (result) {
            let address = result.getFormatAddress()
            if (address) {
              this.aMap.addMarker(new MarkerOptions()
                .setPosition(new LatLng(latLonPoint.getLatitude(), latLonPoint.getLongitude()))
                .setTitle(address))
            }
          }
        } catch (e) {
          if (e instanceof AMapException) {
            let errorCode = e.getErrorCode()
            ToastUtil.showError(this.uiContext, errorCode)
          }
        }
      }
    })
    this.isLoading = false
  }

  /**
   * 接口请求数据回调
   */
  private onGeocodeSearchListener: OnGeocodeSearchListener = {
    onReGeocodeSearched: (reGeocodeResult: ReGeocodeResult | undefined, errorCode: number): void => {
      this.isLoading = false
      if (errorCode === AMapException.CODE_AMAP_SUCCESS) {
        if (reGeocodeResult && reGeocodeResult.getReGeocodeAddress()
          && reGeocodeResult.getReGeocodeAddress().getFormatAddress()) {
          if (this.aMap && this.reGeoMarker) {
            let addressName = reGeocodeResult.getReGeocodeAddress().getFormatAddress() + "附近"
            this.aMap.animateCamera(CameraUpdateFactory.newLatLngZoom(
              AMapUtil.convertToLatLng(this.latLonPoint), 15))
            this.reGeoMarker.setPosition(AMapUtil.convertToLatLng(this.latLonPoint))
            ToastUtil.show(this.uiContext, addressName)
          }
        } else {
          ToastUtil.show(this.uiContext, '对不起，没有搜索到相关数据！')
        }
      } else {
        ToastUtil.showError(this.uiContext, errorCode)
      }
    },
    onGeocodeSearched: (geocodeResult: GeocodeResult | undefined, errorCode: number): void => {

    }
  }

  build() {
    NavDestination() {
      this.buildMapGeocoder()
    }
    .title(Constants.MAP_REGEOCODE_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })

  }

  @Builder
  buildMapGeocoder() {
    Column() {

      Button('ResGeoCoding(39.90865,116.39751)').onClick(() => {
        // 请求 reGeocoder
        this.requestReGeocoder(this.latLonPoint)
      }).width('100%').height(60)

      Button('逆地理编码同步方法(线程池)').onClick(() => {
        this.requestReGeocoderMultiple()
      }).width('100%').height(60).margin({ top: 4 })

      MapViewComponent({ mapViewName: Constants.MAP_REGEOCODE_FUNC }).layoutWeight(1)

      Loading({
        isLoading: $isLoading
      })

    }.width('100%')
    .height('100%')
  }

  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return
    }

    if (mapViewName !== Constants.MAP_REGEOCODE_FUNC) {
      return
    }

    this.mapView = mapview

    this.mapView.onCreate()
    this.mapView.getMapAsync(async (map) => {
      this.aMap = map

      hilog.info(0xff, Constants.MAP_REGEOCODE_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom)


      // 添加定位 marker
      if (this.context) {
        let options: MarkerOptions = new MarkerOptions()
        options.setAnchor(0.5, 0.5)
        let bitmapDes =
          await BitmapDescriptorFactory.fromRawfilePath(this.context, "common/RED.png")
        if (bitmapDes) {
          options.setIcon(bitmapDes)
        }
        this.reGeoMarker = map.addMarker(options)
      }


      this.aMap?.setOnMapClickListener((point: LatLng) => {
        hilog.info(0xff, Constants.MAP_REGEOCODE_FUNC, `map click ${point.longitude} ${point.latitude}`)
      })
      this.aMap.getUiSettings()?.setScaleControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomPosition(AMapOptions.ZOOM_POSITION_RIGHT_BUTTOM)
      this.aMap?.getUiSettings()?.setZoomControlsEnabled(true)
    })

  }
}
