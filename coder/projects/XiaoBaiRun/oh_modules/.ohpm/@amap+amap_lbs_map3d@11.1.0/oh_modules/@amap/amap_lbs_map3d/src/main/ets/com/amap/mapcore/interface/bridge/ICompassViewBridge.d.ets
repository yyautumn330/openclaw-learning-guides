// @keepTs
// @ts-nocheck
import matrix4 from "@ohos.matrix4";
export type z107 = (visible: boolean) => void;
export type y107 = (resource: Resource | PixelMap) => void;
export type x107 = (matrix: matrix4.Matrix4Transit) => void;
export type w107 = (event?: TouchEvent) => void;
export type v107 = (oldValue: Area, newValue: Area) => void;
export interface u107 {
    i108(visible: boolean): void;
    j108(resource: Resource | PixelMap): void;
    k108(matrix: matrix4.Matrix4Transit): void;
    c15(event?: TouchEvent): void;
    d15(oldValue: Area, newValue: Area): void;
    m108(click?: w107): void;
    l108(change: v107): void;
    v13(visibleChange?: z107): void;
    w13(resourceChange?: y107): void;
    x13(matrixChange?: x107): void;
}
