// @keepTs
// @ts-nocheck
import { y72 } from "./StyleParserResult";
/**
 * 自定义样式纹理文件下载及copy到指定目录任务
 * @author zxy
 */
export declare class z72 {
    private static readonly e217;
    private mContext?;
    /** 在线获取自定义地图样式相关 */
    private request?;
    private f217?;
    /** 下载完成回调 */
    private listener?;
    constructor(context: Context);
    x96(url: string): void;
    m89(listener: a73 | undefined): void;
    y96(d217: y72): void;
    d203(): Promise<void>;
    private h217;
    private g217;
    interrupt(): void;
    start(): void;
}
/**
 * 纹理，下载完成之后回调
 */
export interface a73 {
    /**
     * 下载完成回调
     * @param savePath 存放到到sd卡 的路径
     * @param styleParserResult 解析结果 算是唯一标识 外部传入
     */
    r89: (savePath: string, styleParserResult: y72 | undefined) => void;
}
