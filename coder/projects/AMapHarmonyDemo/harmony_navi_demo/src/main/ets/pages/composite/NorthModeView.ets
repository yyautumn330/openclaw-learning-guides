import { AMapNaviComponent,
	AMapNaviFactory,
	AmapNaviType,
	AMapNaviViewOptions,
	AMapNaviViewTrackingMode,
	IAMapCalcRouteResult,
	IAMapNavi,
	INaviInfo,
	INaviLatLng,
	INaviPoi,
	NaviType} from '@amap/amap_lbs_navi'
import { LogUtil } from '@amap/amap_lbs_common';
import { NaviDemoLocationManager } from '../../utils/NaviDemoLocationManager';
import { ArrayList } from '@kit.ArkTS';

@Component
export struct NorthModeView {
	wayPoints: ArrayList<INaviPoi> = new ArrayList()
	@Prop isTruck: Boolean = false;
	@Consume('pageInfos') pageInfos: NavPathStack;

	naviInstance?: IAMapNavi
	aMapNaviViewOptions: AMapNaviViewOptions = new AMapNaviViewOptions();

	//生命周期方法
	aboutToAppear(): void {
		this.initNavi()
	}

	initNavi() {
		//申请地址：https://console.amap.com/dev/key/app，appId在日志中过滤即可获取
		const appkey = '此处替换官网申请的Key'
		this.naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)
		this.naviInstance.setIsUseInnerVoice(true)

		this.naviInstance.addAMapNaviListener({

			onNaviInfoUpdate: (naviInfo: INaviInfo) => {
				LogUtil.i('Navi_Demo','naviListener', 'onNaviInfoUpdate: ' + naviInfo.mRouteRemainDis + ' onUpdateNaviInfo curRouteName: ' + naviInfo.mCurRoadName)
			},

			onCalculateRouteSuccess: (routeResult: IAMapCalcRouteResult | null) => {
				console.info('demo 算路成功')
			},

			onStartNavi: (type: number) => {
				console.info('onStartNavi: ' + type)
			},

			onNaviMapMode: (naviMode: number) => {
				console.info('onNaviMapMode: ' + naviMode)
			},
		})

		this.aMapNaviViewOptions.setLayoutVisible(false);
		this.aMapNaviViewOptions.setAutoNaviViewNightMode(true)
		this.aMapNaviViewOptions.setAfterRouteAutoGray( true)
	}

	//红绿灯测试
	startLatLng: INaviLatLng = NaviDemoLocationManager.getInstance().getLocation().start
	endLatLng: INaviLatLng = NaviDemoLocationManager.getInstance().getLocation().end


	goback() {
		//其他操作
		console.info('退出导航页面')
		// >>>>>>>> 导航反初始化时序 <<<<<<<<<<<<<<

		// // 停止mock定位信息
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
			RelativeContainer() {
				AMapNaviComponent(
					{
						appCustomerConfig: {
							isNeedCalculateRouteWhenPresent: true,
							mType: AmapNaviType.Driver,
							//默认模拟导航
							mNaviType: NaviType.EMULATOR,
							start: {
								coordinate: this.startLatLng
							},
							end: {
								coordinate: this.endLatLng
							},
							mRouteStrategy: 2,
							serviceAreaDetailsEnable: true,
							goBack: () => {
								this.goback()
							},
							aMapNaviViewOptions: this.aMapNaviViewOptions
						},
					}
				)
				Column({space:16}) {
          Row({space:8}){
						Button(`正北方向`)
							.fontSize(14)
							.border({ width: 1, color: Color.White })
							.backgroundColor('#4D0000FF')
							.onClick(() => {
								this.naviInstance?.setNaviMode(AMapNaviViewTrackingMode.MapNorth)
							})


						Button(`车头方向`)
							.fontSize(14)
							.border({ width: 1, color: Color.White })
							.backgroundColor('#4D0000FF')
							.onClick(() => {
								this.naviInstance?.setNaviMode(AMapNaviViewTrackingMode.CarNorth)
							})
					}

				}
				.alignRules({
					top: { anchor: '__container__', align: VerticalAlign.Top },
					left: { anchor: '__container__', align: HorizontalAlign.Start },
				})
				.width('100%')
				.margin({top: 40})
			}
		}
		.title('导航组件')
		.hideTitleBar(true)
		.onBackPressed(() => {
			this.goback()
			return true
		})
	}
}