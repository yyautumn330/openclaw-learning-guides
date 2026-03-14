import {
	AMapCalcRouteResult,
	AMapCarInfo,
	AMapNaviComponent,
	AMapNaviFactory,
	AMapNaviIndependentRouteListener,
	AMapNaviPathGroup,
	AmapNaviType,
	AMapNaviViewOptions,
	IAMapCalcRouteResult,
	IAMapNavi,
	INaviInfo,
	INaviLatLng,
	INaviPoi,
	NaviLatLng,
	NaviPoi,
	NaviType,
	PathPlanningStrategy} from '@amap/amap_lbs_navi'
import { LogUtil } from '@amap/amap_lbs_common';
import { ArrayList } from '@kit.ArkTS';
import { promptAction } from '@kit.ArkUI';
import { MockLocationManager } from '../../mock/manger/MockLocationManager';
import { NaviDemoLocationManager } from '../../utils/NaviDemoLocationManager';

@Component
export struct IndependentRouteCalculateView {
	wayPoints: ArrayList<INaviPoi> = new ArrayList()
	@Prop isTruck: Boolean = false;
	@Consume('pageInfos') pageInfos: NavPathStack;

	naviInstance?: IAMapNavi
	independentPathGroup?: AMapNaviPathGroup;
	aMapNaviViewOptions: AMapNaviViewOptions = new AMapNaviViewOptions();

	//生命周期方法
	aboutToAppear(): void {
		this.initTestData()
		this.initNavi()
	}

	initNavi() {
		//申请地址：https://console.amap.com/dev/key/app，appId在日志中过滤即可获取
		const appkey = '此处替换官网申请的Key'
		this.naviInstance = AMapNaviFactory.getAMapNaviInstance(getContext().getApplicationContext(), appkey)
		this.naviInstance.setIsUseInnerVoice(true)
		// 室内GPS定位反应慢，模拟导航会因为GPS关闭不及时而出现偶发性偏航纠偏失败，使用时模拟导航建议提前关闭GPS
		this.naviInstance.stopGPS()

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

		this.aMapNaviViewOptions.setAutoNaviViewNightMode(true)
		this.aMapNaviViewOptions.setAfterRouteAutoGray( true)
	}

	//红绿灯测试
	startLatLng: INaviLatLng = NaviDemoLocationManager.getInstance().getLocation().start
	endLatLng: INaviLatLng = NaviDemoLocationManager.getInstance().getLocation().end

	initTestData() {
		let arr = new ArrayList<INaviPoi>()

		//途径点
		let location1: INaviLatLng = { latitude: 39.831135, longitude: 116.36056 }

		let test1: INaviPoi = {
			coordinate: location1
		}

		arr.add(test1)
		this.wayPoints = arr
	}

	goback() {
		//其他操作
		console.info('退出导航页面')
		// >>>>>>>> 导航反初始化时序 <<<<<<<<<<<<<<

		if (this.naviInstance) {
			// 停止mock定位信息
			this.naviInstance.stopMockLocation();

			// 移除外部监听
			this.naviInstance.removeAMapNaviListener({})

			// 停止导航
			this.naviInstance.stopNavi()

			// 销毁导航单例对象
			AMapNaviFactory.destroyAMapNaviInstance()

			this.naviInstance = undefined;
		}
		this.pageInfos.pop()
	}

	fromLatLng: NaviLatLng = new NaviLatLng(40.100204,116.376890);
	toLatLng: NaviLatLng = new NaviLatLng(39.941597,116.352869);

	independentRouteCalculate(){
		let fromPoi = new NaviPoi("温都水城", this.fromLatLng, "B0FFFDZUKN",);
		// 设置起点角度
		// fromPoi.setDirection(180);
		let toPoi = new NaviPoi("西直门凯德MALL", this.toLatLng, "B000A8VSXA");
		let poiList = new ArrayList<NaviPoi>();
		poiList.add(new NaviPoi("温榆河公园", new NaviLatLng(40.071562,116.465318), "B0HAF6QKNJ"));

		const observe: AMapNaviIndependentRouteListener = {
			onIndependentCalculateSuccess: (aMapNaviPathGroup: AMapNaviPathGroup) => {
				this.independentPathGroup = aMapNaviPathGroup;
				promptAction.showToast({ message: '独立算路成功'})
			},
			onIndependentCalculateFail: (routeResult: AMapCalcRouteResult) => {
				console.info('独立算路失败', JSON.stringify(routeResult))
			}
		}

		this.naviInstance?.independentCalculateRoute(fromPoi, toPoi, poiList, PathPlanningStrategy.DRIVING_MULTIPLE_ROUTES_DEFAULT, AmapNaviType.Driver, observe)
	}

	selectIndependentRoute(): void {
		if (this.independentPathGroup != null) {
			const lastIndex = this.independentPathGroup.getPathCount() - 1
			this.independentPathGroup.selectRouteWithIndex(lastIndex)

			this.naviInstance?.stopNavi()
			setTimeout(() => {
				this.startLatLng = this.fromLatLng;
				this.endLatLng = this.toLatLng;
				this.naviInstance?.startNaviWithPath(NaviType.EMULATOR, this.independentPathGroup!);
				promptAction.showToast({ message: '独立算路选路导航开始'})
			}, 100)
		}
	}

	build() {
		NavDestination() {
			Stack({alignContent:Alignment.Top}){
				AMapNaviComponent(
					{
						appCustomerConfig:{
							isNeedCalculateRouteWhenPresent: true,
							mType: AmapNaviType.Driver,
							mNaviType: NaviType.EMULATOR,
							start: {
								coordinate: this.startLatLng
							},
							end: {
								coordinate: this.endLatLng
							},
							mRouteStrategy: -1,
							// wayPoints: this.wayPoints,
							serviceAreaDetailsEnable: true,
							goBack: () => {
								this.goback()
							},
							aMapNaviViewOptions: this.aMapNaviViewOptions
						}
					}
				)
				Row({space:12}){
					Button('独立算路')
						.fontSize(14)
						.border({width:1,color:Color.White})
						.backgroundColor('#4D0000FF')
						.onClick(()=>{
							this.independentRouteCalculate()
						})
					Button('独立算路导航')
						.fontSize(14)
						.border({width:1,color:Color.White})
						.backgroundColor('#4D0000FF')
						.onClick(()=>{
							this.selectIndependentRoute()
						})
				}
				.margin({top:40,left:12})
			}
		}.title('导航组件')
		.hideTitleBar(true)
		.onBackPressed(() => {
			this.goback()
			return true
		})
	}
}