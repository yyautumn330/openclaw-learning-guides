// @keepTs
// @ts-nocheck
/**
 * mapview组件的桥接
 *
 */
import { d12 } from '../interface/bridge/IMapViewBridge';
import { o107 } from '../interface/bridge/ICommonBridge';
import { x108 } from '../interface/bridge/IWebViewBridge';
import { w99 } from '../interface/bridge/IXComponentBridge';
import { y108 } from '../interface/bridge/IMapWidgetsBridge';
export declare class c12 implements d12 {
    private e109;
    private context;
    private f109?;
    private g109?;
    private h109?;
    private i109?;
    constructor(d109: string, context: Context);
    z15(): string;
    l13(c109: y108): void;
    n13(): y108 | undefined;
    i13(b109: o107): void;
    j13(a109: x108): void;
    k13(z108: w99): void;
    g14(): o107 | undefined;
    u14(): x108 | undefined;
    l14(): w99 | undefined;
}
