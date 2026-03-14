//说明：本示例演示如何使用路径规划组件，如果使用导航组件，可参考NaviComposite.ets文件
import {
	IAmapNaviParams,
	IAMapNavi,
	AMapNaviFactory,
	AmapNaviType,
	AMapNaviViewOptions,
	NaviType,
	AMapCarInfo,
	INaviInfo,
	IAMapCalcRouteResult,
	AMapRoutePlanComponent,
	INaviPoi,
	NaviLatLng,
} from '@amap/amap_lbs_navi';
import { ArrayList } from '@kit.ArkTS';

@Component
export struct RoutePlanComposite {
	@Consume('pageInfos') pageInfos: NavPathStack;
	routePlanParams: IAmapNaviParams | undefined = undefined
	naviInstance?: IAMapNavi
	wayPoints: ArrayList<INaviPoi> = new ArrayList()
	private options: AMapNaviViewOptions = new AMapNaviViewOptions()

	goback() {
		//其他操作
		console.info('------退出路径规划页面')
		// >>>>>>>> 导航反初始化时序 <<<<<<<<<<<<<<
		// 停止mock定位信息
		// this.naviInstance?.stopMockLocation();
		// 销毁导航单例对象
		AMapNaviFactory.destroyAMapNaviInstance()
		this.pageInfos.pop()
	}

	aboutToAppear(): void {
		this.initNavi()
		this.addWayPoi()

		this.routePlanParams = {
			mType: AmapNaviType.Driver,
			mNaviType: NaviType.GPS,
			mRouteStrategy:10,
			start: {
				name: '北京首都国际机场',
				coordinate: new NaviLatLng(40.080213, 116.602545),
			}, //起点
			end: {
				name: '故宫博物院',
				coordinate: new NaviLatLng(39.917839, 116.397029),
			}, //终点
			wayPoints: this.wayPoints,//途经点
			goBack: () => {
				this.goback()
			},
			isNeedCalculateRouteWhenPresent: true,
			aMapNaviViewOptions: this.options
		}
	}

	initNavi() {
		//申请地址：https://console.amap.com/dev/key/app，appId在日志中过滤即可获取
		const appkey = '此处替换官网申请的Key'
		this.naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)
		this.naviInstance.setIsUseInnerVoice(true)

		// 设置车辆信息，默认没有添加到naviInstance中
		let carInfo: AMapCarInfo = new AMapCarInfo();
		carInfo.mCarType = 0;
		carInfo.mCarNumber = "鲁A12222";
		carInfo.mVehicleSize = 1;
		carInfo.mVehicleLoad = 100;
		carInfo.mVehicleWeight = 99;
		carInfo.mVehicleLength = 25;
		carInfo.mVehicleWidth = 2;
		carInfo.mVehicleHeight = 4;
		carInfo.mVehicleAxis = 6;
		carInfo.mVehicleLoadSwitch = true;
		carInfo.isRestriction = true;
		// this.naviInstance.setCarInfo(carInfo);

		// 设置模拟定位Manager
		// this.naviInstance.setMockLocationManager(MockLocationManager.getInstance())

		this.options.setSettingMenuEnabled(true)
		this.options.setShowSettingsPanel(true)
		this.naviInstance.addAMapNaviListener({

			onNaviInfoUpdate: (naviInfo: INaviInfo) => {
				console.info(`naviInfo mCurRoadName: ${naviInfo.mCurRoadName} mNextRoadName: ${naviInfo.mNextRoadName}`)
			},

			onCalculateRouteSuccess: (routeResult: IAMapCalcRouteResult | null) => {
				console.info('算路成功')
				// 开启模拟定位
				// this.naviInstance?.startMockLocation();
			},

			onStartNavi: (type: number) => {
				console.info('onStartNavi: ' + type)
			}
		})
	}

	addWayPoi() {
		let arr = new ArrayList<INaviPoi>()
		let wayPoi1: INaviPoi = {
			name: '望京SOHO',
			coordinate: { latitude: 39.996356, longitude: 116.480639 }
		}
		let wayPoi2: INaviPoi = {
			name: '北京北站',
			coordinate: { latitude: 39.944876, longitude: 116.353063 }
		}
		arr.add(wayPoi1)
		arr.add(wayPoi2)
		this.wayPoints = arr
	}

	build() {
		NavDestination() {
			AMapRoutePlanComponent({ routePlanParams: this.routePlanParams })
		}.hideTitleBar(true).onBackPressed(() => {
			this.goback()
			return true
		})
		.hideTitleBar(true)

	}
}