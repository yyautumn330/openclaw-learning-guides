import { INaviLatLng } from '@amap/amap_lbs_navi'
import { ArrayList } from '@kit.ArkTS'

export enum NaviDemoLocationType {
	START, END, BOTH
}

export interface TestData {
	name: string
	data: ArrayList<NaviTestLocation>
}

export interface NaviTestLocation {
	start: INaviLatLng
	end: INaviLatLng
}