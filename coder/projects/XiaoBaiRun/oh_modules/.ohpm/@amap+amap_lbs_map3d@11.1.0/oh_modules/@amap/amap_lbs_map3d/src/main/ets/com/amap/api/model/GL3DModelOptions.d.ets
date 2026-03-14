// @keepTs
// @ts-nocheck
import { BaseOptions } from './BaseOptions';
import { BitmapDescriptor } from './BitmapDescriptor';
import ArrayList from "@ohos.util.ArrayList";
import { LatLng } from './LatLng';
export declare class GL3DModelOptions extends BaseOptions {
    private vertexList;
    private textureList;
    private rotate;
    private latLng;
    private isModelUpdate;
    private modelData;
    private bitmapDescriptor?;
    private fixedLength;
    private altitude;
    private fixedDisplaySizeEnabled;
    private fixedDisplaySizeX;
    private fixedDisplaySizeY;
    private visible;
    private title;
    private snippet;
    private zIndex;
    constructor();
    textureDrawable(descriptor: BitmapDescriptor): GL3DModelOptions;
    vertexData(t26: string): GL3DModelOptions;
    vertexData(u26: ArrayList<number>, v26: ArrayList<number>): GL3DModelOptions;
    position(position: LatLng): GL3DModelOptions;
    angle(rotate: number): GL3DModelOptions;
    getVertex(): ArrayList<number>;
    getTexture(): ArrayList<number>;
    getAngle(): number;
    getLatLng(): LatLng;
    getBitmapDescriptor(): BitmapDescriptor | undefined;
    setModelFixedLength(s26: number): GL3DModelOptions;
    getModelFixedLength(): number;
    setAltitude(altitude: number): GL3DModelOptions;
    getAltitude(): number;
    setFixedDisplaySizeEnabled(r26: boolean): GL3DModelOptions;
    isFixedDisplaySizeEnabled(): boolean;
    setFixDisplaySize(p26: number, q26: number): GL3DModelOptions;
    getFixDisplaySize(): [
        number,
        number
    ];
    setVisible(visible: boolean): GL3DModelOptions;
    isVisible(): boolean;
    setTitle(title: string): GL3DModelOptions;
    setSnippet(snippet: string): GL3DModelOptions;
    getTitle(): string;
    getSnippet(): string;
    setZIndex(zIndex: number): GL3DModelOptions;
    getZIndex(): number;
}
