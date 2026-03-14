// @keepTs
// @ts-nocheck
import { v72 } from "./StyleItem";
import HashMap from "@ohos.util.HashMap";
export declare class y72 {
    private styles;
    /** 如果出现附加的任务，可以放在这里作为表示，比如解析完成之后还需要下载纹理 */
    private task?;
    private m227?;
    /**
     * 保存所有样式状态，用作中间处理
     * @return
     */
    getStyles(): HashMap<number, v72>;
    /**
     * 结构化结果，供外部调用
     * 在解析完成之后掉员工
     * @return
     */
    p226(): v72[] | undefined;
    t89(): v72[] | undefined;
    getTask(): ESObject;
    n227(task: ESObject): void;
}
