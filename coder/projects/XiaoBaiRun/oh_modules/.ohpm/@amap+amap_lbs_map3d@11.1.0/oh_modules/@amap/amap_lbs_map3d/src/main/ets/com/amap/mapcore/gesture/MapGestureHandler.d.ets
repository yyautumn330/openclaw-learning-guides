// @keepTs
// @ts-nocheck
import { IAMap } from '../interface/IAMap';
export declare class q129 {
    static readonly s131 = 0.02;
    static readonly t131 = 0;
    static readonly u131 = 1;
    static readonly v131 = 0.1;
    static readonly w131 = 1.5;
    static readonly x131 = 0;
    static readonly y131 = 5;
    static readonly z131 = 0;
    static readonly a132 = 0;
    static readonly b132 = 0;
    static readonly c132 = 0;
    static readonly d132 = 0.1;
    static readonly e132 = 5;
    static readonly f132 = 2;
    static readonly g132 = 65;
    static readonly h132 = 5;
    static readonly i132 = 10;
    static readonly j132 = 10;
    static readonly k132 = 800;
    static readonly l132 = 500;
    static readonly m132 = 250;
    static readonly n132 = 0.0001;
    static readonly o132 = 3;
    /**  手势埋点类型定义 **/
    /**  双指放大 **/
    static readonly p132: number;
    /**  双指缩小 **/
    static readonly q132: number;
    /**  单指单击放大 **/
    static readonly r132: number;
    /**  双指点击缩小 **/
    static readonly s132: number;
    /**  拖动平移 **/
    static readonly t132: number;
    /**  旋转地图 **/
    static readonly u132: number;
    /**  双指拖动切换 3D **/
    static readonly v132: number;
    protected w132: IAMap;
    protected mContext: Context;
    private x132;
    private y132;
    private z132;
    private a133;
    private b133;
    private c133;
    /**  双指点击缩放标志 **/
    private d133;
    private width;
    private height;
    private e133;
    private f133;
    private g133;
    private h133;
    private i133;
    private j133;
    private k133;
    private l133;
    private m133;
    private n133;
    private o133;
    private p133;
    private q133;
    private r133;
    private s133;
    private t133;
    private u133;
    private v133;
    private w133;
    private x133;
    private y133;
    private z133;
    private a134;
    private b134;
    private c134;
    private d134;
    private e134;
    private f134;
    private g134;
    private h134;
    private i134;
    private j134;
    private k134;
    private l134;
    private m134;
    private n134;
    private o134;
    private p134;
    private q134;
    private r134;
    private s134;
    private t134;
    private u134;
    private v134;
    private w134?;
    private x134;
    private y134;
    constructor(r131: IAMap, context: Context);
    l130(state: number, event: GestureEvent): void;
    private z134;
    private onMove;
    private a135;
    m130(state: number, event: GestureEvent): void;
    private e135;
    private f135;
    private g135;
    n130(state: number, event: GestureEvent): void;
    private l135;
    private m135;
    private n135;
    j130(event: TouchEvent): void;
    /**
     * 识别俯仰手势
     * 目前手势识别顺序：先识别俯仰，后识别旋转和缩放
     * 备注：
     * 1、为了让俯仰先识别，将俯仰手势触发放在onTouch事件中
     * 2、如果俯仰识别失败，则等待旋转或者缩放的系统手势事件
     * 3、如果旋转或者缩放手势事件识别成功后，则不进行俯仰手势的识别
     */
    p135(event: TouchEvent): void;
    reset(): void;
    private r135;
    private t135;
    private s135;
    private q135;
}
