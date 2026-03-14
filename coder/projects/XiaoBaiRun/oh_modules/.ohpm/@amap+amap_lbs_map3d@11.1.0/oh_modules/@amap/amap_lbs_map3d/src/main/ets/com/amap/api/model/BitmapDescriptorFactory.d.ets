// @keepTs
// @ts-nocheck
import { Context } from '@ohos.abilityAccessCtrl';
import { BitmapDescriptor } from './BitmapDescriptor';
export declare class BitmapDescriptorFactory {
    private static readonly TAG;
    private static readonly ICON_ID_PREFIX;
    private static nextId;
    /**
     * 红色。
     * @since 1.0.0
     */
    static readonly HUE_RED: number;
    /**
     * 橙色。
     * @since 1.0.0
     */
    static readonly HUE_ORANGE: number;
    /**
     * 黄色。
     * @since 1.0.0
     */
    static readonly HUE_YELLOW: number;
    /**
     * 绿色。
     * @since 1.0.0
     */
    static readonly HUE_GREEN: number;
    /**
     * 青色。
     * @since 1.0.0
     */
    static readonly HUE_CYAN: number;
    /**
     * 天蓝色。
     * @since 1.0.0
     */
    static readonly HUE_AZURE: number;
    /**
     * 蓝色。
     * @since 1.0.0
     */
    static readonly HUE_BLUE: number;
    /**
     * 紫色。
     * @since 1.0.0
     */
    static readonly HUE_VIOLET: number;
    /**
     * 酒红色。
     * @since 1.0.0
     */
    static readonly HUE_MAGENTA: number;
    /**
     * 玫瑰红。
     * @since 1.0.0
     */
    static readonly HUE_ROSE: number;
    /**
     * 根据图片的内容，创建bitmap描述信息对象。
     *
     * @param resourceId 图片的资源Id。
     * @return 根据图片的资源Id，创建bitmap描述信息对象，如文件不存在，则返回null。
     * @since 1.0.0
     */
    static fromRawFileContent(i23: ArrayBuffer): Promise<BitmapDescriptor | undefined>;
    /**
     * 根据图片的内容，创建bitmap描述信息对象。
     *
     * @param resourceId 图片的资源Id。
     * @return 根据图片的资源Id，创建bitmap描述信息对象，如文件不存在，则返回null。
     * @since 1.0.0
     */
    static k23(h23: ArrayBuffer): BitmapDescriptor | undefined;
    /**
     * 根据一个 View 创建 Bitmap 描述信息对象
     *
     * @param view 要显示的view。
     * @return 根据一个 View 创建 Bitmap 描述信息对象，当view为null时则返回null。
     * @since 1.0.0.3
     */
    static fromView(f23: CustomBuilder): Promise<BitmapDescriptor | undefined>;
    /**
     * 根据图片文件的绝对地址，创建 bitmap 描述信息对象。
     *
     * @param path 图片的绝对地址
     * @return 根据图片文件的绝对地址，创建 bitmap 描述信息对象，如文件不存在，则返回null。
     * @since 1.0.0
     */
    static fromRawfilePath(context: Context, d23: string): Promise<BitmapDescriptor | undefined>;
    /**
     * 根据图片文件的绝对地址，创建 bitmap 描述信息对象。
     *
     * @param path 图片的绝对地址
     * @return 根据图片文件的绝对地址，创建 bitmap 描述信息对象，如文件不存在，则返回null。
     * @since 1.0.0
     */
    static fromRawfilePathSync(context: Context, b23: string): BitmapDescriptor | undefined;
    static fromFd(fd: number): Promise<BitmapDescriptor | undefined>;
    /**
     * 根据 asset 目录内资源名称，创建 bitmap 描述信息对象。
     *
     * @param assetName asset 内的一个图片资源的文件名称。
     * @return 根据 asset 目录内资源名称，创建 bitmap 描述信息对象，如果图片不存在则返回null。
     * @since 1.0.0
     */
    static fromAsset(assetName: string): BitmapDescriptor | undefined;
    /**
     * 根据应用程序私有文件夹里包含文件的文件名创建 bitmap 描述信息对象。文件名应该包括路径。
     *
     * @param fileName 应用程序私有文件夹里包含文件的文件名，应该包括路径。
     * @return 根据传入的在手机存储器里的图片文件名，创建的BitmapDescriptor 对象，如文件不存在，则返回null。
     * @since 1.0.0
     */
    /**
     * 创建默认的marker 图标的 bitmap 描述信息对象。
     *
     * @return 默认的marker 图标BitmapDescriptor 对象
     * @since 1.0.0
     */
    static defaultMarker(): BitmapDescriptor;
    /**
     * API 提供了10 个颜色的Marker 图标，用户可以通过此方法传入值来调用。请参见本类的常量。
     *
     * @param hue 请参见本类的常量。
     * @return API 提供的彩色marker 图标 的 bitmap描述对象。
     * @since 1.0.0
     */
    static defaultMarker(z22: number): BitmapDescriptor;
    /**
     * 创建默认的marker 图标的 bitmap 描述信息对象。
     *
     * @return 默认的marker 图标BitmapDescriptor 对象
     * @since 1.0.0
     */
    static defaultMarkerASync(context: Context): Promise<BitmapDescriptor>;
    /**
     * API 提供了10 个颜色的Marker 图标，用户可以通过此方法传入值来调用。请参见本类的常量。
     *
     * @param hue 请参见本类的常量。
     * @return API 提供的彩色marker 图标 的 bitmap描述对象。
     * @since 1.0.0
     */
    static defaultMarkerASync(context: Context, v22: number): Promise<BitmapDescriptor>;
    static fromPixelMap(pixelMap: PixelMap): Promise<BitmapDescriptor | undefined>;
    static fromPixelMapSync(pixelMap: PixelMap): BitmapDescriptor | undefined;
}
