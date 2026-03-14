import {
  AMapException,
  DistrictItem,
  DistrictResult,
  DistrictSearch,
  DistrictSearchQuery,
  LatLonPoint,
  OnDistrictSearchListener
} from "@amap/amap_lbs_search"
import { HashMap, ArrayList } from "@kit.ArkTS"
import { Constants } from "../../utils/Constants"
import { ToastUtil } from "../../utils/ToastUtil"

/**
 * 行政区划查询
 */
@Component
export struct DistrictController {
  @Consume('pageInfos') pageInfos: NavPathStack
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  /**
   * 行政区划，国家级
   */
  public static readonly COUNTRY = 'country'
  /**
   * 行政区划，省级
   */
  public static readonly PROVINCE = 'province'
  /**
   * 行政区划，市级
   */
  public static readonly CITY = 'city'
  /**
   * 行政区划，区级
   */
  public static readonly DISTRICT = 'district'
  /**
   * 行政区划，商圈级
   */
  public static readonly BUSINESS = 'biz_area'
  /**
   * 当前选中的级别
   */
  @State selectedLevel: string = DistrictController.COUNTRY
  /**
   * 当前行政区划
   */
  @State currentDistrictItem: DistrictItem | undefined = undefined
  /**
   * 下级行政区划集合
   */
  private subDistrictMap = new HashMap<String, ArrayList<DistrictItem>>()
  /**
   * 省级列表
   */
  @State provinceList: ArrayList<DistrictItem> = new ArrayList<DistrictItem>()
  /**
   * 市级列表
   */
  @State cityList: ArrayList<DistrictItem> = new ArrayList<DistrictItem>()
  /**
   * 区县级列表
   */
  @State districtList: ArrayList<DistrictItem> = new ArrayList<DistrictItem>()
  /**
   * 是否已经初始化
   */
  private isInit: boolean = false
  @State countryInfo: string = ''
  @State provinceInfo: string = ''
  @State cityInfo: string = ''
  @State districtInfo: string = ''
  @State currentProvince: string = ''
  @State currentProvinceIndex: number = -1
  @State currentCity: string = ''
  @State currentCityIndex: number = -1
  @State currentDistrict: string = ''
  @State currentDistrictIndex: number = -1
  @State arrowPosition: ArrowPosition = ArrowPosition.END
  @State provinceArray: Array<SelectOption> = new Array<SelectOption>()
  @State cityArray: Array<SelectOption> = new Array<SelectOption>()
  @State districtArray: Array<SelectOption> = new Array<SelectOption>()

  aboutToAppear(): void {
    this.init()
  }

  /**
   * 初始化
   */
  private init() {
    if (!this.context) {
      return
    }
    /**
     * 设置行政区划查询监听
     */
    let districtSearch: DistrictSearch | undefined
    try {
      districtSearch = new DistrictSearch(this.context)
      districtSearch.setOnDistrictSearchListener(this.onDistrictSearchListener)
      /**
       * 查询中国的区划
       */
      let query = new DistrictSearchQuery()
      query.setKeywords("中国")
      districtSearch.setQuery(query)
      /**
       * 异步查询行政区
       */
      districtSearch.searchDistrictAsyn()
    } catch (e) {
    }
  }

  /**
   * 获取行政区划的信息字符串
   * @param districtItem
   * @return
   */
  private getDistrictInfoStr(districtItem: DistrictItem): string {
    let sb = ''
    let name: string | undefined = districtItem.getName()
    let adCode: string | undefined = districtItem.getAdCode()
    let level: string | undefined = districtItem.getLevel()
    let cityCode: string | undefined = districtItem.getCityCode()
    let center: LatLonPoint | undefined = districtItem.getCenter()
    sb += '区划名称:' + (name ?? '') + '\n'
    sb += '区域编码:' + (adCode ?? '') + '\n'
    sb += '城市编码:' + (cityCode ?? '') + '\n'
    sb += '区划级别:' + (level ?? '') + '\n'
    if (center) {
      sb += '经纬度:(' + center.getLongitude() + ', '
        + center.getLatitude() + ')\n'
    }
    return sb.toString()
  }

