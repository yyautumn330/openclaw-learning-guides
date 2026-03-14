// @keepTs
// @ts-nocheck
import { w24 } from "../../mapcore/AVectorCrossAttr";
import { x24 } from "../../mapcore/interface/ICrossVectorOverlay";
/**
 *
 * @author zxy
 * @date 16/11/10
 * @exclude javadoc中不显示
 */
export declare class b1 {
    /**
     * 更新类型
     */
    static d25: number;
    private e25;
    constructor(c25: x24);
    /**
     * 异步操作，内部会转线程
     * 设置路口放大图数据
     * @param data
     * @return 0 返回值已废弃，使用setOnCrossVectorUpdateListener替换
     */
    setData(data: Int8Array): number;
    setAttribute(attr: w24): void;
    /**
     * 异步操作，内部会转线程
     * @param visible
     */
    setVisible(visible: boolean): void;
    /**
     * 异步操作，内部会转线程
     * 移除路口放大图
     */
    remove(): void;
    /**
     * 设置了之后地图上将不会展示矢量路口放大图
     * @param isImageMode
     */
    f25(b25: boolean): void;
    g25(listener: y24): void;
    /**
     * 路口放大图属性更新监听
     * @param listener
     */
    h25(listener: z24): void;
}
/**
 * 路口放大图图片生成监听
 */
export interface y24 {
    /**
     * 生成完成
     * @param bitmap 图片
     * @param status 错误码 -1为失败
     */
    i25?: (bitmap: PixelMap | null, status: number) => void;
}
/**
 * 路口更新回调
 */
export interface z24 {
    /**
     * 更新回调
     * @param type 更新类型
     * @param item 更新 -1为失败
     */
    onUpdate?: (type: number, item: a25) => void;
}
export declare class a25 {
    /**
     * 设置路口放大图数据
     * @param data
     * @return 0 成功， -1 失败； 其他情况详细参考返回值其他说明
     * 关于返回值的说明：
     * 1001  非法buffer，小于8字节
     * 1002  buffer长度和数据指定不同
     * 1003  版本解析失败，服务端不是2.0，离线版本不是1.0
     * 1004  crc检验失败
     * 1102  SDK参数类型传递错误
     * 1103  绑定box时发生错误
     * 1104  绑定道路数据时发生错误
     * 1105  绑定导航参数时发生错误
     * 2001  拓扑关系错误
     * 2002  道路压盖数目超过设定阈值（目前是4个点）
     * 2003  道路宽度缩小于原始道路宽度0.4倍
     * 3012  获取绑定车道线失败
     */
    j25: number;
}
