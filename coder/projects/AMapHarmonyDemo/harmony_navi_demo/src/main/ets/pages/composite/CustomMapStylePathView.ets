import {
  AMap,
  AMapNaviComponent,
  AMapNaviFactory,
  AmapNaviType,
  AMapNaviViewOptions,
  IAMapCalcRouteResult,
  IAMapNavi,
  INaviInfo,
  INaviPoi,
  NaviType,
  AMapCarInfo,
  INaviLatLng} from '@amap/amap_lbs_navi'
import { LogUtil } from '@amap/amap_lbs_common';
import { NaviDemoLocationManager } from '../../utils/NaviDemoLocationManager';

import { ArrayList } from '@kit.ArkTS';
import { fileIo as fs } from '@kit.CoreFileKit';
import { MockLocationManager } from '../../mock/manger/MockLocationManager';

@Component
export struct CustomMapStylePathView {
  wayPoints: ArrayList<INaviPoi> = new ArrayList()
  @Prop isTruck: Boolean = false;
  @Consume('pageInfos') pageInfos: NavPathStack;
  @State  isSettingMenuEnabled:boolean = true
  @State mAMapNaviViewOptions:AMapNaviViewOptions = new AMapNaviViewOptions()
  naviInstance?: IAMapNavi

  /**
   * 文件名称 官网自己生成，放到rawfile文件夹下（自定义地图.data文件）
   */

  //生命周期方法
  aboutToAppear(): void {
    const fileName = '文件名称'
    const fileTest = CustomMapStylePathView.readFileContentsFromRawfile(getContext(this),fileName)
    if (fileTest) {
      CustomMapStylePathView.saveFileContents(getContext(this).cacheDir+`/${fileName}`,fileTest)
    }
    this.mAMapNaviViewOptions.setCustomMapStylePath(getContext(this).cacheDir+`/${fileName}`)
    this.initTestData()
    this.initNavi()
  }

  initNavi() {
    //申请地址：https://console.amap.com/dev/key/app，appId在日志中过滤即可获取
    const appkey = '此处替换官网申请的Key'
    this.naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)
    this.naviInstance.setIsUseInnerVoice(true)

    if (this.isTruck) {
      // 设置货车信息
      let carInfo: AMapCarInfo = new AMapCarInfo();
      carInfo.mCarType = 1;
      carInfo.mCarNumber = "黑A12222";
      carInfo.mVehicleSize = 1;
      carInfo.mVehicleLoad = 100;
      carInfo.mVehicleWeight = 99;
      carInfo.mVehicleLength = 25;
      carInfo.mVehicleWidth = 2;
      carInfo.mVehicleHeight = 4;
      carInfo.mVehicleAxis = 6;
      carInfo.mVehicleLoadSwitch = true;
      carInfo.isRestriction = true;
      this.naviInstance.setCarInfo(carInfo);
    }

    this.naviInstance.setMockLocationManager(MockLocationManager.getInstance())

