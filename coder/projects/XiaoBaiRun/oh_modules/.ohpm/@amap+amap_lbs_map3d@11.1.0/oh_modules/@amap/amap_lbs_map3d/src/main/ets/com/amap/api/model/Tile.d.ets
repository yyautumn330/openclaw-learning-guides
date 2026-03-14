// @keepTs
// @ts-nocheck
export declare class Tile {
    private mVersionCode?;
    /**
     * 编码的图片像素宽度，单位像素。
     *
     * @since V2.2.0
     */
    width?: number;
    /**
     * 编码的图片像素高度，单位像素。
     *
     * @since V2.2.0
     */
    height?: number;
    /**
     * 包含图片数据的字节数组，这个图片可以通过调用类BitmapFactory的decodeByteArray(byte[], int, int)方法来创建。
     *
     * @since V2.2.0
     */
    data?: Uint8Array;
    private isBitmap?;
    private bitmapDescriptor?;
    constructor(versionCode: number, width: number, height: number, x45: boolean, data?: Uint8Array);
    static obtain(width: number, height: number, data?: Uint8Array): Tile;
}
