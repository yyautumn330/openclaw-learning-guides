// @keepTs
// @ts-nocheck
import { j107 } from '../interface/bridge/IBlankViewBridge';
import { u107 } from '../interface/bridge/ICompassViewBridge';
import { n108 } from '../interface/bridge/ILocationViewBridge';
import { y108 } from '../interface/bridge/IMapWidgetsBridge';
import { j109 } from '../interface/bridge/IScaleViewBridge';
import { k109 } from '../interface/bridge/IWaterMarkerViewBridge';
import { l109 } from '../interface/bridge/IZoomControllerViewBridge';
export declare class n12 implements y108 {
    private s109;
    private t109;
    private u109;
    private v109;
    private w109;
    private x109;
    constructor(m109: j107, n109: n108, o109: u107, p109: j109, q109: k109, r109: l109);
    o13(): j107;
    r13(): n108;
    u13(): u107;
    y13(): j109;
    a14(): k109;
    c14(): l109;
}
