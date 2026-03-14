// @keepTs
// @ts-nocheck
export declare class AMapAppResourceItem {
    static readonly RESOURCE_TYPE_NONE = 0;
    static readonly RESOURCE_TYPE_IMAGE = 1;
    static readonly RESOURCE_TYPE_SVG = 2;
    static readonly RESOURCE_TYPE_BINARY = 3;
    static readonly RESOURCE_TYPE_ABSPATH = 4;
    resourceType: number;
    data: Uint8Array;
    size: bigint;
    preAlpha: boolean;
    imageWidth: number;
    imageHeight: number;
    imageScale: number;
}
