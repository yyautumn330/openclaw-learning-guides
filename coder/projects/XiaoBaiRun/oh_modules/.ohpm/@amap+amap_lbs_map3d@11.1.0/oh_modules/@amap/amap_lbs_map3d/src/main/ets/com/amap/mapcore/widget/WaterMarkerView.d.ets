// @keepTs
// @ts-nocheck
import { Point } from '../../api/model/Point';
import { k109 } from '../interface/bridge/IWaterMarkerViewBridge';
import { p66 } from '../interface/IAMapNativeDelegate';
import drawing from "@ohos.graphics.drawing";
export declare class b73 {
    private n281;
    private o281;
    private p281;
    private logoPosition;
    private left;
    private top;
    private static readonly q281;
    private static readonly r281;
    private static readonly s281;
    private viewMode;
    private marginLeft;
    private marginBottom;
    private k57;
    private t281;
    private context;
    private isLogoEnable;
    private w109;
    private l2;
    private z280?;
    private u281;
    private v281;
    private w281?;
    private x281?;
    private y281?;
    private z281?;
    /**
     * 防止在地图初始化完成前使用组合设置logo位置,出现部分无效的问题
     * 所以记录左边距和顶边距
     */
    private a282;
    private b282;
    private c282;
    private bitmap?;
    h177(): void;
    constructor(context: Context, k281: p66, l281: k109);
    private d282;
    /**
     * 修改图片，需要调refresh才会生效
     * @param isBlack
     */
    z279(f281: boolean): void;
    getPosition(): Point;
    setLogoPosition(position: number): void;
    setLogoBottomMargin(e281: number): void;
    setLogoLeftMargin(pixels: number): void;
    getLogoMarginRate(type: number): number;
    setLogoMarginRate(type: number, rate: number): void;
    /**
     * 更新绘制信息
     */
    refresh(): void;
    f282(): PixelMap | undefined;
    private e282;
    private h282;
    private g282;
    /**
     * 设置定义的logo图标
     * @param path 路径
     * @param type 白天还是黑夜
     */
    x279(path: string, type: number): void;
    /**
     * 设置是否展示logo
     * @param enable
     */
    s49(enable: boolean): void;
    y279(enable: boolean): void;
    /**
     * 当前是否处于黑夜模式
     * @return true 表示是
     */
    a280(): boolean;
    onDraw(canvas: drawing.Canvas): void;
}
