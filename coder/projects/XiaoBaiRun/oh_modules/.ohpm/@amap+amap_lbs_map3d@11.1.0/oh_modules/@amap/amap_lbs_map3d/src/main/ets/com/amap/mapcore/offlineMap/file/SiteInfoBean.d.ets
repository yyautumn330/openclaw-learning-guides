// @keepTs
// @ts-nocheck
/**
 * 辅助分块，临时存储离线数据下载信息 <br>
 * 保存有下载分块数量，离线数据url，文件路径，文件名字以及城市adcode
 * @author zxy
 */
export declare class y193 {
    /** Site's url*/
    private f196;
    /** Saved File's Path*/
    private g196;
    /** Saved File's Name*/
    private h196;
    /** Count of Splited Downloading File*/
    private i196;
    private c189;
    constructor(a196: string, b196: string, c196: string, d196: number, e196: string);
    n195(): string;
    j196(value: string): void;
    g195(): string;
    k196(value: string): void;
    h195(): string;
    l196(value: string): void;
    r195(): number;
    m196(z195: number): void;
    l185(): string;
    m188(y195: string): void;
}
