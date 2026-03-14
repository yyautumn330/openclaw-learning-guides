// @keepTs
// @ts-nocheck
/**
 * 引擎Camera参数获取
 * @since 2.0.0
 */
export declare class AMapCameraInfo {
    /**
     * 可视角度
     */
    private fov;
    /**
     * 横纵比
     */
    private aspectRatio;
    /**
     * 旋转角度
     */
    private rotate;
    /**
     * 相机位置
     */
    private positionX;
    private positionY;
    private positionZ;
    /**
     * 构造函数
     * @param fov           可视角度
     * @param aspectRatio   横纵比
     * @param rotate        旋转角度
     * @param positionX    相机位置 x 轴
     * @param positionY    相机位置 y 轴
     * @param positionZ    相机位置 z 轴
     */
    constructor(fov: number, aspectRatio: number, rotate: number, positionX: number, positionY: number, l18: number);
    /**
     *  获取Fov（视角）
     * @return
     */
    getFov(): number;
    /**
     * 获取视窗纵横比
     * @return
     */
    getAspectRatio(): number;
    /**
     * 获取旋转角度
     * @return
     */
    getRotate(): number;
    /**
     * 获取相机位置坐标
     * @return
     */
    getX(): number;
    getY(): number;
    getZ(): number;
    toString(): string;
}
