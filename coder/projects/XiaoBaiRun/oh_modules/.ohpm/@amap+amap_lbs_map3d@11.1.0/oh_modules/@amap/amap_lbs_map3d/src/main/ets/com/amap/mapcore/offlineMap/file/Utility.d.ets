// @keepTs
// @ts-nocheck
import { OfflineMapProvince } from "../../../api/maps/offlinemap/OfflineMapProvince";
import ArrayList from "@ohos.util.ArrayList";
import { OfflineMapCity } from "../../../api/maps/offlinemap/OfflineMapCity";
export declare class t181 {
    static readonly w197 = "offlinemapv4.png";
    /**
     * 保存省份列表1个全国概要图+33个省及直辖市（不包含台湾）
     */
    static readonly x197 = "status";
    static readonly y197 = "complete";
    static readonly z197 = "adcode";
    static readonly a198 = "name";
    static readonly b198 = "sheng";
    static readonly c198 = "version";
    static readonly d198 = "status";
    static readonly e198 = "info";
    static readonly f198 = "utf-8";
    static readonly g198 = "vmap/";
    static readonly h198 = "vmap/";
    static readonly z184 = "map/";
    static readonly o185 = ".zip";
    static readonly i198 = ".tmp";
    static readonly j198 = ".dt";
    static readonly k198 = ".info";
    static readonly l198 = ".zip.tmp.dt";
    static readonly m198 = ".dat";
    static readonly n198 = ";";
    static readonly o198 = "result";
    static readonly p198 = "offlinemap_with_province_vfour";
    static readonly q198 = "offlinemapinfo_with_province";
    static readonly r198 = "version";
    static readonly s198 = "provinces";
    static readonly t198 = "others";
    /**各个版本全国概要图的名称 adcode*/
    /**v4*/
    static readonly u198 = "quanguogaiyaotu";
    static readonly v198 = "quanguo";
    /**v4 前期*/
    static readonly w198 = "000001";
    /**v4 后期 ae8 也是 100000*/
    static readonly x198 = "100000";
    static readonly y198 = "a0";
    static readonly z198 = "m1.ans";
    static readonly a199 = "m3.ans";
    static readonly b199 = "[]";
    static readonly c199: number;
    static g185(): number;
    static d199(v197: number): void;
    static log(u197: string): void;
    static c184(t197: string): void;
    /**
     * 根据url 解析 被下载文件的名称
     * @param url
     * @return
     */
    static k103(json: string, context: Context): ArrayList<OfflineMapProvince>;
    static e199(i197: object | undefined, context: Context): ArrayList<OfflineMapProvince>;
    static g199(f197: object): OfflineMapProvince;
    static i199(a197: object): OfflineMapCity[];
    static j199(x196: object): OfflineMapCity;
    /**
     * 获取一个文件或文件夹的大小
     *
     * @param file
     * @return
     */
    static e185(path: string): number;
    static f199(u196: object | null, key: string): string;
    private static h199;
    /**
     * 删除临时文件夹
     *
     * @param adcode
     * @throws IOException
     * @throws Exception
     */
    static k199(q196: string, r196: Context): void;
    /**
     * 删除空目录
     *
     * @param dir
     */
    static m199(dir: string): void;
    /**
     * 在MapDownloadManager.readOfflineAllCity中有读去这里写的文件
     * @param json
     */
    static n199(json: string, o196: Context): void;
    /**
     * 根据url 解析 被下载文件的名称
     * @param url
     * @return
     */
    static d185(url: string): string;
    static deleteFile(dir: string): boolean;
    static o199(context: Context, n196: string): string;
}
