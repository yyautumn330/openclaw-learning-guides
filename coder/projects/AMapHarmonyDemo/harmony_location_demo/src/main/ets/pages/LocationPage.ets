import { IAMapLocationListener, AMapLocationManagerImpl, AMapLocationOption } from '@amap/amap_lbs_location'
import abilityAccessCtrl from '@ohos.abilityAccessCtrl';
import common from '@ohos.app.ability.common';
import { AMapPrivacyShowStatus, AMapPrivacyInfoStatus, AMapPrivacyAgreeStatus, } from '@amap/amap_lbs_common'

import { AMapLocationReGeocodeLanguage } from '@amap/amap_lbs_location'

import { CommonConstants } from '../../common/constants/CommonConstants'
import geoLocationManager from '@ohos.geoLocationManager';
import systemDateTime from '@ohos.systemDateTime';
import { AMapLocationType } from '@amap/amap_lbs_location';
import bundleManager from '@ohos.bundle.bundleManager';
import { Permissions } from '@ohos.abilityAccessCtrl';
import { BusinessError } from '@ohos.base';
import { Want } from '@kit.AbilityKit';
import { GlobalThis } from '../harmony_location_demoability/GlobalThis';
import { TipsDialog } from '@kit.ArkUI';

const key = "此处替换官网申请的Key";

@Builder
export function LocationPageBuilder() {
  LocationPage()
}

@Component
struct LocationPage {
  pageInfos: NavPathStack = new NavPathStack();
  @State currentSteps: string = CommonConstants.INITIALIZATION_VALUE;
  @Provide stepGoal: string = '';
  @State oldSteps: string = '';
  @State startPosition: string = '';
  @State currentLocation: string = '';
  @State latitude: number = 0;
  @State longitude: number = 0;
  @State progressValue: number = 0;
  @State isStart: boolean = false;
  private context = getContext(this);
  locationManger?: AMapLocationManagerImpl;
  @State response: string = '';
  dialogConLocationEnable: CustomDialogController = new CustomDialogController({
    builder: TipsDialog({
      content: '手机系统定位未开启\n请手动开启！',
      primaryButton: {
        value: '取消',
        action: () => {
        },
      },
      secondaryButton: {
        value: '确定',
        role: ButtonRole.ERROR,
        action: () => {
        }
      }
    }),
  })
  dialogOpenPermissions: CustomDialogController = new CustomDialogController({
    builder: TipsDialog({
      content: '当前应用缺少必要权限。\n请点击“设置”-“权限”-打开所属权限',
      primaryButton: {
        value: '取消',
        action: () => {
        },
      },
      secondaryButton: {
        value: '设置',
        action: () => {
          this.openPermissionsInSystemSettings()
        }
      }
    }),
  })

  aboutToAppear() {
    AMapLocationManagerImpl.setApiKey(key);
    if (this.locationManger === undefined) {
      this.locationManger = new AMapLocationManagerImpl(this.context);
    }
    //this.checkPermissions();
    // this.reqPermissionsFromUser(CommonConstants.REQUEST_PERMISSIONS);

  }

  requestPermissions(): void {
    let atManager = abilityAccessCtrl.createAtManager();
    try {
      atManager.requestPermissionsFromUser(this.context, CommonConstants.REQUEST_PERMISSIONS).then((data) => {
        console.error('requestPermissionsFromUser')

        if (data.authResults[0] !== 0 || data.authResults[1] !== 0) {
          console.error('requestPermissionsFromUser return')
          return;
        }
        const that = this;

      }).catch((err: Error) => {
        console.error('requestPermissionsFromUser err' + JSON.stringify(err))
      })
    } catch (err) {
      console.error('requestPermissionsFromUser err' + JSON.stringify(err));
    }
  }

  async checkAccessToken(permission: Permissions): Promise<abilityAccessCtrl.GrantStatus> {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    let grantStatus: abilityAccessCtrl.GrantStatus = abilityAccessCtrl.GrantStatus.PERMISSION_DENIED;

    // 获取应用程序的accessTokenID
    let tokenId: number = 0;
    try {
      let bundleInfo: bundleManager.BundleInfo =
        await bundleManager.getBundleInfoForSelf(bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION);
      let appInfo: bundleManager.ApplicationInfo = bundleInfo.appInfo;
      tokenId = appInfo.accessTokenId;
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      console.error(`Failed to get bundle info for self. Code is ${err.code}, message is ${err.message}`);
    }

    // 校验应用是否被授予权限
    try {
      grantStatus = await atManager.checkAccessToken(tokenId, permission);
    } catch (error) {
      let err: BusinessError = error as BusinessError;
      console.error(`Failed to check access token. Code is ${err.code}, message is ${err.message}`);
    }

    return grantStatus;
  }

