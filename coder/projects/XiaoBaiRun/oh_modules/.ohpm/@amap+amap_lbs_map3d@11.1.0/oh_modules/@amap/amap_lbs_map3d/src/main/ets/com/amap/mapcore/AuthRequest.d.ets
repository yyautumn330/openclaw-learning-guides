// @keepTs
// @ts-nocheck
import { x102 } from "../trace/core/AbstractBasicHandler";
import HashMap from "@ohos.util.HashMap";
/**
 * 专业版鉴权请求
 */
export declare class a102 extends x102<string, AuthResult> {
    private h103;
    private i103;
    constructor(context: Context, e103: string, f103?: string, g103?: boolean);
    protected j103(): string;
    protected k103(b103: string): Promise<AuthResult | undefined>;
    protected getUri(): string;
    m103(): HashMap<string, string>;
}
export declare class AuthResult {
    errorCode: number;
    errorMessage: string;
    errorDetail: string;
    o101: boolean;
}
