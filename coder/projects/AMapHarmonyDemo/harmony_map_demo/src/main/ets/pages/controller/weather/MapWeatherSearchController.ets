import {
  AMapException,
  LocalDayWeatherForecast,
  LocalWeatherForecast,
  LocalWeatherForecastResult,
  LocalWeatherLive,
  LocalWeatherLiveResult,
  OnWeatherSearchListener,
  WeatherSearch,
  WeatherSearchQuery
} from "@amap/amap_lbs_search"
import { Constants } from "../../utils/Constants"
import { ArrayList } from "@kit.ArkTS"
import { ToastUtil } from "../../utils/ToastUtil"

/**
 * 天气查询 示例查询
 */
@Component
export struct MapWeatherSearchController {
  @Consume('pageInfos') pageInfos: NavPathStack
  uiContext: UIContext = this.getUIContext()
  context: Context | undefined = this.getUIContext().getHostContext()
  @State weatherSearch: WeatherSearch | undefined = undefined
  @State weatherLive: LocalWeatherLive | undefined = undefined
  @State weatherForecast: LocalWeatherForecast | undefined = undefined
  @State forecastList: ArrayList<LocalDayWeatherForecast> = new ArrayList<LocalDayWeatherForecast>()
  /**
   * 查询天气所在城市  输入 城市/行政区/adcode 均可
   */
  @State cityName: string = ''
  /**
   * 预报天气信息
   */
  @State forecast: string = ''

  aboutToAppear(): void {
    this.cityName = '北京市'
    this.doWeatherRequest()
  }

  build() {
    NavDestination() {
      Column() {
        this.buildSecondTitle(this.cityName)
        this.buildWeatherLive()
        this.buildWeatherForecast()
      }
      .width('100%')
      .height('100%')
      .padding(16)
      .backgroundColor('#548ED4')
      .alignItems(HorizontalAlign.Center)

    }
    .title(Constants.MAP_WEATHER_SEARCH_FUNC)
    .onBackPressed(() => {
      const popDestinationInfo = this.pageInfos.pop() // 弹出路由栈顶元素
      console.log('pop' + '返回值' + JSON.stringify(popDestinationInfo))
      return true
    })
  }

  /**
   * 标题
   * @param title 内容
   */
  @Builder
  buildTitle(title: string) {
    Text(title).fontSize(16).fontColor(Color.White)
  }

  /**
   * 大标题
   * @param title 内容
   */
  @Builder
  buildSecondTitle(title: string) {
    Text(title)
      .fontSize(30)
      .fontColor(Color.White)
      .width('50%')
      .textAlign(TextAlign.Center)
  }

  /**
   * 实时天气
   */
  @Builder
  buildWeatherLive() {
    if (this.weatherLive) {
      Row() {
        this.buildTitle('实时')
        if (this.weatherLive.getReportTime()) {
          this.buildTitle(this.weatherLive.getReportTime() + '   发布')
        }
      }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ top: 8 })

      Row() {
        if (this.weatherLive.getWeather()) {
          this.buildSecondTitle(this.weatherLive.getWeather() + '')
        }
        if (this.weatherLive.getTemperature()) {
          this.buildSecondTitle(this.weatherLive.getTemperature() + '°')
        }
      }.width('100%').margin({ top: 30 })

      Row() {
        if (this.weatherLive.getWindDirection()) {
          this.buildTitle(this.weatherLive.getWindDirection() + '风        ')
        }
        if (this.weatherLive.getWindPower()) {
          this.buildTitle(this.weatherLive.getWindPower() + '级')
        }
      }
      .width('60%')
      .margin({ top: 10 })

