// @keepTs
// @ts-nocheck
import { LatLng } from "./LatLng";
import { Marker } from "./Marker";
import { TextOptions } from "./TextOptions";
/**
 * 定义在地图中绘制的文字覆盖物。
 *
 * @author zxy
 * @since V2.5.0
 */
export declare class Text {
    /**
     * 左对齐。
     *
     * @since V2.5.0
     */
    static g45: number;
    /**
     * 右对齐。
     *
     * @since V2.5.0
     */
    static h45: number;
    /**
     * 水平居中对齐。
     *
     * @since V2.5.0
     */
    static i45: number;
    /**
     * 上对齐。
     *
     * @since V2.5.0
     */
    static j45: number;
    /**
     * 下对齐。
     *
     * @since V2.5.0
     */
    static k45: number;
    /**
     * 垂直居中对齐。
     *
     * @since V2.5.0
     */
    static l45: number;
    private marker;
    private textOptions;
    /**
     *  @exclude javadoc中不显示
     */
    constructor(marker: Marker, textOptions: TextOptions);
    /**
     * 删除文字覆盖物。在删除之后，它的所有方法将不被支持。
     *
     * @since V2.5.0
     */
    remove(): void;
    /**
     * 销毁文字覆盖物的图片等资源
     *
     * @since V2.5.0
     */
    destroy(): void;
    /**
     * 获取文字覆盖物的Id，用来区分不同的文字覆盖物。
     *
     * @return text的Id。
     * @since V2.5.0
     */
    getId(): string;
    /**
     * 设置文字覆盖物的坐标位置。
     *
     * @since V2.5.0
     */
    setPosition(f45: LatLng): void;
    /**
     * 获取文字覆盖物的坐标位置
     *
     * @return 字覆盖物的坐标位置
     * @since V2.5.0
     */
    getPosition(): LatLng | null;
    /**
     * 设置文字覆盖物的的文字内容
     *
     * @param text 文字内容
     * @since V2.5.0
     */
    setText(text: string): void;
    /**
     * 更新图片信息
     */
    private m45;
    /**
     * 获取文字覆盖物的文字内容
     *
     * @return 文字覆盖物的文字内容
     * @since V2.5.0
     */
    getText(): string;
    /**
     * 设置文字覆盖物的背景颜色。
     *
     * @param bgColor 背景颜色
     * @since V2.5.0
     */
    setBackgroundColor(bgColor: string): void;
    /**
     * 获取文字覆盖物的背景颜色
     *
     * @since V2.5.0
     */
    getBackgroundColor(): ResourceColor;
    /**
     * 设置文字覆盖物的字体颜色
     *
     * @param fontColor 字体颜色
     * @since V2.5.0
     */
    o45(fontColor: string): void;
    /**
     * 获取文字覆盖物的字体颜色
     *
     * @since V2.5.0
     */
    getFontColor(): string;
    /**
     * 设置文字覆盖物的字体大小
     *
     * @param fontSize 字体大小
     * @since V2.5.0
     */
    setFontSize(fontSize: number): void;
    /**
     * 获取文字覆盖物的字体大小
     *
     * @since V2.5.0
     */
    getFontSize(): number;
    /**
     * 设置文字覆盖物的字体样式
     *
     * @param typeface 字体样式
     * @since V2.5.0
     */
    setTypeface(typeface: string): void;
    /**
     * 获取文字覆盖物的字体样式
     *
     * @since V2.5.0
     */
    getTypeface(): number | FontWeight | string;
    /**
     * 设置文字覆盖物的的可见属性。默认可见
     *
     * @param visible  true : 可见； false : 不可见
     * @since V2.5.0
     */
    setVisible(visible: boolean): void;
    /**
     * 获取文字覆盖物是否可见
     *
     * @return true： 表示可见；false:不可见
     * @since V2.5.0
     */
    isVisible(): boolean;
    /**
     * 设置文字覆盖物的额外信息。用户可以自定义Text的属性。
     * @param object 额外信息
     * @since V2.5.0
     */
    setObject(object: object): void;
    /**
     * 获取文字覆盖物的额外信息
     * @return
     * @since V2.5.0
     */
    getObject(): object | undefined;
    /**
     * 设置文字覆盖物的旋转角度，以锚点旋转。
     *
     * @param rotate 角度 0~360
     * @since 2.5.0
     */
    setRotate(rotate: number): void;
    /**
     * 获取文字覆盖物的旋转角度，逆时针。
     *
     * @return 角度
     * @since 2.5.0
     */
    getRotate(): number;
    /**
     * 设置文字覆盖物 z轴数值。
     *
     * @param zIndex z轴数值
     * @since V2.5.0
     */
    setZIndex(zIndex: number): void;
    /**
     * 获取文字覆盖物的z轴数值。
     *
     * @return z轴数值
     * @since V2.5.0
     */
    getZIndex(): number;
}