  /**
   * 查询下级区划
   *
   * @param districtItem
   * 要查询的区划对象
   */
  private querySubDistrict(districtItem: DistrictItem) {
    if (!this.context) {
      return
    }
    let districtSearch: DistrictSearch | undefined
    try {
      districtSearch = new DistrictSearch(this.context)
      districtSearch.setOnDistrictSearchListener(this.onDistrictSearchListener)
      // 异步查询行政区
      let query = new DistrictSearchQuery()
      query.setKeywords(districtItem.getName() ?? '')
      districtSearch.setQuery(query)
      districtSearch.searchDistrictAsyn()
    } catch (e) {
    }
  }

  /**
   * 接口请求数据回调
   */
  private onDistrictSearchListener: OnDistrictSearchListener = {
    onDistrictSearched: (districtResult: DistrictResult | undefined): void => {
      let subDistrictList: ArrayList<DistrictItem> | undefined
      if (districtResult) {
        let mapException = districtResult.getAMapException()
        if (mapException && mapException.getErrorCode() === AMapException.CODE_AMAP_SUCCESS) {
          let district = districtResult.getDistrict()
          if (district && district.length) {
            if (!this.isInit) {
              this.isInit = true;
              this.currentDistrictItem = district[0]
              if (this.currentDistrictItem) {
                this.countryInfo = this.getDistrictInfoStr(this.currentDistrictItem)
              }
            }
            // 将查询得到的区划的下级区划写入缓存
            for (let i = 0; i < district.length; i++) {
              let districtItem = district[i]
              if (districtItem.getAdCode() && districtItem.getSubDistrict()) {
                this.subDistrictMap.set(districtItem.getAdCode(), districtItem.getSubDistrict())
              }
            }
            // 获取当前区划的下级区划列表
            if (this.currentDistrictItem) {
              subDistrictList = this.subDistrictMap.get(this.currentDistrictItem.getAdCode())
            }
          }
        } else {
          if (mapException) {
            ToastUtil.showError(this.uiContext, mapException.getErrorCode())
          }
        }
        this.setSpinner(subDistrictList)
      }
    }
  }

  /**
   * 设置spinner视图
   * @param subDistrictList
   */
  private setSpinner(subDistrictList: ArrayList<DistrictItem> | undefined) {
    let nameList = new ArrayList<SelectOption>()
    if (subDistrictList && subDistrictList.length > 0) {
      subDistrictList.forEach((districtItem) => {
        if (districtItem) {
          let name = districtItem.getName()
          if (name) {
            let selectOption: SelectOption = {
              value: name
            }
            nameList.add(selectOption)
          }
        }
      })

      if (this.selectedLevel === DistrictController.COUNTRY) {
        this.provinceList = subDistrictList
        this.provinceArray = Array.from(nameList)
        this.currentProvinceIndex = 0
        this.currentProvince = this.provinceArray[0].value.toString()

        this.selectedLevel = DistrictController.PROVINCE
        let districtItem = this.provinceList[0]
        this.provinceInfo = this.getDistrictInfoStr(districtItem)
        this.onSelectItem(districtItem)

      } else if (this.selectedLevel === DistrictController.PROVINCE) {
        this.cityList = subDistrictList
        this.cityArray = Array.from(nameList)
        this.currentCityIndex = 0
        this.currentCity = this.cityArray[0].value.toString()

        this.selectedLevel = DistrictController.CITY
        let districtItem = this.cityList[0]
        this.cityInfo = this.getDistrictInfoStr(districtItem)
        this.onSelectItem(districtItem)
      } else if (this.selectedLevel === DistrictController.CITY) {
        //如果没有区县，将区县说明置空
        if (!nameList || nameList.length <= 0) {
          this.districtInfo = ''
        }
        if (nameList && nameList.length > 0) {
          this.districtList = subDistrictList
          this.districtArray = Array.from(nameList)
          this.currentDistrictIndex = 0
          this.currentDistrict = this.districtArray[0].value.toString()

          this.selectedLevel = DistrictController.DISTRICT
          let districtItem = this.districtList[0]
          this.districtInfo = this.getDistrictInfoStr(districtItem)
          this.onSelectItem(districtItem)

        } else {
          this.currentDistrictIndex = -1
          this.currentDistrict = ''
          this.districtInfo = ''
        }
      }
    } else {
      let emptyNameList = new ArrayList<SelectOption>()
      if (this.selectedLevel === DistrictController.COUNTRY) {
        this.provinceArray = Array.from(emptyNameList)
        this.cityArray = Array.from(nameList)
        this.districtArray = Array.from(nameList)
        this.provinceInfo = ''
        this.cityInfo = ''
        this.districtInfo = ''
        this.currentProvince = ''
        this.currentCity = ''
        this.currentDistrict = ''
      }
      if (this.selectedLevel === DistrictController.PROVINCE) {
        this.cityArray = Array.from(nameList)
        this.districtArray = Array.from(nameList)
        this.cityInfo = ''
        this.districtInfo = ''
        this.currentCity = ''
        this.currentDistrict = ''
      }
      if (this.selectedLevel === DistrictController.CITY) {
        this.districtArray = Array.from(nameList)
        this.districtInfo = ''
        this.currentDistrict = ''
      }
    }
  }

