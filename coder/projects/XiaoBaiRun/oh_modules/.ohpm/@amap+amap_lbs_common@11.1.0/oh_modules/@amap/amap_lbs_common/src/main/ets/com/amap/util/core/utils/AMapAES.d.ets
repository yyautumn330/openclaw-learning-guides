// @keepTs
// @ts-nocheck
import cryptoFramework from '@ohos.security.cryptoFramework';
export declare class a22 {
    /**
     * 偏移量, 16位
    */
    static readonly y29: number[];
    /**
     * 生成的加密key
     */
    y69?: cryptoFramework.SymKey;
    /**
     * 加密对象
     */
    z69?: cryptoFramework.Cipher;
    /**
     * 解对象
     */
    a70?: cryptoFramework.Cipher;
    algName: string;
    constructor(algName?: string);
    /**
     * CBCParamsSpec
     */
    private w68;
    b70(): Promise<void>;
    /**
     * 创建aes加密对象
     */
    c70(): Promise<void>;
    /**
     * 创建aes加密对象
     */
    d70(): Promise<void>;
    /**
     * 加密对象创建后可进行加密
     *
     * @param plainData 加密数据。
     * @since 1.0.0
     */
    encrypt(o69: Uint8Array): Promise<cryptoFramework.DataBlob>;
    /**
     * 创建加密对象后进行解密
     *
     * @param encryptData 解密数据。
     * @since 1.0.0
     */
    decrypt(m69: Uint8Array): Promise<cryptoFramework.DataBlob>;
}
/**
 * 自定义Key
 *
 * @param keyMaterialStr 加解密key，注意AES加解密key必须保持相同
 */
export declare function x68(i69: Uint8Array): cryptoFramework.DataBlob;
/**
 * 创建自定义Key aes加密对象
 *
 * @param keyMaterialStr 加解密key，注意AES加解密key必须保持相同
 * @param iv 向量，注意AES加解密iv必须保持相同
 * @param data 被加密或者被解密的数据
 * @param cryptoMode 加密：ENCRYPT_MODE 解密：DECRYPT_MODE
 */
export declare function b22(y68: Uint8Array, iv: Uint8Array, data: Uint8Array, z68: cryptoFramework.CryptoMode, a69?: string): Promise<Uint8Array>;
