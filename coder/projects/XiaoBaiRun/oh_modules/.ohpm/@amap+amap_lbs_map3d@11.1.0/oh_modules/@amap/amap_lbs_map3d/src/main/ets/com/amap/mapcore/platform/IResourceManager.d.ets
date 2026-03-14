// @keepTs
// @ts-nocheck
import ArrayList from '@ohos.util.ArrayList';
import { BitmapDescriptor } from '../../api/model/BitmapDescriptor';
export declare class h211 {
    data: Uint8Array;
    w128: string;
    encoding: string;
    resource: Resource;
    constructor(data: Uint8Array, resource: Resource, k211: string, encoding: string);
}
export declare class i211 extends h211 {
    width: number;
    height: number;
    constructor(data: Uint8Array, resource: Resource, j211: string, encoding: string, width: number, height: number);
}
export interface i60 {
    k162(tag: string): void;
    v128(tag: string, path: string, mimeType: string, encoding: string): h211 | null;
    u128(tag: string): h211 | null;
    j162(bitmapDescriptor: BitmapDescriptor): void;
    l211(icons: ArrayList<BitmapDescriptor>): void;
}