  build() {
    NavDestination() {
      this.buildDistrict()
    }
    .title(Constants.MAP_DISTRICT_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })

  }

  @Builder
  buildDistrict() {
    Column() {
      Text(this.countryInfo).width('100%')

      if (this.currentProvince) {
        //省
        Row() {
          Select(this.provinceArray)
            .selected(this.currentProvinceIndex)
            .value(this.currentProvince)
            .font({ size: 16, weight: 500 })
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .arrowPosition(this.arrowPosition)
            .menuAlign(MenuAlignType.START, { dx: 0, dy: 0 })
            .optionWidth(300)
            .divider({
              strokeWidth: '1px',
              color: '#33182431'
            })
            .onSelect((index: number, text: string) => {
              this.currentProvinceIndex = index
              this.selectedLevel = DistrictController.PROVINCE
              let districtItem = this.provinceList[index]
              this.provinceInfo = this.getDistrictInfoStr(districtItem)
              this.onSelectItem(districtItem)
              if (text) {
                this.currentProvince = text
              }
            })
          Text('省').width('100%').margin({ left: 16 })
        }.width('100%').margin({ top: 8, bottom: 8 })

        Text(this.provinceInfo).width('100%')
      }

      //市
      if (this.currentCity) {
        Row() {
          Select(this.cityArray)
            .selected(this.currentCityIndex)
            .value(this.currentCity)
            .font({ size: 16, weight: 500 })
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .arrowPosition(this.arrowPosition)
            .menuAlign(MenuAlignType.START, { dx: 0, dy: 0 })
            .optionWidth(300)
            .divider({
              strokeWidth: '1px',
              color: '#33182431'
            })
            .onSelect((index: number, text: string) => {
              this.currentCityIndex = index
              this.selectedLevel = DistrictController.CITY
              let districtItem = this.cityList[index]
              this.cityInfo = this.getDistrictInfoStr(districtItem)
              this.onSelectItem(districtItem)
              if (text) {
                this.currentCity = text
              }
            })
          Text('市').width('100%').margin({ left: 16 })
        }.width('100%').margin({ top: 8, bottom: 8 })

        Text(this.cityInfo).width('100%')
      }

      if (this.currentDistrict) {
        //区/县
        Row() {
          Select(this.districtArray)
            .selected(this.currentDistrictIndex)
            .value(this.currentDistrict)
            .font({ size: 16, weight: 500 })
            .selectedOptionFont({ size: 16, weight: 400 })
            .optionFont({ size: 16, weight: 400 })
            .arrowPosition(this.arrowPosition)
            .menuAlign(MenuAlignType.START, { dx: 0, dy: 0 })
            .optionWidth(300)
            .divider({
              strokeWidth: '1px',
              color: '#33182431'
            })
            .onSelect((index: number, text: string) => {
              this.currentDistrictIndex = index
              this.selectedLevel = DistrictController.DISTRICT
              let districtItem = this.districtList[index]
              this.districtInfo = this.getDistrictInfoStr(districtItem)
              this.onSelectItem(districtItem)
              if (text) {
                this.currentDistrict = text
              }
            })
          Text('区/县').width('100%').margin({ left: 16 })
        }.width('100%').margin({ top: 8, bottom: 8 })

        Text(this.districtInfo).width('100%')
      }

    }.width('100%')
    .height('100%').padding({ left: 16, right: 16 })
  }

  private onSelectItem(districtItem: DistrictItem) {
    if (districtItem) {
      this.currentDistrictItem = districtItem
      // 先查缓存如果缓存存在则直接从缓存中查找，无需再执行查询请求
      let cache = this.subDistrictMap.get(districtItem.getAdCode())
      if (cache) {
        this.setSpinner(cache)
      } else {
        this.querySubDistrict(districtItem)
      }
    }
  }
}