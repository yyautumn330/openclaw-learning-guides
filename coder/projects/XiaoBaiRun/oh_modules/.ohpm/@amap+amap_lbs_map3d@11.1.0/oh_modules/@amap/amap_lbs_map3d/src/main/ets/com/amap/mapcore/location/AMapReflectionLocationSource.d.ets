// @keepTs
// @ts-nocheck
import { LocationSource, OnLocationChangedListener } from "../../api/LocationSource";
export declare class g73 implements LocationSource {
    private mContext;
    private mListener?;
    private interval;
    private locationManager;
    private options;
    constructor(context: Context);
    /**
     * 更新时间间隔
     * @param interval 定位时间间隔
     */
    setInterval(interval: number): void;
    activate(f168: OnLocationChangedListener): void;
    i168(): void;
    j168(): void;
    deactivate(): void;
}
