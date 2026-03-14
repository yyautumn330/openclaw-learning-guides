// @keepTs
// @ts-nocheck
import { v99 } from './interface/IAMapXComponentCallback';
import { w99 } from './interface/bridge/IXComponentBridge';
export declare class i12 implements v99 {
    private b100;
    constructor(a100: w99);
    onSurfaceCreated(instance: bigint, z99: string, width: bigint, height: bigint): void;
    onSurfaceChanged(instance: bigint, y99: string, width: bigint, height: bigint): void;
    onSurfaceDestroyed(instance: bigint, x99: string): void;
}
