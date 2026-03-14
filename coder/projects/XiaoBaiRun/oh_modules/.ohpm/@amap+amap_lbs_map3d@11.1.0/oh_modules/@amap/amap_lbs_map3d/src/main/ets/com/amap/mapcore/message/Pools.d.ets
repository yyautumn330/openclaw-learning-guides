// @keepTs
// @ts-nocheck
export interface r17<T> {
    /**
     * An instance from the pool if such, null otherwise.
     * @return An instance from the pool if such, null otherwise.
     */
    acquire(): T | undefined;
    /**
     * Release an instance to the pool.
     *
     * @param instance The instance to release.
     * @return Whether the instance was put in the pool.
     *
     * @throws IllegalStateException If the instance is already in the pool.
     */
    release(instance: T | undefined): boolean;
    /**
     * destroy
     */
    h177(): void;
}
/**
 * Simple (non-synchronized) pool of objects.
 *
 * @param <T> The pooled type.
 */
export declare class s17<T> implements r17<T> {
    private readonly y17;
    private z17;
    /**
     * Creates a new instance.
     *
     * @param maxPoolSize The max pool size.
     *
     * @throws IllegalArgumentException If the max pool size is less than zero.
     */
    constructor(a178: number);
    acquire(): T | undefined;
    release(instance: T): boolean;
    h177(): void;
    private a18;
}
/**
 * Synchronized) pool of objects.
 *
 * @param <T> The pooled type.
 */
export declare class t17<T> extends s17<T> {
    /**
     * Creates a new instance.
     *
     * @param maxPoolSize The max pool size.
     *
     * @throws IllegalArgumentException If the max pool size is less than zero.
     */
    constructor(w177: number);
    acquire(): T | undefined;
    release(element: T): boolean;
}
