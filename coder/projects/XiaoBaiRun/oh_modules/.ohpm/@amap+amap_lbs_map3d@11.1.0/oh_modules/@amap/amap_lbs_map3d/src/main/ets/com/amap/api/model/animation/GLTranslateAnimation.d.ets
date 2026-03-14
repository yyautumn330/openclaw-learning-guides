// @keepTs
// @ts-nocheck
import { LatLng } from '../LatLng';
import { n18 } from './GLAnimation';
import { u18 } from './GLTransformation';
export declare class l21 extends n18 {
    o21: number;
    p21: number;
    q21: number;
    r21: number;
    s21: number;
    t21: number;
    constructor(latLng: LatLng);
    /**
     * 在markeDelegate中设置
     * @param latLng
     */
    u21(latLng: LatLng): void;
    protected applyTransformation(m21: number, n21: u18): void;
}
