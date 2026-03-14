// @keepTs
// @ts-nocheck
import { RoutePlanResult } from "./RoutePlanResult";
import ArrayList from "@ohos.util.ArrayList";
import { DrivePlanQuery } from "./DrivePlanQuery";
import { DrivePlanPath } from "./DrivePlanPath";
import { TimeInfo } from "./TimeInfo";
export declare class DriveRoutePlanResult extends RoutePlanResult {
    private d69;
    private d76;
    private e76?;
    getPaths(): ArrayList<DrivePlanPath>;
    setPaths(c76: ArrayList<DrivePlanPath>): void;
    getTimeInfos(): ArrayList<TimeInfo>;
    setTimeInfos(b76: ArrayList<TimeInfo>): void;
    /**
     * 设置结果对应的查询参数。
     * @param driveQuery 查询参数。
     * @since V6.9.0
     * @exclude javadoc中不显示。
     */
    f76(z75: DrivePlanQuery): void;
}
