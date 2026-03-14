// @keepTs
// @ts-nocheck
import { LatLng } from "./LatLng";
/**
 * 创建文字覆盖物选项
 *
 * @author zxy
 * @since V2.5.0
 */
export declare class TextOptions {
    private mid;
    private p45;
    private q45;
    private r45;
    private s45;
    private h20;
    private t45;
    private u45;
    private v45;
    private mZIndex;
    private w45;
    /**
     * @exclude javadoc中不显示
     */
    clone(): TextOptions;
    /**
     * 设置文字覆盖物的地理坐标。
     *
     * @param position 地理位置
     * @return 该文字覆盖物选项对象
     * @since V2.5.0
     */
    position(position: LatLng): TextOptions;
    /**
     * 设置文字覆盖物的文字内容。
     *
     * @param text 文字内容
     * @return 该文字覆盖物选项对象
     * @since V2.5.0
     */
    text(text: string): TextOptions;
    /**
     * 设置文字覆盖物的字体。
     * 注： 'normal', 'bold', 'bolder', 'lighter', 100, 200, 300, 400, 500, 600, 700, 800, 900
     * @param typeface 字体
     * @return 该文字覆盖物选项对象
     * @since V2.5.0
     */
    typeface(typeface: string): this;
    /**
     * 设置文字覆盖物的可见性。
     *
     * @param visible 是否可见 true：为可见，false：不可见
     * @return 该文字覆盖物选项对象
     * @since V2.5.0
     */
    visible(visible: boolean): TextOptions;
    /**
     * 设置文字覆盖物 zIndex。
     *
     * @param zIndex z轴数值
     * @return 该文字覆盖物选项对象
     * @since V2.5.0
     */
    zIndex(zIndex: number): TextOptions;
    /**
     * 设置文字覆盖物的旋转角度,逆时针。
     *
     * @param rotate 角度
     * @return 该文字覆盖物选项对象
     * @since V2.5.0
     */
    rotate(rotate: number): TextOptions;
    /**
     * 设置文字覆盖物的对齐方式,默认居中对齐。
     *
     * @param alignX 水平对齐方式
     * @param alignY 垂直对齐方式
     * @return 该文字覆盖物选项对象
     * @since V2.5.0
     */
    /**
     * 设置文字覆盖物的背景颜色
     * 'rgba(255, 255, 255, 1)'的形式
     * @param backgroundColor 背景颜色
     * @return 该文字覆盖物选项对象
     * @since V2.5.0
     */
    backgroundColor(backgroundColor: string): this;
    /**
     * 设置文字覆盖物的额外信息
     *
     * @param object 额外信息
     * @return 该文字覆盖物选项对象
     * @since V2.5.0
     */
    setObject(object: Object | null): TextOptions;
    /**
     * 设置文字覆盖物的字体颜色,默认黑色。
     * 'rgba(255, 255, 255, 1)'的形式
     * @param fontColor 字体颜色
     * @return 该文字覆盖物选项对象
     * @since V2.5.0
     */
    fontColor(fontColor: string): TextOptions;
    /**
     * 设置文字覆盖物字体大小
     *
     * @param fontSize 字体大小(vp)
     * @return 该文字覆盖物选项对象
     * @since V2.5.0
     */
    fontSize(fontSize: number): TextOptions;
    /**
     * 获取文字覆盖物的地理坐标。
     *
     * @return 地理坐标
     * @since V2.5.0
     */
    getPosition(): LatLng;
    /**
     * 获取文字覆盖物的文字内容
     *
     * @return 文字内容
     * @since V2.5.0
     */
    getText(): string;
    /**
     * 获取文字覆盖物的字体。
     *
     * @return 字体
     * @since V2.5.0
     */
    getTypeface(): string;
    /**
     * 获取文字覆盖物的旋转角度
     *
     * @return 角度
     * @since V2.5.0
     */
    getRotate(): number;
    /**
     * 获取文字覆盖物的水平对齐方式
     *
     * @return 水平对齐方式
     * @since V2.5.0
     */
    /**
     * 获取文字覆盖物的垂直对齐方式
     *
     * @return 垂直对齐方式
     * @since V2.5.0
     */
    /**
     * 获取文字覆盖物的背景颜色
     *
     * @return 背景颜色
     * @since V2.5.0
     */
    getBackgroundColor(): string;
    /**
     * 获取文字覆盖物的字体颜色
     *
     * @return 字体颜色
     * @since V2.5.0
     */
    getFontColor(): string;
    /**
     * 获取文字覆盖物额外信息
     *
     * @return 额外信息对象
     * @since V2.5.0
     */
    getObject(): Object | null;
    /**
     * 获取文字覆盖物的字体大小
     *
     * @return 字体大小
     * @since V2.5.0
     */
    getFontSize(): number;
    /**
     * 获取文字覆盖物的z轴数值
     *
     * @return zIndex
     * @since V2.5.0
     */
    getZIndex(): number;
    /**
     * 获取文字覆盖物的可见性
     *
     * @return true : 可见; false : 不可见
     * @since V2.5.0
     */
    isVisible(): boolean;
}
