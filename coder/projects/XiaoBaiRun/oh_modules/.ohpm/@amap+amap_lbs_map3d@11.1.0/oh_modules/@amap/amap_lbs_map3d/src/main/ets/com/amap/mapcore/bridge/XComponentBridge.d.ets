// @keepTs
// @ts-nocheck
import { w99 } from '../interface/bridge/IXComponentBridge';
import { l72 } from '../AMapXComponentDelegate';
export declare class g12 implements w99 {
    private z110;
    private a111?;
    constructor();
    i89(delegate: l72): void;
    onSurfaceCreated(instance: bigint, y110: string, width: bigint, height: bigint): void;
    onSurfaceChanged(instance: bigint, x110: string, width: bigint, height: bigint): void;
    onSurfaceDestroyed(instance: bigint, w110: string): void;
    y14(v110: string): void;
    z14(u110: string): void;
    x14(): XComponentController;
}
