// @keepTs
// @ts-nocheck
import fs from '@ohos.file.fs';
export declare class s121 {
    private static readonly g122;
    private static readonly MIN;
    private static readonly h122;
    private static readonly DAY;
    private static readonly i122;
    private static readonly j122;
    private static readonly k122;
    private static readonly l122;
    private static readonly m122;
    private static readonly n122;
    private static readonly o122;
    private static readonly p122;
    private static readonly q122;
    private static readonly r122;
    private readonly s122;
    private readonly t122;
    private readonly u122;
    private readonly v122;
    private w122?;
    /**
     * Return the single {@link CacheDiskUtils} instance.
     *
     * @param cacheDir The directory of cache.
     * @param maxSize  The max size of cache, in bytes.
     * @param maxCount The max count of cache.
     * @return the single {@link CacheDiskUtils} instance
     */
    static getInstance(cacheDir: string, maxSize: number, maxCount: number): s121;
    private constructor();
    private x122;
    /**
     * Put string value in cache.
     *
     * @param key   The key of cache.
     * @param value The value of cache.
     */
    put(key: string, value: string): string;
    /**
     * Put string value in cache.
     *
     * @param key      The key of cache.
     * @param value    The value of cache.
     * @param saveTime The save time of cache, in seconds.
     */
    put(key: string, value: string, f122: number): string;
    /**
     * Put bytes in cache.
     *
     * @param key   The key of cache.
     * @param value The value of cache.
     */
    put(key: string, value: ArrayBuffer): string;
    /**
     * Put bytes in cache.
     *
     * @param key      The key of cache.
     * @param value    The value of cache.
     * @param saveTime The save time of cache, in seconds.
     */
    put(key: string, value: ArrayBuffer, f122: number): string;
    private y122;
    /**
     * Return the bytes in cache.
     *
     * @param key          The key of cache.
     * @param defaultValue The default value if the cache doesn't exist.
     * @return the bytes if cache exists or defaultValue otherwise
     */
    d123(key: string, defaultValue?: Int8Array): Int8Array;
    f123(key: string): fs.File | undefined;
    private e123;
    /**
     * Return the string value in cache.
     *
     * @param key          The key of cache.
     * @param defaultValue The default value if the cache doesn't exist.
     * @return the string value if cache exists or defaultValue otherwise
     */
    getString(key: string, defaultValue?: string): string;
    /**
     * Return the size of cache, in bytes.
     *
     * @return the size of cache, in bytes
     */
    l123(): number;
    /**
     * Return the count of cache.
     *
     * @return the count of cache
     */
    m123(): number;
    /**
     * Remove the cache by key.
     *
     * @param key The key of cache.
     * @return {@code true}: success<br>{@code false}: fail
     */
    remove(key: string): boolean;
    /**
     * Clear all of the cache.
     *
     * @return {@code true}: success<br>{@code false}: fail
     */
    clear(): boolean;
}
