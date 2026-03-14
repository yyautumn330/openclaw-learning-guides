// @keepTs
// @ts-nocheck
export declare class AMapUIThread {
    private static readonly q99;
    private static instance;
    private r99;
    private s99;
    private t99;
    private constructor();
    static getInstance(): AMapUIThread;
    private u99;
    isStarted(): boolean;
    start(interval?: number): void;
    stop(): void;
}
