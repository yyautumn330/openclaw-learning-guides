// @keepTs
// @ts-nocheck
/**
 * 地图配置
 */
import { LatLng } from '../api/model/LatLng';
import { LatLngBounds } from '../api/model/LatLngBounds';
import { Point } from '../api/model/Point';
export declare class b53 {
    /**Tile 的宽度和高度 2^8 = 256*/
    private static readonly a170;
    /**GeoPoint对应的是20级坐标*/
    private static readonly b170;
    private c170;
    private d170;
    private e170;
    private a96;
    private b96;
    private f170;
    private g170;
    private mapZoomScale;
    private h170;
    private i170;
    private j170;
    private k170;
    private n11;
    /**
     * 地图上所有元素是否绘制， 默认展示
     */
    private l170;
    /**
     * 是否显示交通路况信息
     */
    private m170;
    private n170;
    private o170;
    private p170;
    private q170;
    private r170;
    /**矩阵信息*/
    private viewMatrix;
    private projectionMatrix;
    private t86;
    /**
     * 天空高度，像素
     */
    private s170;
    private t170;
    private u170;
    private v170;
    /** center x y*/
    private w170;
    private x170;
    private y170;
    private z170;
    private a171;
    private b171;
    private c171;
    private d171;
    /**
     * 用于记录地图改变的此时,一旦有改变会+1
     */
    private e171;
    static readonly f171 = 1;
    /**
     * 地图变化比例 中心点的差值 和旋转,仰角以及zoom的乘积
     */
    private g171;
    /**
     * 地图变化比例 grid坐标的差值 和旋转,仰角的乘积
     */
    private h171;
    /**
     * 是否允许单击poi，默认打开
     * 如果单击地铁站，地铁路线会高亮，如果关闭了poi单击，则地铁站不会被单击，地铁路线也不会高亮
     */
    private i171;
    /**
     * 是否允许使用专业版功能
     * 1、自定义纹理，默认为允许
     * 2、在线拉去样式，默认允许
     * 鉴权失败之后会修改为不允许
     */
    private j171;
    /**
     * 是否有使用专业版功能， 默认为false
     * 如果使用了纹理，会被设置为true
     */
    private k171;
    private l171;
    private m171;
    /**离线自定义样式文件 路径*/
    private n171;
    /**在线获取自定义样式文件 对应的ID*/
    private o171;
    private p171;
    constructor(z169: boolean);
    setMapLanguage(language: string): void;
    getMapLanguage(): string;
    m57(): boolean;
    u102(y169: boolean): void;
    v102(): boolean;
    n57(x169: boolean): void;
    r93(w169: boolean): void;
    v57(): boolean;
    r171(v169: string): void;
    a94(): string;
    b94(): string;
    d59(styleId: string): void;
    q171(x: number, y: number): void;
    s171(): number;
    t171(): number;
    getViewMatrix(): Float64Array;
    getProjectionMatrix(): Float64Array;
    o93(): Float64Array;
    h88(): void;
    z96(q169: LatLngBounds): void;
    y89(): LatLngBounds;
    resetMinMaxZoomPreference(): void;
    c90(): boolean;
    a90(p169: Point[]): void;
    z89(): Point[];
    y57(): number;
    p96(o169: number): void;
    q96(n169: number): void;
    z57(): number;
    isTrafficEnabled(): boolean;
    setTrafficEnabled(m169: boolean): void;
    /**
     * bearing 旋转角
     */
    p88(l169: number): void;
    b65(): number;
    /**
     * 俯仰角
     * */
    n88(k169: number): void;
    c65(): number;
    a91(j169: number): void;
    b91(i169: number): void;
    e95(width: number): void;
    f95(height: number): void;
    d95(h169: number): void;
    i88(): Point;
    j88(sx: number): void;
    h90(): number;
    k88(sy: number): void;
    i90(): number;
    /**
     * zoom 缩放级别
     */
    l88(g169: number): void;
    b64(): number;
    y92(): number;
    y90(): number;
    z90(): number;
    w65(): number;
    x65(): number;
    w171(): boolean;
    g94(enable: boolean): void;
    x171(): number;
    y171(f169: number): void;
    l89(): boolean;
    e65(e169: boolean): void;
    isTerrainEnable(): boolean;
    setTerrainEnable(d169: boolean): void;
    /**
     * 目标位置的屏幕中心点经纬度坐标。
     * @since V2.0
     */
    target: LatLng;
    /**保存配置*/
    static readonly e97: number;
    static readonly z97: number;
    static readonly v171: number;
    maxZoomLevel: number;
    minZoomLevel: number;
    /**
     * 设置最大缩放级别
     * @param maxZoomLevel
     */
    setMaxZoomLevel(c169: number): void;
    /**
     * 设置最小缩放界别
     * @param minZoomLevel
     */
    setMinZoomLevel(b169: number): void;
    getMaxZoomLevel(): number;
    getMinZoomLevel(): number;
    /**
     * 本地自定义纹理路径
     */
    private z171;
    s89(a169: string): void;
    p67(): string;
    private a172;
    w96(z168: number): void;
    q67(): number;
    /**
     * 是否是自定义样式
     */
    private b172;
    x57(enable: boolean): void;
    a58(): boolean;
    r88(height: number): void;
    s88(): number;
    n90(): boolean;
    c172(): boolean;
    q90(): boolean;
    r90(): boolean;
    d97(): boolean;
    g95(y168: boolean): void;
    /**
     * 中心点，zoom tilt bearing有一个变化则返回true
     * 在 AMapDelegate onDrawFrame之后调用,调用会很频繁
     * @return
     */
    t88(): boolean;
    private d172;
    g89(): number;
    /**
     * 重置地图改变计数为0,在cameraChangeFinish的时候会调用
     */
    h89(): void;
    u90(): void;
    isTouchPoiEnable(): boolean;
    setTouchPoiEnable(l168: boolean): void;
}
