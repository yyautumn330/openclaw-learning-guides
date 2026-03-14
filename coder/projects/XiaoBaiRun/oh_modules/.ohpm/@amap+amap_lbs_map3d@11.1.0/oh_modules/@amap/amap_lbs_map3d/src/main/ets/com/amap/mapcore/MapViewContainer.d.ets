// @keepTs
// @ts-nocheck
import { d12 } from './interface/bridge/IMapViewBridge';
/**
 *  管理mapviwe的桥接接口
 */
export type f176 = (engineId: number) => void;
export type g176 = (engineId: number, mapViewName: string, mapView: d12) => void;
export type h176 = (engineId: number) => void;
export declare class j15 {
    private q176;
    private r176;
    constructor(o176: g176, p176: h176);
    get g176(): g176;
    get h176(): h176;
}
export declare class b12 {
    private static sInstance?;
    private engineId;
    private s176;
    private t176;
    private u176;
    private v176;
    private constructor();
    static getInstance(): b12;
    g13(): number;
    y15(listener: j15): void;
    w176(listener: j15): void;
    c16(listener: f176): void;
    x176(listener: f176): void;
    w14(n176: number): void;
    k14(k176: number, l176: string, m176: d12): void;
    n14(j176: number): void;
    h13(i176: number): d12;
}
