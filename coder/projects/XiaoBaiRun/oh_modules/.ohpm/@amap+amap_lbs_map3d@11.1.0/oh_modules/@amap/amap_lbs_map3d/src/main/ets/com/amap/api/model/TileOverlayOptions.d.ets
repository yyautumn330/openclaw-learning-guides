// @keepTs
// @ts-nocheck
import { BaseOptions } from './BaseOptions';
import { TileProvider } from './TileProvider';
import { e16 } from './TileProviderInner';
export declare class TileOverlayOptions extends BaseOptions {
    private readonly mVersionCode?;
    private mTileProvider?;
    private _tileProvider?;
    private mVisible;
    private mZIndex;
    private memCacheSize;
    private diskCacheSize;
    private diskCacheDir;
    private memoryCacheEnabled;
    private diskCacheEnabled;
    /**
     * 构造一个TileOverlayOptions对象。
     *
     * @since 2.2.3
     */
    constructor();
    /**
     * 设置瓦片图层的提供者。
     *
     * @param tileProvider 瓦片图层的提供者。
     * @return 一个设置完瓦片图提供者的TileOverlayOptions对象。
     * @since 2.2.3
     */
    tileProvider(tileProvider: TileProvider): TileOverlayOptions;
    /**
     * 获取C++ 使用的TileProvider
     * @internal
     */
    m16(): e16 | undefined;
    /**
     * 获取瓦片图层的提供者。
     *
     * @return 瓦片图层的提供者。
     * @since 2.2.3
     */
    getTileProvider(): TileProvider | undefined;
    /**
     * 设置瓦片图层的可见属性，默认为可见。
     *
     * @param visible true为可见；false为不可见。
     * @return 一个设置了可见属性的TileOverlayOptions 对象。
     * @since 2.2.3
     */
    visible(visible: boolean): TileOverlayOptions;
    /**
     * 设置用于瓦片图层的内存缓存大小，默认值5MB。
     *
     * @param kiloBytes 缓存大小，单位KB。
     * @return 一个设置了用于瓦片图层内存缓存大小的TileOverlayOptions对象。
     * @since 2.2.3
     * @internal
     */
    setMemCacheSize(f46: number): TileOverlayOptions;
    /**
     * 设置瓦片图层的Z轴值，默认为0。Z轴是控制不同瓦片图层重复区域的绘制顺序的值。Z轴较大的瓦片图层会在绘制在Z轴较小的瓦片图层上面。如果两个瓦片图层的Z轴数值相同，则覆盖情况将随机出现。
     *
     * @param zIndex Z轴数值。
     * @return 一个设置了瓦片图层Z轴值的TileOverlayOptions对象。
     * @since 2.2.3
     */
    zIndex(zIndex: number): TileOverlayOptions;
    /**
     * 设置瓦片图层的默认磁盘缓存大小，默认值20MB。
     *
     * @param kiloBytes 缓存大小，单位KB。
     * @return 一个设置了瓦片图层默认磁盘缓存大小的TileOverlayOptions对象。
     * @since 2.2.3
     * @internal
     */
    setDiskCacheSize(e46: number): TileOverlayOptions;
    /**
     * 设置瓦片图层的磁盘缓存目录。如果外部（SD卡）缓存可用则为外部缓存，否则为内部（手机空间）缓存。默认外部缓存目录为“/sdcard/Android/data/package_name/cache”；默认内部缓存目录为“/data/data/package_name/cache”。
     *
     * @param path 磁盘缓存目录的绝对路径。
     * @return 一个设置了瓦片图层的磁盘缓存目录的TileOverlayOptions对象。
     * @since 2.2.3
     * @internal
     */
    setDiskCacheDir(path: string): TileOverlayOptions;
    /**
     * 设置瓦片图层是否开启内存缓存。
     *
     * @param enabled true为开启内存缓存；false为关闭。
     * @return 一个设置是否开启内存缓存的TileOverlayOptions对象。
     * @since 2.2.3
     * @internal
     */
    setMemoryCacheEnabled(enabled: boolean): TileOverlayOptions;
    /**
     * 设置瓦片图层是否开启磁盘缓存。
     *
     * @param enabled true为开启磁盘缓存；false为关闭。
     * @return 一个设置是否开启磁盘缓存的TileOverlayOptions对象。
     * @since 2.2.3
     * @internal
     */
    setDiskCacheEnabled(enabled: boolean): TileOverlayOptions;
    /**
     * 获取瓦片图层的Z轴数值。
     *
     * @return Z轴数值。
     * @since 2.2.3
     */
    getZIndex(): number;
    /**
     * 获取瓦片图层是否可见
     *
     * @return true为可见；false为不可见。
     * @since 2.2.3
     */
    isVisible(): boolean;
    /**
     * 获取瓦片图层的内存缓存大小。
     *
     * @return 用于瓦片图层的内存缓存大小，单位KB
     * @since 2.2.3
     */
    getMemCacheSize(): number;
    /**
     * 获取瓦片图层的磁盘缓存大小。
     *
     * @return 瓦片图层的磁盘缓存大小，单位KB。
     * @since 2.2.3
     * @internal
     */
    getDiskCacheSize(): number;
    /**
     * 获取瓦片图层的磁盘缓存目录。
     *
     * @return 瓦片图层的磁盘缓存目录。
     * @since 2.2.3
     * @internal
     */
    getDiskCacheDir(): string;
    /**
     * 获取瓦片图层的内存缓存开启状态。
     *
     * @return true为开启内存缓存；false为关闭。
     * @since 2.2.3
     * @internal
     */
    getMemoryCacheEnabled(): boolean;
    /**
     * 获取瓦片图层的磁盘缓存的开启状态。
     *
     * @return true为开启磁盘缓存；false为关闭。
     * @since 2.2.3
     * @internal
     */
    getDiskCacheEnabled(): boolean;
}
