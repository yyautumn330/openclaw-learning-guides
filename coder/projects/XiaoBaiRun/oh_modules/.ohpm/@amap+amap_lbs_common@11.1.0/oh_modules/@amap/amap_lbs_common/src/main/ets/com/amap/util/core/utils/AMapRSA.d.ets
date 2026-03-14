// @keepTs
// @ts-nocheck
import cryptoFramework from '@ohos.security.cryptoFramework';
export declare class w36 {
    n70: Uint8Array | undefined;
    o70: cryptoFramework.AsyKeyGenerator;
    cipher: cryptoFramework.Cipher;
    p70?: cryptoFramework.DataBlob;
    q70?: cryptoFramework.KeyPair;
    publicKey?: cryptoFramework.PubKey;
    constructor(m70: Uint8Array | undefined);
    r70(): Promise<void>;
    y38(i70: Uint8Array): Promise<cryptoFramework.DataBlob>;
    /**
     * 根据RSA密钥二进制数据，生成密钥对,仅公钥
  */
    x38(f70: Uint8Array): Promise<void>;
}
