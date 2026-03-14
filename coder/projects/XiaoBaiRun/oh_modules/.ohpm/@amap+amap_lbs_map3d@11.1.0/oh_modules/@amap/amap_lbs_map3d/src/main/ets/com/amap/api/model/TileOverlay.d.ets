// @keepTs
// @ts-nocheck
import { d16 } from "../../mapcore/interface/IGLOverlayLayer";
import { BaseOverlay } from "./BaseOverlay";
import { TileOverlayOptions } from "./TileOverlayOptions";
/**
 * 定位地图瓦片图TileOverlay
 * TileOverlay是瓦片图层的相关类。瓦片图层是显示在基本地图上的一组图像。这些瓦片可以是透明的，允许您增加一些新的功能到现有的地图上。瓦片图层具有以下属性：
 * <p>瓦片提供者：</p>
 * <p>提供者提供在瓦片图层上使用的图像。您必须在瓦片添加到地图上之前指定提供者。一旦瓦片添加到地图之后，提供者将不能更改。如果瓦片提供者发生变化，您必须使用 {@link #clearTileCache()} 方法确保以前的瓦片图不再出现。</p>
 * <p>Z轴值：</p>
 * <p>Z轴是控制瓦片图层重复区域的绘制顺序的值。Z轴较大的瓦片图层会在绘制在Z轴较小的瓦片图层上面。如果两个瓦片图层的Z轴数值相同，则覆盖情况将随机出现。</p>
 * <p>可见性：</p>
 * <p>瓦片图层是否可见，只是表示是否画在地图上。设置不可见的瓦片图层，将不被画在地图上，但会保留它的其他属性。默认瓦片图层是可见的。</p>
 * <p>调用这个类的方法必须在主线程使用，操作失败将会抛出IllegalStateException异常。</p>
 *
 * @author zxy
 * @since 2.2.3
 */
export declare class TileOverlay extends BaseOverlay {
    protected options?: TileOverlayOptions;
    protected glOverlayLayerRef?: d16;
    constructor(a46: d16, b46: TileOverlayOptions, c46: string);
    /**
     * 设置瓦片图层可见属性
     *
     * @param visible true: 可见；false: 不可见
     * @since 2.2.3
     */
    setVisible(visible: boolean): void;
    /**
     * 获取瓦片图层是否可见。
     *
     * @return true: 可见；false: 不可见
     * @since 2.2.3
     */
    isVisible(): boolean;
    protected updateOption(): void;
    /**
     * 从地图上删除瓦片图层
     *
     * @since 2.2.3
     */
    remove(): void;
    /**
     * 获取瓦片图层的Id
     *
     * @return 瓦片图层的Id
     * @since 2.2.3
     */
    getId(): string;
    /**
     * 设置瓦片图层的Z轴值
     *
     * @param zIndex Z轴值
     * @since 2.2.3
     */
    setZIndex(zIndex: number): void;
    /**
     * 获取瓦片图层的Z轴值
     *
     * @return 瓦片图层的Z轴值
     * @since 2.2.3
     */
    getZIndex(): number;
}
