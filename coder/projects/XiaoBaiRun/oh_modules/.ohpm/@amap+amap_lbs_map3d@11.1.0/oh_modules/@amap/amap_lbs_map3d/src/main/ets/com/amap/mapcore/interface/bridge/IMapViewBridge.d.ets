// @keepTs
// @ts-nocheck
/**
 * mapview组件的桥接
 *
 */
import { o107 } from './ICommonBridge';
import { y108 } from './IMapWidgetsBridge';
import { x108 } from './IWebViewBridge';
import { w99 } from './IXComponentBridge';
export interface d12 {
    i13(commonBridge: o107): void;
    j13(webViewBridge: x108): void;
    k13(xComponentBridge: w99): void;
    l13(mapWidgetBridge: y108): void;
    g14(): o107 | undefined;
    u14(): x108 | undefined;
    l14(): w99 | undefined;
    n13(): y108 | undefined;
    z15(): string;
}