  async checkPermissions(): Promise<boolean> {
    let locationEnabled = geoLocationManager.isLocationEnabled()
    if (!locationEnabled) {
      this.dialogConLocationEnable.open()
      return false
    }
    const permissions: Array<Permissions> = ['ohos.permission.APPROXIMATELY_LOCATION'];
    let grantStatus: abilityAccessCtrl.GrantStatus = await this.checkAccessToken(permissions[0]);

    if (grantStatus === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
      // 已经授权，可以继续访问目标操作
      return true
    } else {
      return await this.reqPermissionsFromUser(CommonConstants.REQUEST_PERMISSIONS);
    }
  }

  async reqPermissionsFromUser(permissions: Array<Permissions>): Promise<boolean> {
    let context: Context = getContext(this) as common.UIAbilityContext;
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    let permissionRequestResult = await atManager.requestPermissionsFromUser(context, permissions)
    let grantStatus: Array<number> = permissionRequestResult.authResults;
    let length: number = grantStatus.length;
    let haspermissions: boolean = false
    for (let i = 0; i < length; i++) {
      if (grantStatus[i] === 0) {
        // 用户授权，可以继续访问目标操作
        haspermissions = true
      }
    }
    if (!haspermissions) {
      // 用户拒绝授权，提示用户必须授权才能访问当前页面的功能，并引导用户到系统设置中打开相应的权限
      this.dialogOpenPermissions.open()
      return false
    } else {
      return true
    }
  }

  openPermissionsInSystemSettings(): void {
    let context: common.UIAbilityContext | undefined = GlobalThis.getInstance().getContext('context');
    let wantInfo: Want = {
      bundleName: "com.huawei.hmos.settings",
      abilityName: "com.huawei.hmos.settings.MainAbility",
      uri: 'application_info_entry',
      parameters: {
        settingsParamBundleName: 'com.example.myapplication' // 打开指定应用的详情页面
      }
    }
    context?.startAbility(wantInfo).then(() => {
      // ...
    }).catch((err: BusinessError) => {
      // ...
    })
  }

