// @keepTs
// @ts-nocheck
export declare class SDKInfo {
    private u27;
    private f56;
    private g56;
    private h56;
    private i56;
    private j56;
    constructor(version: string, c56: string, d56: string, e56: string, packages: string[]);
    getSDKName(): string;
    getSDKVersion(): string;
    getSDKHttpAgent(): string;
    getCustomName(): string;
    getPackages(): string[];
    setUpdateLog(b56: boolean): void;
    isUpdateLog(): boolean;
}
