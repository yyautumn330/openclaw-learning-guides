// @keepTs
// @ts-nocheck
import { g60 } from '../../web/IAMapJsInterceptor';
import { m110 } from '../IAMapJsCall';
export interface x108 {
    v63(aMapJsInterceptor: g60): void;
    loadUrl(url: string): void;
    runJavaScript(url: string, callback: m110<string>): void;
    registerJavaScriptProxy(object: object, name: string, methodList: Array<string>): void;
    onInterceptRequest(request: WebResourceRequest): WebResourceResponse | null;
    v14(): WebviewController;
}
