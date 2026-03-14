// @keepTs
// @ts-nocheck
import { PromptAction as PromptAction } from "@ohos.arkui.UIContext";
import { y47 } from "../../../mapcore/offlineMap/db/OfflineDBCreator";
import { OfflineMapProvince } from "../../maps/offlinemap/OfflineMapProvince";
import { OfflineMapCity } from "../../maps/offlinemap/OfflineMapCity";
import { OfflineMapManager } from "../../maps/offlinemap/OfflineMapManager";
@Component
export declare struct OfflineMapPage {
    @State
    cityListIsOpen: boolean;
    @State
    downloadManagerIsOpen: boolean;
    @State
    isOpen: boolean[];
    @State
    downloadIsOpen: boolean[];
    @State
    showSearchList: boolean;
    @State
    provinceList: OfflineMapProvince[];
    @State
    isRefresh: boolean;
    @State
    searchList: OfflineMapCity[];
    amapManager: OfflineMapManager | undefined;
    scroller: Scroller;
    searchScroller: Scroller;
    context: Context;
    uiContext: UIContext;
    promptAction: PromptAction;
    ofOfflineDBCreator?: y47;
    private lastStatus;
    private lastUpdateTime;
    build(): void;
    aboutToAppear(): void;
    onBackPress(): boolean | void;
    onDownload(status: number, n48: number, name: string): void;
    onCheckUpdate(m48: boolean, name: string): void;
    onRemove(success: boolean, name: string, describe: string): void;
    onVerifyComplete(): void;
    /**
     * sdk内部存放形式为<br>
     * 省份 - 各自子城市<br>
     * 北京-北京<br>
     * ...<br>
     * 澳门-澳门<br>
     * 概要图-概要图<br>
     * <br>
     * 修改一下存放结构:<br>
     * 概要图-概要图<br>
     * 直辖市-四个直辖市<br>
     * 港澳-澳门香港<br>
     * 省份-各自子城市<br>
     */
    private initProvinceListAndCityMap;
    initDownloadedList(): void;
    aboutToDisappear(): void;
}
