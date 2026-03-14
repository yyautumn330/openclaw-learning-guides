// @keepTs
// @ts-nocheck
/**
 * 管理自定义样式逻辑
 * @since 1.0.0
 */
import { CustomMapStyleOptions } from '../api/model/CustomMapStyleOptions';
import { IAMap } from './interface/IAMap';
import { x52 } from './interface/IAMapJsCall';
import * as AMap from '../api/AMap';
import { a53 } from './style/CustomStyleTask';
export declare class f53 implements a53 {
    private static readonly j55;
    private static readonly k55;
    private static readonly l55;
    private static readonly m55;
    private static readonly n55;
    private static readonly o55;
    private static readonly p55;
    private static readonly q55;
    private static readonly r55;
    private static readonly s55;
    private static readonly t55;
    private static readonly u55;
    private static readonly v55;
    private static readonly w55;
    private static readonly x55;
    private static readonly y55;
    private static readonly z55;
    private static readonly a56;
    private static readonly b56;
    private static readonly c56;
    private static readonly d56;
    private readonly e56;
    private l2;
    private f56;
    private g56;
    private context;
    private h56;
    private i56;
    /**
     * 或者在线自定义样式
     */
    private j56?;
    private k56?;
    private l56;
    private m56;
    private n56;
    private o56;
    private p56;
    private q56;
    private r56?;
    private s56?;
    private t56;
    /**
     * 是否是海外样式
     * 1、在线拉取需要获取海外样式
     * 2、恢复模式样式，需要使用海外版本默认样式
     */
    private u56;
    /**
     * 记录是否将自定义样式设置为引擎
     */
    private v56;
    /**
     * 记录是否需要更新地图类型
     */
    private w56;
    private x56;
    /**
     * 标准全量样式
     */
    private y56?;
    /**
     * 标准样式
     */
    private z56?;
    /**
     * 标准 背景文件
     */
    private a57?;
    /**
     * 标准 纹理文件
     */
    private b57?;
    /**
     * 使用纹理的全量样式
     */
    private c57?;
    /**
     * 路况纹理
     */
    private d57?;
    /**
     * 是否有使用扩展自定义样式
     */
    private e57;
    private f57?;
    private g57;
    private h57;
    private i57;
    /**
     *
     * @param isAbroadStyle 在线拉取的时候是否获取海外mapbox样式
     * @param aMapJsCall
     */
    constructor(g55: IAMap, context: Context, h55: boolean, i55: x52 | undefined);
    k57(): boolean;
    onComplete(data: Uint8Array, a55: number): Promise<void>;
    t57(data: Uint8Array, z54: number): void;
    /**
     * 更新样式，建议在绘制线程调用
     */
    u57(): Promise<void>;
    private p58;
    /**
     * 检查样式文件是否是旧版的
     * @param dataOri
     * @return
     * fixme 新版样式没有校验的逻辑，临时添加此判断，后续希望引擎能给出方案
     */
    private k58;
    /**
     * 恢复额外设置的样式
     */
    private d58;
    /**
     * 默认纹理里面内容是 1~20无效的png
     * 设置的目的是冲掉，引擎对于纹理的缓存
     * todo 如果后续有更好的方案，需要进行修改，比如删除缓存
     * <p>
     * 重置纹理
     */
    private c58;
    private b58;
    y58(option: CustomMapStyleOptions, listener?: AMap.OnCustomMapStyleFailListener): void;
    private g59;
    private o58;
    private n59;
    /**
     * 设置网格线
     * @param backgroundLineVisibile
     */
    private j59;
    private m59;
    /**
     * 设置地图模式。
     *
     * @param type 地图模式： MAP_TYPE_NORMAL：普通地图，值为1；<br>
     *             MAP_TYPE_SATELLITE：卫星地图，值为2；<br>
     *             MAP_TYPE_NIGHT 夜景图模式，值为3；<br>
     *             MAP_TYPE_NAVI 导航模式，值为4；<br>
     *             MAP_TYPE_BUS 公交模式，值为5；<br>
     *             MAP_TYPE_NAVI_NIGHT 导航夜间模式，值为6；
     * @since 1.0.0
     */
    setMapType(mapType: AMap.MapType): void;
    s59(): AMap.MapType;
    destroy(): void;
    /**
     * 自定义样式的如果切换到标准模式可以需要调用此方法恢复样式
     */
    reset(): void;
    /**
     * 重置options所有属性，不包含enable
     */
    private f59;
    a58(): boolean;
    /**
     * 重新加载样式，比如鉴权失败了需要去掉专业版样式
     */
    t59(): void;
    /**
     * 通过styleid下载样式回调
     * @param listener
     */
    u59(listener: g53): void;
}
export interface g53 {
    /**
     * 下载完成
     * @param data 二进制数据
     */
    s57: (data: Uint8Array) => void;
}
