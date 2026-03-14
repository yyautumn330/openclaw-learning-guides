// @keepTs
// @ts-nocheck
/**
 * 描述地图将要发生的变化
 * @since 1.0.0
 */
import { v6 } from '../mapcore/camera/AbstractCameraUpdateMessage';
export declare class CameraUpdate {
    private y6;
    constructor(x6: v6);
    get coreCameraUpdate(): v6;
    toString(): string;
}
