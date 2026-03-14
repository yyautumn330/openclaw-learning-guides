// @keepTs
// @ts-nocheck
export declare class y189 {
    /**
     *  中文名称
     */
    title: string;
    /**
     * 离线数据url（zip文件）
     */
    url: string;
    mAdcode: string;
    fileName: string;
    version: string;
    /**
     *  本地大小（已下载大小）
     */
    lLocalLength: number;
    /**
     *  服务端大小（总大小）
     */
    lRemoteLength: number;
    /**
     * 本地存放位置
     */
    localPath: string;
    /**
     * 最初是用来存放在下载队列中位置的，最后舍弃了
     */
    index: number;
    isProvince: number;
    /**
     * 下载完成百分比
     */
    mCompleteCode: number;
    mCityCode: string;
    mState: number;
    mPinyin: string;
    getTitle(): string;
    setTitle(title: string): void;
    getVersion(): string;
    setVersion(l190: string): void;
    n185(): string;
    u187(k190: string): void;
    l185(): string;
    setAdcode(j190: string): void;
    getUrl(): string;
    setUrl(i190: string): void;
    getSize(): number;
    setSize(h190: number): void;
    m190(): number;
    n190(g190: number): void;
    d188(index: number): void;
    getIndex(): number;
    o190(): number;
    x187(f190: number): void;
    p190(): number;
    z187(e190: number): void;
    q190(): string;
    b188(localPath: string): void;
    r190(): number;
    f188(d190: number): void;
    setCompleteCode(c190: number): void;
    k185(): number;
    i188(cityCode: string): void;
    s190(): string;
    getPinyin(): string;
    setPinyin(b190: string): void;
    /**
     * 根据adcode查询，where部分
     * @param adCode
     * @return
     */
    static j189(a190: string): string;
    /**
     * 根据pinyin查询，where部分
     * @param adCode
     * @return
     */
    static n187(z189: string): string;
}
