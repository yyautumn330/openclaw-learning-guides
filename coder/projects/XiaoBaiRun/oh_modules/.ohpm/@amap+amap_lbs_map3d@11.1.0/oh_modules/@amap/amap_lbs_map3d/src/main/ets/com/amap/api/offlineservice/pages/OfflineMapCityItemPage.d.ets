// @keepTs
// @ts-nocheck
import { PromptAction as PromptAction } from "@ohos.arkui.UIContext";
import { OfflineMapCity } from "../../maps/offlinemap/OfflineMapCity";
import { OfflineMapManager } from "../../maps/offlinemap/OfflineMapManager";
@Component
export declare struct u47 {
    uiContext: UIContext;
    promptAction: PromptAction;
    context?: Context;
    @ObjectLink
    city: OfflineMapCity;
    @Prop
    type: number;
    amapManager: OfflineMapManager | undefined;
    @Link
    isRefresh: boolean;
    processSize: number;
    build(): void;
}
