// @keepTs
// @ts-nocheck
import AbilityConstant from "@ohos.app.ability.AbilityConstant";
import { Configuration as Configuration } from "@ohos.app.ability.Configuration";
import UIAbility from "@ohos.app.ability.UIAbility";
import Want from "@ohos.app.ability.Want";
import window from "@ohos.window";
export default class w8 extends UIAbility {
    onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void;
    onDestroy(): void;
    onWindowStageCreate(windowStage: window.WindowStage): void;
    onWindowStageDestroy(): void;
    onForeground(): void;
    onBackground(): void;
    /**
     * 关闭当前页面,并传递数据到前一个page
     */
    x8(): void;
    onClick(): void;
    y8(newConfig: Configuration): void;
    onConfigurationUpdate(newConfig: Configuration): void;
    z8(): boolean;
    protected onPause(): void;
    protected onResume(): void;
    protected onStart(): void;
    protected onStop(): void;
    a9(): void;
}
