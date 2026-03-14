// @keepTs
// @ts-nocheck
import ArrayList from '@ohos.util.ArrayList';
import { BaseOptions, BaseUpdateFlags, LineCapType, LineJoinType } from './BaseOptions';
import { LatLng } from './LatLng';
import { BitmapDescriptor } from './BitmapDescriptor';
/**
 * 线段的选项类
 *
 * @since 1.0.0
 */
export declare class PolylineOptions extends BaseOptions {
    static readonly TAG: string;
    protected id: string;
    private pointsArray;
    private customTextureList;
    private points;
    private width;
    private color;
    private zIndex;
    private visible;
    private customTexture?;
    private customTextures;
    private useEngine;
    private colorValues;
    private customIndexes;
    private useTexture;
    private geodesic;
    private dottedLine;
    private gradient;
    private transparency;
    private aboveMaskLayer;
    private dottedLineType;
    private lineCapType;
    private lineJoinType;
    private showRatio;
    private showRangeBegin;
    private showRangeEnd;
    private footPrintTexture?;
    private footPrintGap;
    private eraseVisible;
    private eraseColor;
    private eraseTexture?;
    private showPolylineRangeBegin;
    private showPolylineRangeEnd;
    private showPolylineRangeEnable;
    private updateFlags;
    /**
     * 构造一个新的PolylineOptions对象。
     *
     * @since 1.0.0
     */
    constructor();
    /**
     * 设置是否使用纹理贴图画线。
     *
     * @param useTexture true，使用纹理贴图；false，不使用。默认为使用纹理贴图画线。
     * @return 返回PolylineOptions对象。
     * @since V2.0.0
     */
    setUseTexture(c45: boolean): PolylineOptions;
    /**
     * 获取线段是否使用纹理贴图。
     *
     * @return true：使用纹理贴图；false：未使用。
     * @since V2.2.0
     */
    getUseTexture(): boolean;
    /**
     * 设置线段的纹理图，图片为2的n次方。如果不是，会自动放大至2的n次方。图片最好不大于128*128。
     *
     * @param customTexture 用户设置线段的纹理。
     * @return PolylineOptions 对象。
     * @since V2.2.0
     */
    setCustomTexture(customTexture: BitmapDescriptor): PolylineOptions;
    /**
     * 获取线段的纹理图。
     *
     * @return 线段的纹理图。
     * @since V2.2.0
     */
    getCustomTexture(): BitmapDescriptor | undefined;
    /**
     * 设置线段纹理list
     *
     * @param customTextureList 纹理列表
     * @return PolylineOptions 对象。
     * @since 2.0.0
     */
    setCustomTextureList(b45: ArrayList<BitmapDescriptor>): PolylineOptions;
    /**
     * 获取线段纹理列表
     *
     * @return 纹理列表。
     * @since 2.0.0
     */
    getCustomTextureList(): ArrayList<BitmapDescriptor>;
    /**
     * 设置线段纹理index数组
     *
     * @param custemTextureIndexs 每一段对应的纹理，用纹理列表的index来对应
     * @return PolylineOptions 对象。
     * @since 2.0.0
     */
    setCustomTextureIndex(a45: Int32Array): PolylineOptions;
    /**
     * 获取线段纹理index列表
     *
     * @return 分段纹理index列表
     * @since 2.0.0
     */
    getCustomTextureIndex(): Int32Array;
    /**
     * 设置线段的颜色
     *
     * @param colors 颜色列表∂
     * @param colors 颜色列表∂
     * @return PolylineOptions 对象。
     * @since 1.0.0
     */
    setColorValues(colors: Int32Array): PolylineOptions;
    /**
     * 获取线段的颜色列表
     *
     * @return 颜色列表。
     * @since 1.0.0
     */
    getColorValues(): Int32Array;
    /**
     * 设置线段是否使用渐变色
     *
     * @param useGradient 是否使用渐变色，true：使用，false不使用，默认为false；
     * @return PolylineOptions 对象。
     * @since 2.0.0
     */
    setGradient(z44: boolean): PolylineOptions;
    /**
     * 获取线段是否使用渐变色
     *
     * @return 是否使用渐变色，true：使用，false不使用
     * @since 2.0.0
     */
    getUseGradient(): boolean;
    setUseEngine(y44: boolean): void;
    getUseEngine(): boolean;
    /**
     * 追加一个顶点到线段的坐标集合。
     *
     * @param ponumber 要添加的顶点。
     * @return 追加一个顶点到线段终点的PolylineOptions对象
     * @since 1.0.0
     */
    add(...points: LatLng[]): PolylineOptions;
    /**
     * 追加一批顶点到线段的坐标集合。
     *
     * @param points 要添加的顶点集合。
     * @return 追加一批顶点到线段终点的PolylineOptions对象
     * @since 1.0.0
     */
    addAll(points: ArrayList<LatLng>): PolylineOptions;
    /**
     * 设置线段的宽度，默认为10。
     *
     * @param width 宽度 单位：像素。
     * @return 设置线段新宽度的PolylineOptions对象。
     * @since 1.0.0
     */
    setWidth(width: number): PolylineOptions;
    /**
     * 设置线段的颜色，需要传入32位的ARGB格式。默认为黑色( 0xff000000)。
     *
     * @param color 颜色。
     * @return 设置线段颜色的PolylineOptions对象
     * @since 1.0.0
     */
    setColor(color: number): PolylineOptions;
    /**
     * 设置线段Z轴的值。
     *
     * @param zIndex 要设置的Z轴的值。
     * @return 设置线段新Z轴值的PolylineOptions对象。
     * @since 1.0.0
     */
    setZIndex(zIndex: number): PolylineOptions;
    /**
     * 设置线段的可见性。默认为可見
     *
     * @param visible 一个表示线段是否可见的布尔值，true表示可见，false表示不可见。
     * @return 设置新可见属性的PolylineOptions对象
     * @since 1.0.0
     */
    setVisible(visible: boolean): PolylineOptions;
    /**
     * 设置线段是否为大地曲线，默认false，不画大地曲线。
     *
     * @param isGeodesic 一个表示线段是否为大地曲线的布尔值，true表示是大地曲线，false表示不是大地曲线。
     * @return 设置线段是否为大地曲线的PolylineOptions对象。
     * @since 1.0.0
     */
    setGeodesic(isGeodesic: boolean): PolylineOptions;
    getGeodesic(): boolean;
    /**
     * 设置是否画虚线，默认为false，画实线。
     *
     * @param isDottedLine true，画虚线；false，画实线。
     * @return 设置线段是否为虚线的PolylineOptions对象。
     * @since 1.0.0
     */
    setDottedLine(w44: boolean): PolylineOptions;
    /**
     * 获取线段是否画虚线，默认为false，画实线。
     *
     * @return true，画虚线；false，画实线。
     * @since 1.0.0
     */
    getDottedLine(): boolean;
    /**
     * 设置虚线形状。
     *
     * @param type 形状：<br>
     *             {@link #DOTTEDLINE_TYPE_SQUARE}:方形；<br>
     *             {@link #DOTTEDLINE_TYPE_CIRCLE}：圆形；<br>
     * @return 设置虚线形状的PolylineOptions对象。
     * @since V5.5.0
     */
    setDottedLineType(type: number): PolylineOptions;
    getDottedLineType(): number;
    /**
     * 设置Polyline尾部形状
     *
     * @param lineCapType 形状
     * @return
     * @since 1.0.0
     */
    setLineCapType(v44: LineCapType): PolylineOptions;
    /**
     * 设置Polyline连接处形状
     *
     * @param lineJoinType 形状
     * @return
     * @since 1.0.0
     */
    setLineJoinType(u44: LineJoinType): PolylineOptions;
    /**
     * 返回Polyline尾部形状
     *
     * @return 形状
     * @since 1.0.0
     */
    getLineCapType(): LineCapType;
    /**
     * 返回Polyline连接处形状
     *
     * @return 形状
     * @since 1.0.0
     */
    getLineJoinType(): LineJoinType;
    /**
     * 获取线段的点坐标列表。
     *
     * @return 线段的顶点坐标列表。
     * @since 1.0.0
     */
    getPoints(): ArrayList<LatLng>;
    /**
     * 获取线段的宽度。
     *
     * @return 宽度
     * @since 1.0.0
     */
    getWidth(): number;
    /**
     * 获取线段的颜色ARGB格式。
     *
     * @return 线段的颜色ARGB格式。
     * @since 1.0.0
     */
    getColor(): number;
    /**
     * 获取线段的Z轴值
     *
     * @return Z轴值
     * @since 1.0.0
     */
    getZIndex(): number;
    /**
     * 获取线段的可见属性
     *
     * @return true：为可见; false：不可见。
     * @since 1.0.0
     */
    getVisible(): boolean;
    /**
     * @exclude javadoc中不显示
     */
    describeContents(): number;
    /**
     * 设置线段的透明度0~1，默认是1,1表示不透明
     *
     * @param transparency 透明度
     * @return 设置线段带透明度的PolylineOptions对象。
     * @since 1.0.0
     */
    setTransparency(transparency: number): PolylineOptions;
    /**
     * 获取线的透明度
     *
     * @return 透明度0~1 默认是1不透明
     * @since 1.0.0
     */
    getTransparency(): number;
    /**
     * 设置线段在蒙层上面绘制 蒙层详见 {@link com.amap.api.maps.AMap#setMaskLayerParams(int, int, int, int, int, long)}
     *
     * @param isAboveMaskLayer true 表示在蒙层上面 默认为false
     * @return 设置线段蒙层属性的PolylineOptions对象。
     * @exclude javadoc中不显示 滴滴使用
     * @since V4.0.0
     */
    setAboveMaskLayer(t44: boolean): PolylineOptions;
    /**
     * 获取线段是否在蒙层上面 蒙层详见 {@link com.amap.api.maps.AMap#setMaskLayerParams(int, int, int, int, int, long)}
     *
     * @return true:表示在蒙层上面,false:表示在蒙层下面
     * @exclude javadoc中不显示 滴滴使用
     * @since V4.0.0
     */
    getAboveMaskLayer(): boolean;
    /**
     * 设置线段的点坐标集合,如果以前已经存在点,则会清空以前的点。
     *
     * @param points 要设置的顶点集合
     * @since 1.0.0
     */
    setPoints(points: ArrayList<LatLng>): void;
    /**
     * @exclude javadoc中不显示
     */
    clone(): PolylineOptions;
    /**
     *
     * 设置线段显示比例
     * 如果线段中有(A,B),设置比例为0.5，则之后显示(A,A')显示一半,其中A' = A + 0.5*(B-A)
     * 如果线段中有多个点如，(A,B,C,D),则需要关注点的个数减一 ratio = 1 显示(A,B),ratio = 2 显示(A,B,C),ratio = 3 显示(A,B,C,D)
     *
     * @param ratio 小于0无效，范围0到点的个数总数减1,默认值-1
     * @since 6.5.0
     * @exclude javadoc中不显示 ，暂时隐藏，后续native层实现后再开放
     * @deprecated 请使用setShownRange方法
     */
    setShowRatio(ratio: number): PolylineOptions;
    /**
     * 线段显示比例
     * @return 小于0无效，范围0到点的个数总数减1,默认值-1
     * @since 6.5.0
     * @exclude javadoc中不显示 ，暂时隐藏，后续native层实现后再开放
     */
    getShowRatio(): number;
    /**
     * 设置线段显示范围
     * 如果线段中有(A,B),设置范围为[0.1, 0.8]，则之后显示(A',B'),其中A' = A + 0.1*(B-A), B'= A + 0.9*(B-A)
     * 如果线段中有多个点如，(A,B,C,D),设置范围为[1.5, 2.5], 则之后显示（B',C,C'）,其中B'= B + (1.5-1)*(C-B),
     * C'=C + (2.5-2)(D-C)
     * @param rangeBegin 小于0无效，范围0到rangEnd
     * @param rangeEnd 小于0无效，范围rangeBegin到点的个数总数减1
     * @since 6.7.0
     * @exclude javadoc中不显示 ，暂时隐藏，后续native层实现后再开放
     */
    setShownRange(r44: number, s44: number): PolylineOptions;
    /**
     * 线段显示范围开始点
     * @return 小于0无效，范围0到点的个数总数减1,默认值-1
     * @since 6.6.0
     * @exclude javadoc中不显示 ，,导航SDK使用
     */
    getShowRangeBegin(): number;
    /**
     * 线段显示范围结束点
     * @return 小于0无效，范围0到点的个数总数减1,默认值-1
     * @since 6.6.0
     * @exclude javadoc中不显示 ,导航SDK使用
     */
    getShowRangeEnd(): number;
    /**
     * 是否启用显示范围，true启用，默认false。不启用时展示全路径，polyline2.0接口
     * @param showRangeEnable 是否开启showRange功能
     * @exclude javadoc中不显示
     * @since 7.5.0
     */
    setShowPolylineRangeEnabled(q44: boolean): PolylineOptions;
    /**
     * 获取PolylineRangeEnable值，polyline2.0接口
     * @exclude javadoc中不显示
     * @since 7.5.0
     */
    getShowPolylineRangeEnable(): boolean;
    /**
     * 设置线段显示范围,polyline2.0接口
     * 如果线段中有(A,B),设置范围为[0.1, 0.8]，则之后显示(A',B'),其中A' = A + 0.1*(B-A), B'= A + 0.9*(B-A)
     * 如果线段中有多个点如，(A,B,C,D),设置范围为[1.5, 2.5], 则之后显示（B',C,C'）,其中B'= B + (1.5-1)*(C-B),
     * C'=C + (2.5-2)(D-C)
     * @param rangeBegin 范围0到rangEnd
     * @param rangeEnd 范围rangeBegin到点的个数总数减1
     * @since 7.5.0
     * @exclude javadoc中不显示 ，暂时隐藏，后续native层实现后再开放
     */
    setPolylineShowRange(o44: number, p44: number): PolylineOptions;
    /**
     * 线段显示范围开始点,polyline2.0接口
     * @return 用户设置显示范围线段起始点
     * @since 7.5.0
     * @exclude javadoc中不显示 ,导航SDK使用
     */
    getPolylineShowRangeBegin(): number;
    /**
     * 线段显示范围结束点,polyline2.0接口
     * @return 用户设置显示范围线段终止点
     * @since 7.5.0
     * @exclude javadoc中不显示 ,导航SDK使用
     */
    getPolylineShowRangeEnd(): number;
    /**
     * 设置线段的脚印纹理图，图片为2的n次方。如果不是，会自动放大至2的n次方。图片最好不大于128*128。
     *
     * @param footPrintTexture 用户设置线段的脚印纹理。
     * @return PolylineOptions 对象。
     * @since V7.5.0
     * @exclude javadoc中不显示
     */
    setFootPrintTexture(n44: BitmapDescriptor): PolylineOptions;
    /**
     * 获取线段的脚印纹理图。
     *
     * @return 线段的脚印纹理图。
     * @since V7.4.0
     * @exclude javadoc中不显示
     */
    getFootPrintTexture(): BitmapDescriptor | undefined;
    /**
     * 设置线段的脚印纹理间隔。
     *
     * @param footPrintGap 用户设置线段的脚印纹理间隔,单位：像素
     * @return PolylineOptions 对象。
     * @since V7.5.0
     * @exclude javadoc中不显示
     */
    setFootPrintGap(m44: number): PolylineOptions;
    /**
     * 获取线段的脚印纹理间隔。
     *
     * @return 返回线段的脚印纹理间隔，单位像素
     * @since V7.5.0
     * @exclude javadoc中不显示
     */
    getFootPrintGap(): number;
    /**
     * 设置擦除线段（显示范围外）的纹理,针对纹理线段生效。此函数需要{@link com.amap.api.maps.model.PolylineOptions#setShownRange(float rangeBegin, float rangeEnd)}使用后生效
     *
     * @param eraseVisible 擦除线段（线段显示范围外）可见性，默认不可见。
     * @param eraseTexture 擦除线段（线段显示范围外）纹理
     * @return PolylineOptions 对象。
     * @since V7.5.0
     * @exclude javadoc中不显示
     */
    setEraseTexture(k44: boolean, l44: BitmapDescriptor): PolylineOptions;
    /**
     * 获取擦除线段（显示范围外）的纹理。
     *
     * @return 线段显示范围外纹理图。
     * @since V7.5.0
     * @exclude javadoc中不显示
     */
    getEraseTexture(): BitmapDescriptor | undefined;
    /**
     * 获取擦除线段（显示范围外）的可见性。
     *
     * @return 擦除线段（线段显示范围外）可见性。
     * @since V7.5.0
     * @exclude javadoc中不显示
     */
    getEraseVisible(): boolean;
    /**
     * 设置线段擦除（显示范围外）颜色，需要传入32位的ARGB格式，针对颜色线段生效。默认为黑色( 0xff000000)，此函数需要{@link com.amap.api.maps.model.PolylineOptions#setShownRange(float rangeBegin, float rangeEnd)}使用后生效
     *
     * @param eraseVisible 擦除线段（线段显示范围外）可见性，默认不可见。
     * @param eraseColor 擦除线段（线段显示范围外）颜色
     * @return 设置线段范围外颜色的PolylineOptions对象
     * @since V7.5.0
     */
    setEraseColor(i44: boolean, j44: number): PolylineOptions;
    /**
     * 获取擦除线段（显示范围外）的颜色。
     *
     * @return 线段显示范围外颜色。
     * @since V7.5.0
     * @exclude javadoc中不显示
     */
    getEraseColor(): number;
    protected dashArrayCircle: ArrayList<number>;
    protected dashArrayDefault: ArrayList<number>;
    private getLineCap;
    private getLineJoin;
    private lineGradient;
    private getLineGradient;
    /**
     * 获取屏幕坐标
     * @exclude javadoc中不显示
     */
    toJson(): string;
    /**
     * 用于Native判断当前有哪些数据有更新
     * @exclude javadoc中不显示。
     */
    resetUpdateFlags(): void;
    /**
     * 用于Native判断当前有哪些数据有更新
     * @exclude javadoc中不显示。
     */
    getUpdateFlags(): PolylineUpdateFlags;
}
declare class PolylineUpdateFlags {
    isPointsUpdated: boolean;
    isCustomIndexesUpdated: boolean;
    isCustomTextureListUpdated: boolean;
    isColorValuesUpdated: boolean;
    footPrintBDUpdate: boolean;
    eraseUpdate: boolean;
    baseUpdateFlags: BaseUpdateFlags;
    reset(): void;
}
export {};
