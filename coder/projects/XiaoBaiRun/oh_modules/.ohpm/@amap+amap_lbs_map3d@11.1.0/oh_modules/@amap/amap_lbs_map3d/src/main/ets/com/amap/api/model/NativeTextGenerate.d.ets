// @keepTs
// @ts-nocheck
import { BitmapDescriptor } from './BitmapDescriptor';
import { TextGenerateTextBitmap } from "./TextGenerateTextBitmap";
import { TextGenerateTextStyle } from "./TextGenerateTextStyle";
import { TextGeneratePOIStyleDesc } from "./TextGeneratePOIStyleDesc";
/**
 * 下沉层文字生产bitmap的工具
 */
export declare class NativeTextGenerate {
    private static instance;
    private density;
    constructor();
    static getInstance(): NativeTextGenerate;
    n41(density: number): void;
    private o41;
    private p41;
    calculateTextBoundSize(f41: TextGenerateTextBitmap, style: TextGenerateTextStyle, g41: TextGeneratePOIStyleDesc): TextGenerateTextBitmap | undefined;
    generateTextBitmap(q40: TextGenerateTextBitmap, style: TextGenerateTextStyle, r40: TextGeneratePOIStyleDesc): TextGenerateTextBitmap | undefined;
    getIconBitmap(fileName: string): BitmapDescriptor | null;
    getMapStyleJsonData(): Uint8Array;
    getMapStyleFileData(fileName: string): Uint8Array;
}
