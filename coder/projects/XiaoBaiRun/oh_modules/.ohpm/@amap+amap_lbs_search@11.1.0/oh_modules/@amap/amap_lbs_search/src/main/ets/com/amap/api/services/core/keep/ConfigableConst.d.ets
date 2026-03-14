// @keepTs
// @ts-nocheck
import { SDKInfo } from '@amap/amap_lbs_common';
/**
 * ConfigableConst
 *
 * <p>
 * Base class with code to manage the global Const
 *
 * @author
 * @version 1.0 2010.01.22<br>
 *
 */
export declare class c5 {
    static readonly i6 = 2;
    static readonly d9 = 5;
    static readonly e9 = 2;
    static readonly HTTP: number;
    static readonly HTTPS: number;
    /**
     * MapSDK版本号
     */
    static readonly Version = "1.0.1";
    static readonly f9 = "1.0.1";
    static readonly o7 = "sea";
    static readonly g9 = "cloud";
    static readonly n7: string;
    static readonly h9 = "http://restsdk.amap.com/v3";
    private static readonly i9;
    static readonly j9 = "http://restsdk.amap.com/v4";
    static readonly k9 = "https://restsdk.amap.com/v4";
    static readonly l9 = "http://restsdk.amap.com/v5";
    static readonly m9 = "https://restsdk.amap.com/v5";
    static readonly n9 = "https://restsdk.amap.com/v4/etd/driving";
    static readonly o9 = "http://yuntuapi.amap.com";
    static readonly p9 = "https://yuntuapi.amap.com";
    static readonly q9 = "http://restsdk.amap.com/rest/me/cpoint";
    static readonly r9 = "https://restsdk.amap.com/rest/me/cpoint";
    static readonly s9 = "http://apistore.amap.com";
    static readonly t9 = "https://apistore.amap.com";
    static readonly u9 = "http://wb.amap.com";
    static readonly debug = false;
    static readonly tag = "amapservice";
    static readonly v9: string[];
    static readonly w9 = "8UbJH6N2szojnTHONAWzB6K7N1kaj7Y0iUMarxac";
    static readonly x9 = "http://m5.amap.com/ws/mapapi/shortaddress/transform";
    static readonly y9 = "https://m5.amap.com/ws/mapapi/shortaddress/transform";
    static readonly z9 = "Yaynpa84IKOfasFx";
    static a8(): string;
    static a10(): string;
    static j8(): string;
    static b10(): string;
    static c10(): string;
    static d10(): string;
    static e10(): string;
    /**
     * 获取 SDKInfo
     * @param isUpdate 是否上传日志
     * @returns
     */
    static f10(b9: boolean): SDKInfo;
    static g10(): SDKInfo;
    static h10(): string;
}