    this.naviInstance.addAMapNaviListener({

      onNaviInfoUpdate: (naviInfo: INaviInfo) => {
        LogUtil.i('Navi_Demo','naviListener', 'onNaviInfoUpdate: ' + naviInfo.mRouteRemainDis + ' onUpdateNaviInfo curRouteName: ' + naviInfo.mCurRoadName)
      },

      onCalculateRouteSuccess: (routeResult: IAMapCalcRouteResult | null) => {
        console.info('demo 算路成功')
        // 开启模拟定位
        this.naviInstance?.startMockLocation();
      },

      onStartNavi: (type: number) => {
        console.info('onStartNavi: ' + type)
      }
    })
  }

  //红绿灯测试
  startLatLng: INaviLatLng = NaviDemoLocationManager.getInstance().getLocation().start
  endLatLng: INaviLatLng = NaviDemoLocationManager.getInstance().getLocation().end

  initTestData() {
    let arr = new ArrayList<INaviPoi>()

    //途径点
    let location1: INaviLatLng = { latitude: 39.833187, longitude: 116.458887 }
    let location2: INaviLatLng = { latitude: 39.945834, longitude: 116.397056 }

    let test1: INaviPoi = {
      coordinate: location1
    }
    let test2: INaviPoi = {
      coordinate: location2
    }
    arr.add(test1)
    arr.add(test2)

    this.wayPoints = arr
  }

  goback() {
    //其他操作
    console.info('退出导航页面')
    // >>>>>>>> 导航反初始化时序 <<<<<<<<<<<<<<

    // 停止mock定位信息
    this.naviInstance?.stopMockLocation();

    // 移除外部监听
    this.naviInstance?.removeAMapNaviListener({})

    // 停止导航
    this.naviInstance?.stopNavi()

    // 销毁导航单例对象
    AMapNaviFactory.destroyAMapNaviInstance()

    this.pageInfos.pop()
  }

  build() {
    NavDestination() {
      Stack(){
        AMapNaviComponent(
          {
            appCustomerConfig:{
              isNeedCalculateRouteWhenPresent: true,
              mType: AmapNaviType.Driver,
              //默认模拟导航
              mNaviType: NaviType.GPS,
              start: {
                coordinate: this.startLatLng
              },
              end: {
                coordinate: this.endLatLng
              },
              mRouteStrategy: 2,
              serviceAreaDetailsEnable: true,
              aMapNaviViewOptions:this.mAMapNaviViewOptions,
              goBack: () => {
                this.goback()
              },
            }
          }
        )
      }

    }.title('导航组件')
    .hideTitleBar(true)
    .onBackPressed(() => {
      this.goback()
      return true
    })
  }

  // 显示导航页面
  private showNaviPage() {
    console.info('显示导航页面')
  }


  /**
   * 读取文件内容
   * @param filePath 文件路径
   * @returns Uint8Array内容
   */
  public static readFileContents(filePath: string): Uint8Array | undefined{

    let buffer: ArrayBuffer = new ArrayBuffer(0);
    let file:fs.File |undefined = undefined;
    try{
      // 1. 打开文件
      const file = fs.openSync(filePath, fs.OpenMode.READ_ONLY);
      const stat = fs.statSync(file.fd);
      // 2. 获取文件大小并读取全部内容
      const fileSize = stat.size;
      buffer = new ArrayBuffer(fileSize);
      const readCount = fs.readSync(file.fd, buffer);
      if (readCount !== fileSize) {

        return undefined;
      }
    } catch (e) {

    }finally {
      CustomMapStylePathView.safelyCloseFile(file);
    }
    return new Uint8Array(buffer);
  }

  /**
   * 读取 rawfile 目录下的指定文件
   * @param context 应用上下文
   * @param rawfilePath rawfile 目录下的文件路径（如 'test.txt'）
   * @returns 文件内容的string，失败返回 ''
   */
  public static readFileContentsFromRawfile(context: Context,
    rawfilePath: string): Uint8Array | undefined {
    try {
      let fileByte: Uint8Array = context.resourceManager.getRawFileContentSync(rawfilePath);
      return fileByte
    } catch (error) {
      console.error(`getRawFileContentSync failed, error : ${error}`);
    }
    return undefined;
  }

  /**
   * 保存文件内容到指定文件目录
   * @param filePath
   * @param data
   */
  public static saveFileContents(filePath: string, data: Uint8Array): void {
    let outputStream: fs.Stream | null = null;
    try {
      // 创建并打开输出文件流
      outputStream = fs.createStreamSync(filePath, "w+");
      // let buf = new ArrayBuffer(data.buffer)
      outputStream.writeSync(data.buffer);
      // 强制刷新缓冲区，确保数据写入文件
      outputStream.flushSync();
    } catch (e) {

    } finally {
      CustomMapStylePathView.safelyCloseStream(outputStream);
    }
    return undefined;
  }

  /**
   *
   * @param file
   */
  private static safelyCloseFile(file: fs.File | undefined): void {
    if (file) {
      try {
        fs.closeSync(file.fd);
      } catch (e) {
      }
    }
  }

  /**
   *
   * @param stream
   */
  private static safelyCloseStream(stream: fs.Stream | null): void {
    if (stream) {
      try {
        stream.close();
      } catch (e) {
      }
    }
  }


}