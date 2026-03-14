// @keepTs
// @ts-nocheck
import { x35 } from './ADIURunner';
export declare class AdiuManager {
    private mKey;
    private mContext;
    private static isGettingADIU;
    private static isLocalADIUExist;
    mAdiu: string;
    private adiuRunner;
    private static instance?;
    constructor(context: Context);
    static getInstance(context: Context): AdiuManager;
    getAdiu(): Promise<string>;
    /**
     * 更新adiu
     * @param context
     * @param adiuRunner
     * @returns
     */
    updateADIUFromNet(h36: x35): Promise<string>;
    setAdiu(context: Context, g36: string): void;
    private o36;
    private u36;
    private v36;
    private p36;
}
