// @keepTs
// @ts-nocheck
import { y24, z24 } from "../../api/model/CrossOverlay";
import { w24 } from "../AVectorCrossAttr";
/**
 * @author zxy
 * @data 2019-08-25
 */
export interface x24 {
    setData(data: Int8Array): number;
    setAttribute(attr: w24): void;
    setVisible(visible: boolean): void;
    remove(): void;
    f25(isImageMode: boolean): void;
    g25(listener: y24): void;
    h25(listener: z24): void;
}
