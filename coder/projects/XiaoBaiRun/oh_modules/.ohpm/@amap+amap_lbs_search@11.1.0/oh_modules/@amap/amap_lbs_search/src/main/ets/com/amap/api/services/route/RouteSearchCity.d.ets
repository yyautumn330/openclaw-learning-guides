// @keepTs
// @ts-nocheck
import { SearchCity } from "./SearchCity";
import { District } from "./District";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 此类定义路径规划返回的城市名称、编码和行政区的名称和编码。
 * @since 1.0.0
 */
export declare class RouteSearchCity extends SearchCity {
    e85: ArrayList<District>;
    /**
     * 设置城市的名称。
     * @return 所有的行政区对象。
     * @since 1.0.0
     */
    getDistricts(): ArrayList<District>;
    /**
     * 设置行政区对象。
     * @param mDistricts 行政区对象。
     * @since 1.0.0
     */
    setDistricts(d85: ArrayList<District>): void;
}
