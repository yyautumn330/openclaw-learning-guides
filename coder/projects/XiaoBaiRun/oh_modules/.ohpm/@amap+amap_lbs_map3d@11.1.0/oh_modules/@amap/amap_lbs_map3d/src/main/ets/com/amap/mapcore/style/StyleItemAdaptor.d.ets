// @keepTs
// @ts-nocheck
/**
 * 兼容老版本样式文件
 * Package : com.amap.api.mapcore.style
 *
 * @author : xudong.tang
 *         Date   : 17/5/24
 */
export declare class i218 {
    static readonly u218: string;
    static readonly m219: string;
    static readonly v218: string;
    static readonly t218: string;
    static readonly s218: string;
    static readonly r218: string;
    static readonly q218: string;
    static readonly x218: string;
    static readonly n219: string;
    static readonly o219: string;
    static readonly p219: string;
    static readonly q219: string;
    static readonly r219: string;
    static readonly s219: string;
    static readonly t219: string;
    static readonly w218: string;
    static readonly u219: string;
    static readonly v219: string;
    static readonly w219: string;
    static readonly x219: string;
    /**
     * 对照表
     */
    static readonly y219: number[][];
    static readonly z219: string[];
    static readonly a220: string[][];
    static readonly b220: string[];
    /**
     * 新老版本Style样式对应
     *
     * @param styleTypeName
     * @return
     */
    static c220(k219: string): number[] | undefined;
    /**
     * 新老版本样式名称对应
     *
     * @param styleTypeName 旧版本名称
     * @return 对应新版的名称
     */
    static d220(i219: string): string[] | undefined;
    /**
     * 新老版本样式名称对应-类型划分
     * 新版本总共给分 regions water buildings roads labels borders
     *
     * @param styleTypeName
     * @return
     */
    static e220(g219: string): string;
}
