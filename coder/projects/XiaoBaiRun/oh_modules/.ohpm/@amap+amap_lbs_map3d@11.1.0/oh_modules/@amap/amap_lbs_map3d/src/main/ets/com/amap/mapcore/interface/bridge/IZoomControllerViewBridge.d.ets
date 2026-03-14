// @keepTs
// @ts-nocheck
export type c111 = (visible: boolean) => void;
export type d111 = (event: TouchEvent) => void;
export type e111 = (event: TouchEvent) => void;
export type b111 = (postion: number) => void;
export type f111 = (zoomLevel: number, maxZoomLevel: number, minZoomLevel: number) => void;
export interface l109 {
    t111(visible: boolean): void;
    r111(position: number): void;
    f15(event: TouchEvent): void;
    g15(event: TouchEvent): void;
    p111(listener: d111): void;
    q111(listener: e111): void;
    d14(listener: c111): void;
    f14(listener: b111): void;
    s111(zoomLevel: number, maxZoomLevel: number, minZoomLevel: number): void;
    e14(resoureChange: f111): void;
}
