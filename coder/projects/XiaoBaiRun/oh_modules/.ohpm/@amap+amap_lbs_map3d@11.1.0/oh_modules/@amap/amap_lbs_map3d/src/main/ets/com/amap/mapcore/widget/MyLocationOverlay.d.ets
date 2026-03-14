// @keepTs
// @ts-nocheck
import { MyLocationStyle } from '../../api/model/MyLocationStyle';
import { IAMap } from '../interface/IAMap';
import geoLocationManager from '@ohos.geoLocationManager';
export declare class k276 {
    private id;
    private map;
    private point?;
    private circle?;
    private m277;
    private n277;
    private radius;
    private mContext;
    private h213?;
    private mLocationType;
    private o277;
    private static readonly p277;
    private static readonly q277;
    private static readonly TAG;
    /**
     * 是否移动到定位点
     */
    private r277;
    private s277;
    /**
     * 是否需要修改小蓝点的角度
     */
    private t277;
    /**
     * 是否跟随设备旋转 旋转小蓝点
     */
    private u277;
    /**
     * 是否旋转地图 和 跟随设备旋转应该是对立关系
     */
    private v277;
    private options;
    private w277;
    constructor(map: IAMap, context: Context);
    setMyLocationStyle(style: MyLocationStyle): void;
    getMyLocationStyle(): MyLocationStyle;
    x277(type: number): void;
    x277(type: number, l277: boolean): void;
    onPause(): void;
    onResume(): void;
    /**
     * 关闭设备传感器监控
     */
    private c278;
    /**
     * 重置仰角到0度
     */
    private b278;
    /**
     * 重置旋转角度到正北方向
     */
    private a278;
    private z277;
    private changeBearing;
    /**
     * 修改定位点的位置以及旋转方向
     * 修复定位圈的经纬和位置
     * 将地图移动到定位点
     */
    w276(location: geoLocationManager.Location): void;
    /**
     * 定位点根据定位返回角度信息，修改旋转角度
     */
    private d278;
    /**
     * 将地图移动到定位点 即改变中心点
     */
    private f278;
    private y277;
    remove(): void;
    private h278;
    setVisible(visible: boolean): void;
    /**
     * 初始化以及修改定位点和精度圈的属性
     */
    private g278;
    setRotateAngle(rotate: number): void;
    x276(): string;
    y276(): string;
    reset(): void;
    /**
     * 平滑移动动画 修改小蓝点的位置
     */
    private e278;
    /**
     * 销毁图片等资源
     */
    destroy(): void;
}
