// @keepTs
// @ts-nocheck
import { IndoorBuildingInfo } from "./IndoorBuildingInfo";
export declare class IndoorFloorSwitchAdapter {
    mIndoorBuildingInfo: IndoorBuildingInfo;
    offset: number;
    visible: Visibility;
    setVisible(visible: boolean): void;
    isVisible(): boolean;
    setItems(q34: string[]): void;
    setSelection(p34: number): void;
    OnIndoorBuilding(o34: IndoorBuildingInfo): void;
}
