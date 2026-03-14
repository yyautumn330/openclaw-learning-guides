// @keepTs
// @ts-nocheck
import ArrayList from "@ohos.util.ArrayList";
import { TMC } from "./TMC";
export declare class TimeInfosElement {
    m86: number;
    o78: number;
    v74: number;
    y74: number;
    private s78;
    /**
     * 返回驾车未来路径规划路线索引。
     * @return 路径规划路线索引
     * @since V6.9.0
     */
    getPathindex(): number;
    /**
     * 设置驾车未来路径规划路线索引。
     * @param pathindex 路径规划路线索引。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    f35(l86: number): void;
    /**
     * 返回驾车未来路径规划路线总时长。
     * @return 路径规划路线总时长，单位：分钟
     * @since V6.9.0
     */
    getDuration(): number;
    /**
     * 设置驾车未来路径规划路线总时长。
     * @param duration 路径规划路线总时长，单位：分钟。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    setDuration(duration: number): void;
    /**
     * 返回驾车未来路径规划路线总收费。
     * @return 路径规划路线总收费，单位：元
     * @since V6.9.0
     */
    getTolls(): number;
    /**
     * 设置驾车未来路径规划路线总收费。
     * @param tolls 路径规划路线总收费，单位：元
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    setTolls(k86: number): void;
    /**
     * 返回驾车未来路径规划路线是否有限行路段。
     * @return 路径规划路线是否有限行路段，0：代表限行已规避或未限行，即该路线没有限行路段
     * 1：代表限行无法规避，即该线路有限行路段
     * @since V6.9.0
     */
    getRestriction(): number;
    /**
     * 设置驾车未来路径规划路线是否有限行路段。
     * @return 路径规划路线是否有限行路段，0：代表限行已规避或未限行，即该路线没有限行路段
     * 1：代表限行无法规避，即该线路有限行路段
     * @since V6.9.0
     */
    setRestriction(j86: number): void;
    setTMCs(i86: ArrayList<TMC>): void;
    getTMCs(): ArrayList<TMC>;
}