  build() {
    NavDestination() {
      Row() {
        Column() {
          // Row() {
          //   Button("获取定位权限")
          //     .onClick(() => {
          //       this.requestPermissions()
          //     }).margin({ left: 20 })
          // }.margin({ top: 20 })


          Row() {
            Button("最后定位")
              .onClick(() => {
                let listener: IAMapLocationListener = {
                  onLocationChanged: (location) => {
                    console.error('onLastLocationChanged  ' + location)
                    systemDateTime.getCurrentTime(false).then((time) => {
                      const date = new Date(time);
                      this.response = " 时间：" + date.toLocaleTimeString() + "\n"
                        + " 经度：" + location.longitude + "\n"
                        + " 纬度：" + location.latitude + "\n"
                        + " 海拔：" + location.altitude + "\n"
                        + " 精度：" + location.accuracy + "\n"
                        + " 速度：" + location.speed + "\n"
                        + " UTC时间：" + location.timeStamp + "\n"
                        + " 方向：" + location.direction + "\n"
                        + " 自启动以来时间：" + location.timeSinceBoot + "\n"
                        + " 附加信息：" + location.additions + "\n"
                        + " 附加信息size：" + location.additionSize + "\n"
                        + " 逆地理：" + location.reGeo?.desc;
                    })

                  }, onLocationError: (error) => {
                    console.error('error  ' + JSON.stringify(error))

                  }
                };

                let options: AMapLocationOption = {
                  allowsBackgroundLocationUpdates: true,
                  locatingWithReGeocode: true,
                  reGeocodeLanguage: AMapLocationReGeocodeLanguage.Chinese,
                  isOffset: false
                }
                this.locationManger?.setLocationOption(AMapLocationType.Last, options)
                this.locationManger?.setLocationListener(AMapLocationType.Last, listener)
                this.locationManger?.requestLastLocation()
              }).margin({ left: 20 })
          }.margin({ top: 20 })

          Row() {
            Button("单次定位")
              .onClick(async () => {
                let haspermissions = await this.checkPermissions();
                if (haspermissions) {
                  let listener: IAMapLocationListener = {
                    onLocationChanged: (location) => {
                      console.error('onCurrentLocationChanged  ' + JSON.stringify(location))
                      systemDateTime.getCurrentTime(false).then((time) => {
                        const date = new Date(time);
                        this.response = " 时间：" + date.toLocaleTimeString() + "\n"
                          + " 经度：" + location.longitude + "\n"
                          + " 纬度：" + location.latitude + "\n"
                          + " 海拔：" + location.altitude + "\n"
                          + " 精度：" + location.accuracy + "\n"
                          + " 速度：" + location.speed + "\n"
                          + " UTC时间：" + location.timeStamp + "\n"
                          + " 方向：" + location.direction + "\n"
                          + " 自启动以来时间：" + location.timeSinceBoot + "\n"
                          + " 附加信息：" + location.additions + "\n"
                          + " 附加信息size：" + location.additionSize + "\n"
                          + " 逆地理：" + location.reGeo?.desc;
                      })

                    }, onLocationError: (error) => {
                      console.error('error  ' + JSON.stringify(error))

                    }
                  };

                  let options: AMapLocationOption = {
                    priority: geoLocationManager.LocationRequestPriority.FIRST_FIX,
                    scenario: geoLocationManager.LocationRequestScenario.UNSET,
                    maxAccuracy: 0,
                    singleLocationTimeout: 3000,
                    allowsBackgroundLocationUpdates: false,
                    locatingWithReGeocode: false,
                    reGeocodeLanguage: AMapLocationReGeocodeLanguage.Chinese,
                    isOffset: true
                  }

                  this.locationManger?.setLocationListener(AMapLocationType.Single, listener)
                  this.locationManger?.setLocationOption(AMapLocationType.Single, options)
                  this.locationManger?.requestSingleLocation()
                }
              }).margin({ left: 20 })
          }.margin({ top: 20 })

          Row() {
            Button("开始连续定位")
              .onClick(async () => {
                let haspermissions = await this.checkPermissions();
                if (haspermissions) {
                  let listener: IAMapLocationListener = {
                    onLocationChanged: (location) => {
                      console.error('caoxing onLocationChanged  ' + JSON.stringify(location))
                      systemDateTime.getCurrentTime(false).then((time) => {
                        // 现在使用毫秒时间戳来创建Date对象
                        const date = new Date(time);
                        this.response = " 时间：" + date.toLocaleTimeString() + "\n"
                          + " 经度：" + location.longitude + "\n"
                          + " 纬度：" + location.latitude + "\n"
                          + " 海拔：" + location.altitude + "\n"
                          + " 精度：" + location.accuracy + "\n"
                          + " 速度：" + location.speed + "\n"
                          + " UTC时间：" + location.timeStamp + "\n"
                          + " 方向：" + location.direction + "\n"
                          + " 自启动以来时间：" + location.timeSinceBoot + "\n"
                          + " 附加信息：" + location.additions + "\n"
                          + " 附加信息size：" + location.additionSize + "\n"
                          + " 逆地理：" + location.reGeo?.desc;
                      })
                    }, onLocationError: (error) => {
                      console.error('error  ' + JSON.stringify(error))
                    }
                  };

                  let options: AMapLocationOption = {
                    priority: geoLocationManager.LocationRequestPriority.FIRST_FIX,
                    scenario: geoLocationManager.LocationRequestScenario.UNSET,
                    timeInterval: 2,
                    distanceInterval: 0,
                    maxAccuracy: 20,
                    allowsBackgroundLocationUpdates: false,
                    singleLocationTimeout: 5000,
                    locatingWithReGeocode: true,
                    reGeocodeLanguage: AMapLocationReGeocodeLanguage.Chinese,
                    isOffset: true
                  }

                  this.locationManger?.setLocationListener(AMapLocationType.Updating, listener)
                  this.locationManger?.setLocationOption(AMapLocationType.Updating, options)
                  this.locationManger?.startUpdatingLocation()
                }
              }).margin({ left: 20 })
          }.margin({ top: 20 })

          Row() {
            Button("停止连续定位")
              .onClick(() => {
                this.locationManger?.stopUpdatingLocation()

              }).margin({ left: 20 })
          }.margin({ top: 20 })

          Row() {
            Button("开启后台定位")
              .onClick(async () => {
                let haspermissions = await this.checkPermissions();
                if (haspermissions) {
                  this.locationManger?.startContinuousTask()
                }
              }).margin({ left: 20 })
          }.margin({ top: 20 })

          Row() {
            Button("停止后台定位")
              .onClick(() => {
                this.locationManger?.stopContinuousTask()
              }).margin({ left: 20 })
          }.margin({ top: 20 })


          Row() {
            TextArea({ text: this.response, placeholder: "返回结果..." })
              .width(350)
              .margin({ top: 20 })
              .borderWidth(1)
              .padding(10)
          }.margin({ top: 20, bottom: 20 })
        }
        .width('100%')
      }
      .height('100%')
    }
    .onReady((context: NavDestinationContext) => {
      this.pageInfos = context.pathStack;
    })
  }
}