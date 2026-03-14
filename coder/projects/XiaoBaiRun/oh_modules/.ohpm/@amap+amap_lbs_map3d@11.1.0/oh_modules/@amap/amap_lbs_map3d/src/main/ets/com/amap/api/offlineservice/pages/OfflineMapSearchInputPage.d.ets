// @keepTs
// @ts-nocheck
import { PromptAction as PromptAction } from "@ohos.arkui.UIContext";
import { OfflineMapCity } from '../../maps/offlinemap/OfflineMapCity';
import { OfflineMapProvince } from '../../maps/offlinemap/OfflineMapProvince';
@Component
export declare struct x47 {
    @State
    text: string;
    @State
    inputClean: boolean;
    @Link
    provinceList: OfflineMapProvince[];
    @Link
    showSearchList: boolean;
    @Link
    searchList: OfflineMapCity[];
    uiContext: UIContext;
    promptAction: PromptAction;
    @State
    inputWidth: string;
    build(): void;
}
