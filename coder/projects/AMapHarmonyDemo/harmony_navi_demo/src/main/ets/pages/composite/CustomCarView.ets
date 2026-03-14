import { AMapNaviComponent,
	AMapNaviFactory,
	AmapNaviType,
	AMapNaviViewOptions,
	IAMapCalcRouteResult,
	IAMapNavi,
	INaviInfo,
	INaviLatLng,
	INaviPoi,
	NaviLatLng,
	NaviType} from '@amap/amap_lbs_navi'
import { LogUtil } from '@amap/amap_lbs_common';
import { ArrayList } from '@kit.ArkTS';
import { image } from '@kit.ImageKit';
import { resourceManager } from '@kit.LocalizationKit';
import { MockLocationManager } from '../../mock/manger/MockLocationManager';

@Component
export struct CustomCarView {
	wayPoints: ArrayList<INaviPoi> = new ArrayList()
	@Prop isTruck: Boolean = false;
	@Consume('pageInfos') pageInfos: NavPathStack;

	context = getContext().getApplicationContext()

	naviInstance?: IAMapNavi
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

		const carMarker = this.changeFileToPixelMap('customcar.png')
		const compassMarker = this.changeFileToPixelMap('navi_direction.png')
		const startMarker = this.changeFileToPixelMap('navi_start.png')
		const endMarker = this.changeFileToPixelMap('navi_end.png')

		this.aMapNaviViewOptions.setCarPixelMap(carMarker)
		this.aMapNaviViewOptions.setFourCornersPixelMap(compassMarker)
		this.aMapNaviViewOptions.setStartPointPixelMap(startMarker)
		this.aMapNaviViewOptions.setEndPointPixelMap(endMarker)
	}

	changeFileToPixelMap(fileName: string): PixelMap | null{
		let res = this.getFileBuffer(this.context,fileName)
		if(res){
			let imageSource: image.ImageSource = image.createImageSource(res,{
				sourceDensity: 120,
				sourcePixelFormat: image.PixelMapFormat.RGBA_8888
			});
			let pixelMap: PixelMap = imageSource.createPixelMapSync({
					desiredSize:{
						height:imageSource.getImageInfoSync().size.height * 2.1,
						width:imageSource.getImageInfoSync().size.width * 2.1
					}
				})
			imageSource.release();
			return pixelMap
		}else{
			return null
		}
	}


	// 核心转换函数
	getFileBuffer(context: Context, fileName: string): ArrayBuffer | undefined {
		try {
			const resourceMgr: resourceManager.ResourceManager = context.resourceManager;
			// 获取资源文件内容，返回Uint8Array。
			const fileData: Uint8Array = resourceMgr.getRawFileContentSync(fileName);
			console.info('Successfully got RawFileContent');
			// 转为ArrayBuffer并返回。
			const buffer: ArrayBuffer = fileData.buffer.slice(0);
			return buffer;
		} catch (error) {
			console.error("Failed to get RawFileContent");
			return undefined;
		}
}

	//红绿灯测试
	startLatLng: INaviLatLng = new NaviLatLng(39.825934,116.342972);
	endLatLng: INaviLatLng = new NaviLatLng(40.084894,116.603039);

	initTestData() {
		let arr = new ArrayList<INaviPoi>()

		//途径点
		let location1: INaviLatLng = { latitude: 39.925846, longitude: 116.442765 }

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
						wayPoints: this.wayPoints,
						serviceAreaDetailsEnable: true,
						goBack: () => {
							this.goback()
						},
						aMapNaviViewOptions: this.aMapNaviViewOptions,
					}
				}
			)
		}.title('导航组件')
		.hideTitleBar(true)
		.onBackPressed(() => {
			this.goback()
			return true
		})
	}
}