      Row() {
        if (this.weatherLive.getHumidity()) {
          this.buildTitle('湿度         ' + this.weatherLive.getHumidity() + '%')
        }
      }.width('60%')
      .margin({ top: 10 })
    }
  }

  /**
   * 预报天气
   */
  @Builder
  buildWeatherForecast() {
    if (this.weatherForecast) {

      Blank().height(30).width(1)

      Row() {
        this.buildTitle('预报')
        if (this.weatherForecast.getReportTime()) {
          this.buildTitle(this.weatherForecast.getReportTime() + '   发布')
        }
      }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({ top: 8 })

      Blank().height(30).width(1)

      if (this.forecast) {
        this.buildTitle(this.forecast)
      }
    }
  }

  /**
   * 天气查询接口回调
   */
  private weatherSearchListener: OnWeatherSearchListener = {
    onWeatherLiveSearched: (weatherLiveResult: LocalWeatherLiveResult | undefined, errorCode: number): void => {
      if (errorCode === AMapException.CODE_AMAP_SUCCESS) {
        if (weatherLiveResult && weatherLiveResult.getLiveResult()) {
          this.weatherLive = weatherLiveResult.getLiveResult()
        } else {
          ToastUtil.show(this.uiContext, '对不起，没有搜索到相关数据！')
        }
      } else {
        ToastUtil.showError(this.uiContext, errorCode)
      }
    },
    onWeatherForecastSearched: (weatherForecastResult: LocalWeatherForecastResult | undefined,
      errorCode: number): void => {
      if (errorCode === AMapException.CODE_AMAP_SUCCESS) {
        if (weatherForecastResult && weatherForecastResult.getForecastResult() &&
        weatherForecastResult.getForecastResult().getWeatherForecast() &&
          weatherForecastResult.getForecastResult().getWeatherForecast().length > 0) {
          this.weatherForecast = weatherForecastResult.getForecastResult()
          this.forecastList = this.weatherForecast.getWeatherForecast()
          this.fillForecast()
        } else {
          ToastUtil.show(this.uiContext, '对不起，没有搜索到相关数据！')
        }
      } else {
        ToastUtil.showError(this.uiContext, errorCode)
      }
    }
  }

  /**
   * 请求天气数据
   */
  private doWeatherRequest() {
    if (this.cityName) {
      this.searchLiveWeather()
      this.searchForecastWeather()
    }
  }

  /**
   * 预报天气查询
   */
  private searchForecastWeather() {
    if (!this.context) {
      return
    }
    try {
      //检索参数为城市和天气类型，实时天气为1、天气预报为2
      let query = new WeatherSearchQuery(this.cityName, WeatherSearchQuery.WEATHER_TYPE_FORECAST)
      this.weatherSearch = new WeatherSearch(this.context)
      this.weatherSearch.setOnWeatherSearchListener(this.weatherSearchListener)
      this.weatherSearch.setQuery(query)
      //异步搜索
      this.weatherSearch.searchWeatherAsyn()
    } catch (e) {
    }
  }

  /**
   * 实时天气查询
   */
  private searchLiveWeather() {
    if (!this.context) {
      return
    }
    try {
      //检索参数为城市和天气类型，实时天气为1、天气预报为2
      let query = new WeatherSearchQuery(this.cityName, WeatherSearchQuery.WEATHER_TYPE_LIVE)
      this.weatherSearch = new WeatherSearch(this.context)
      this.weatherSearch.setOnWeatherSearchListener(this.weatherSearchListener)
      this.weatherSearch.setQuery(query)
      //异步搜索
      this.weatherSearch.searchWeatherAsyn()
    } catch (e) {
    }
  }

  /**
   * 预报天气信息
   */
  private fillForecast() {
    let forecastString = ''
    this.forecastList.forEach((localDayWeatherForecast) => {
      if (localDayWeatherForecast) {
        let week = ''
        switch (Number(localDayWeatherForecast.getWeek())) {
          case 1:
            week = "周一"
            break
          case 2:
            week = "周二"
            break
          case 3:
            week = "周三"
            break
          case 4:
            week = "周四"
            break
          case 5:
            week = "周五"
            break
          case 6:
            week = "周六"
            break
          case 7:
            week = "周日"
            break
          default:
            break
        }
        let temp = ''
        if (localDayWeatherForecast.getDayTemp() && localDayWeatherForecast.getNightTemp()) {
          temp = localDayWeatherForecast.getDayTemp() + '°' + '/' + localDayWeatherForecast.getNightTemp() + '°'
        }
        let date = ''
        if (localDayWeatherForecast.getDate()) {
          date = localDayWeatherForecast.getDate() + ''
        }
        forecastString += date + '  ' + week + '                       ' + temp + '\n\n'
      }
    })
    this.forecast = forecastString
  }
}