// @keepTs
// @ts-nocheck
import { m110 } from '../interface/IAMapJsCall';
import { x108 } from '../interface/bridge/IWebViewBridge';
import webview from '@ohos.web.webview';
import { g60 } from '../web/IAMapJsInterceptor';
export declare class f12 implements x108 {
    private s110;
    private h63?;
    constructor();
    v63(r110: g60): void;
    v14(): webview.WebviewController;
    loadUrl(url: string): void;
    runJavaScript(url: string, callback: m110<string>): void;
    registerJavaScriptProxy(object: object, name: string, methodList: string[]): void;
    onInterceptRequest(request: WebResourceRequest): WebResourceResponse | null;
}
