import {
  MapView,
  AMap,
  MapViewComponent,
  MapViewCreateCallback,
  AMapOptions,
  MapViewManager,
  CameraUpdateFactory,
  LatLng,
  PolylineOptions
} from "@amap/amap_lbs_map3d"
import { Constants } from "../../utils/Constants"
import { hilog } from "@kit.PerformanceAnalysisKit"
import {
  AMapException,
  DistrictItem,
  DistrictResult,
  DistrictSearch,
  DistrictSearchQuery,
  LatLonPoint,
  OnDistrictSearchListener
} from "@amap/amap_lbs_search"
import { ToastUtil } from "../../utils/ToastUtil"
import ArrayList from "@ohos.util.ArrayList"
import { window } from "@kit.ArkUI"

/**
 * 行政区划边界查询
 */
@Component
export struct DistrictWithBoundaryController {
  @Consume('pageInfos') pageInfos: NavPathStack
  @Consume('isPageHide') @Watch('pageChange') isPageHide: boolean
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  private mapView?: MapView
  private aMap?: AMap
  @State districtName: string = ''
  @State keyboardHeight: number = 0
  private indicatorHeight: number = 0

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
    let navigationIndicatorType = window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR;
    window.getLastWindow(this.context).then(currentWindow => {
      let avoidArea = currentWindow.getWindowAvoidArea(navigationIndicatorType);
      // Get the height of the navigation bar area
      this.indicatorHeight = avoidArea.bottomRect.height
      currentWindow.on('avoidAreaChange', data => {
        if (data.type === window.AvoidAreaType.TYPE_KEYBOARD) {
          this.keyboardHeight = this.uiContext.px2vp(data.area.bottomRect.height)
        }
      })
    }).catch((err : Error) => {
      hilog.error(0xff, Constants.MAP_DISTRICT_WITH_BOUNDARY_FUNC, 'err ' + err.message);
    })
    hilog.info(0xff, Constants.MAP_DISTRICT_WITH_BOUNDARY_FUNC, "aboutToAppear")
  }

  aboutToDisappear(): void {
    window.getLastWindow(this.context).then(currentWindow => {
      currentWindow.off('avoidAreaChange')
    }).catch((err : Error) => {
      hilog.error(0xff, Constants.MAP_DISTRICT_WITH_BOUNDARY_FUNC, 'err ' + err.message);
    })
    if (this.mapViewCreateCallback) {
      MapViewManager.getInstance().unregisterMapViewCreatedCallback(this.mapViewCreateCallback)
    }
    if (this.mapView) {
      this.mapView.onDestroy()
      this.mapView = undefined
      this.aMap = undefined
      hilog.info(0xff, Constants.MAP_DISTRICT_WITH_BOUNDARY_FUNC, "aboutToDisappear")
    }
  }

  build() {
    NavDestination() {
      this.buildMapDistrictWithBoundary()
    }
    .title(Constants.MAP_DISTRICT_WITH_BOUNDARY_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }

  @Builder
  private buildMapDistrictWithBoundary() {
    Column() {
      Row() {
        TextInput({ placeholder: "输入要查询的行政区域名称" })
          .type(InputType.Normal)
          .onChange((value: string) => {
            if (value) {
              this.districtName = value
            }
          })
          .layoutWeight(1)
          .height(48)
          .backgroundColor("#F0F0F0")
          .borderRadius(12)
          .border({ width: 2, color: '#007DFF' })
          .padding(6)

        Button('搜索').onClick(() => {
          this.requestDistrictWithBoundary()
        }).height(48).width(60)

      }.width('100%').height(48)

      MapViewComponent({ mapViewName: Constants.MAP_DISTRICT_WITH_BOUNDARY_FUNC })
        .layoutWeight(1)
        .padding({
          bottom: this.keyboardHeight - (this.keyboardHeight ? this.getUIContext().px2vp(this.indicatorHeight) : 0)
        })
    }.width('100%')
    .height('100%')
  }

  /**
   * 请求接口
   */
  private requestDistrictWithBoundary() {
    this.aMap?.clear()
    try {
      let districtSearch = new DistrictSearch(getContext())
      let query = new DistrictSearchQuery()
      query.setKeywords(this.districtName)
      query.setShowBoundary(true)
      districtSearch.setQuery(query)
      districtSearch.setOnDistrictSearchListener(this.onDistrictSearchListener)
      districtSearch.searchDistrictAsyn()
    } catch (e) {

    }
  }

  /**
   * 接口请求数据回调
   */
  private onDistrictSearchListener: OnDistrictSearchListener = {
    onDistrictSearched: (districtResult: DistrictResult | undefined): void => {
      if (!districtResult || !districtResult.getDistrict() || districtResult.getDistrict().length <= 0) {
        return
      }
      //通过ErrorCode判断是否成功
      let aMapException = districtResult.getAMapException()
      if (aMapException && aMapException.getErrorCode() === AMapException.CODE_AMAP_SUCCESS) {
        let item: DistrictItem | undefined = districtResult.getDistrict()?.[0]
        if (!item || !this.aMap) {
          return
        }
        let centerLatLng: LatLonPoint | undefined = item.getCenter()
        if (centerLatLng) {
          this.aMap.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(centerLatLng.getLatitude(),
            centerLatLng.getLongitude()), 8))
        }
        let districtArray = item.districtBoundary()
        if (!districtArray || districtArray.length <= 0) {
          return
        }
        for (let districtString of districtArray) {
          let pointList = districtString.split(";")
          let polylineOption = new PolylineOptions()
          let isFirst: boolean = true
          let firstLatLng: LatLng | undefined
          let latLngList: ArrayList<LatLng> = new ArrayList()
          for (let pointString of pointList) {
            let subList = pointString.split(",")
            if (isFirst) {
              isFirst = false
              firstLatLng = new LatLng(Number.parseFloat(subList[1]), Number.parseFloat(subList[0]))
            }
            latLngList.add(new LatLng(Number.parseFloat(subList[1]), Number.parseFloat(subList[0])))
          }
          if (firstLatLng) {
            latLngList.add(firstLatLng)
          }
          polylineOption.setWidth(10).setColor(0xff0000ff).setPoints(latLngList)
          this.aMap.addPolyline(polylineOption)
        }
      } else {
        if (aMapException) {
          ToastUtil.showError(this.uiContext, aMapException.getErrorCode())
        }
      }

    }
  }
  private mapViewCreateCallback: MapViewCreateCallback = (mapview?: MapView, mapViewName?: string) => {
    if (!mapview || this.mapView) {
      return
    }
    if (mapViewName !== Constants.MAP_DISTRICT_WITH_BOUNDARY_FUNC) {
      return
    }
    this.mapView = mapview
    this.mapView.onCreate()
    this.mapView.getMapAsync(async (map) => {
      this.aMap = map

      hilog.info(0xff, Constants.MAP_DISTRICT_WITH_BOUNDARY_FUNC, 'get map ' + this.aMap?.getCameraPosition()?.zoom)

      this.aMap.getUiSettings()?.setScaleControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomControlsEnabled(true)
      this.aMap.getUiSettings()?.setZoomPosition(AMapOptions.ZOOM_POSITION_RIGHT_BUTTOM)
    })
  }
}