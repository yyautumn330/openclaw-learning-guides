// @keepTs
// @ts-nocheck
export interface r17<T> {
    acquire(): T | undefined;
    release(instance: T): boolean | undefined;
    destroy(): void;
}
export declare class s17<T> implements r17<T> {
    private readonly y17?;
    private z17;
    constructor(x17: number);
    acquire(): T | undefined;
    release(instance: T): boolean | undefined;
    destroy(): void;
    private a18;
}
export declare class t17<T> extends s17<T> {
    private readonly b18;
    constructor(u17: number);
    acquire(): T | undefined;
    release(element: T): boolean | undefined;
}
