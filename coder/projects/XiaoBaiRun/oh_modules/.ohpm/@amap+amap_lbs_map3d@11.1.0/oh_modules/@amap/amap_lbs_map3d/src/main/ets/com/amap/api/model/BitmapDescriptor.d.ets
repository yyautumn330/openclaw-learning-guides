// @keepTs
// @ts-nocheck
/**
 * bitmap 描述信息
 * 在高德地图API 里，如果需要将一张图片绘制为Marker，需要用这个类把图片包装成对象，可以通过BitmapDescriptorFactory
 * 获得一个BitmapDescriptor 对象。
 *
 * @since 1.0.0
 */
export declare class BitmapDescriptor {
    private static readonly TAG;
    protected w: number;
    protected h: number;
    protected mResource: Resource;
    static INVALID_ID: string;
    private mId;
    private mBitmap;
    /**
     * @param bitmap
     * @exclude javadoc中不显示
     */
    constructor(resource: Resource | ArrayBuffer, u329: string);
    constructor(resource: Resource | ArrayBuffer, l22: string, w: number, h: number);
    /**
     * 内部使用
     * @exclude javadoc中不显示
     * @return
     */
    getId(): string;
    /**
     * 复制一个BitmapDescriptor
     * @return
     * @exclude javadoc中不显示
     */
    /**
     * 获取 对应的Bitmap 对象。获取的图片非原有尺寸，图片大小为接近的2^n 。请根据需要使用此方法。
     *
     * @return Bitmap对象
     * @since 1.0.0
     */
    getResource(): Resource;
    /**
     * 返回 Bitmap的宽度。
     *
     * @return Bitmap的宽度。
     * @since 1.0.0
     */
    getWidth(): number;
    /**
     * 返回 Bitmap 的高度。
     *
     * @return Bitmap 的高度。
     * @since 1.0.0
     */
    getHeight(): number;
    /**
     * @return
     * @exclude javadoc中不显示
     */
    describeContents(): number;
    /**
     * @param out
     * @param flags
     * @exclude javadoc中不显示
     */
    /**
     * 回收 resource 资源，请确保在不再使用该 resource descriptor 时再调用该函数。
     * @since 1.0.0
     */
    recycle(): void;
    /**
     * @param o
     * @return
     * @exclude javadoc中不显示
     */
    equals(h22: object): boolean;
    /**
     * @return
     * @exclude javadoc中不显示
     */
    toString(): string;
}
