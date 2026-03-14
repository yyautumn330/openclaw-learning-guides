// @keepTs
// @ts-nocheck
/**
 * 本地离线数据校验
 *
 * @author zxy94400
 */
export declare class b201 {
    private context;
    private b195?;
    constructor(context: Context);
    run(): void;
    /**
     * 从本地文件中读取已下载信息
     *
     * @param file
     * @return UpdateItem
     */
    private o192;
    private z204;
    /**
     * 从本地的记录文件中读取已下载信息
     * @param cityfile 城市的拼音
     *         由于全国概要图名称发生改变，所有检查的时候需要在这里处理一下 文件名为 quanguo.dat  拼音为 quanguogaiyaotu
     * @return
     */
    private g205;
    private f205;
    /**
     * 查找本地vmap 和 map文件夹，读取所有本地已有的离线数据列表
     * map文件夹中为AE8 数据，如果有AE8数据时，直接以AE8为准，此处只保存了文件名称，替换即表示不用重复添加
     * @return
     */
    private c205;
    /**
     * 星云版本检查本地已下载文件
     * 离线地图格式  a0/m1.ans , a1/m1.ans a1/m3.ans ,  a2/m1.ans a2/m3.ans
     * @param downloadedfiles
     * @param mode
     */
    private d205;
    /**
     * 查找本地VMAP2文件夹，读取所有本地下载中的离线数据列表
     * @return
     */
    private e205;
}
