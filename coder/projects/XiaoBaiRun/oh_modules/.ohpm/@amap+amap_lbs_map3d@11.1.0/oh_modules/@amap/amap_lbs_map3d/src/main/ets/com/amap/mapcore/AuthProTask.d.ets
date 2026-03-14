// @keepTs
// @ts-nocheck
import { p66 } from "./interface/IAMapNativeDelegate";
/**
 * 专业版功能鉴权任务
 */
export declare class x72 {
    private g102;
    private h102;
    private static i102;
    private static j102;
    private static k102;
    private l102?;
    private readonly m102;
    private n102?;
    private mContext;
    private o102;
    constructor(context: Context, w342: p66);
    /**
     * 初始化状态值
     */
    r102(): void;
    start(): void;
    /**
     * 专业版鉴权，访问校验接口<br>
     * 1、每隔固定的时候请求一次校验接口 {@link #AUTH_PERIOD}<br>
     * 2、如果通过了则停止校验<br>
     * 3、如果失败超过一定次数则告知校验失败 {@link #MAX_AUTH_COUNT}<br>
     */
    private s102;
    /**
     * 如果鉴权失败，默认30s暂停地图绘制
     */
    private q102;
}
