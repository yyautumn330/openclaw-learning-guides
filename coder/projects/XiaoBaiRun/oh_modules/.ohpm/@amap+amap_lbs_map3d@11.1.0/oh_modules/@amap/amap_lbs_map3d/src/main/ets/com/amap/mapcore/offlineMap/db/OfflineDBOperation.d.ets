// @keepTs
// @ts-nocheck
import { a25 } from "../UpdateItem";
import ArrayList from "@ohos.util.ArrayList";
import { l186 } from "./DBOperation";
export declare class c191 {
    private static instance?;
    private static k192?;
    private mContext;
    private e187?;
    static c191: Promise<l186 | undefined>;
    static getInstance(context: Context): Promise<c191>;
    private constructor();
    private l192;
    /**
     * 检查DBOperation是否为空，没有就获取一个 从新获取还为空 返回false
     */
    private m192;
    /**
     * 获取数据库中已下载的离线数据列表
     *
     * @return
     */
    n192(): ArrayList<a25>;
    /**
     * 从数据表中查询得到UpdateItem
     *
     * @param adCode
     * @return
     */
    o192(b192: string): a25 | undefined;
    private h187;
    /**
     * 记录下载信息
     *
     * @param updateItem
     */
    insert(t191: a25): void;
    /**
     * 插入每个城市的离线数据的存储位置
     * 会将传入的目录进行";"分隔，然后存放到本地数据库中
     *
     * @param adCode 城市的adcode
     * @param dataFiles 存放目录，多个目录用";" 进行分隔
     */
    private p192;
    /**
     * 根据adCode获取某城市的本地文件存放路径
     *
     * @param adCode
     * @return
     */
    q192(l191: string): ArrayList<String>;
    /**
     * 把List<DTFileInfo>中的FilePath 取出来形成一个list
     *
     * @param lists
     * @return
     */
    private r192;
    clear(): void;
    /**
     * 删除该城市的所有信息 三个表中的都删除
     *
     * @param object
     */
    delete(object: string | a25): void;
    /**临时使用一下*/
    s192(e191: string, f191: number, g191: number, h191: number, i191: number): void;
    /**
     * 获取对应pinyin的版本号
     *
     * @param mAdcode
     * @return 如果没有返回null
     */
    getVersion(d191: string): string | undefined;
    close(): void;
}
