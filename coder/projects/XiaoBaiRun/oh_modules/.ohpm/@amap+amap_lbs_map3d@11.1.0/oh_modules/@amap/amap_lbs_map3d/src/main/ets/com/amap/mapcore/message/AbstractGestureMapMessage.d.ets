// @keepTs
// @ts-nocheck
/**
 *手势事件基类
 */
import { Point } from '../../api/model/Point';
import { x59 } from '../interface/IGLMapState';
import { o130 } from './AbstractMapMessage';
export declare abstract class p72 extends o130 {
    /** 默认为地图的宽高 **/
    width: number;
    height: number;
    /** 是否以地图中心点作为缩放中心点 **/
    isGestureScaleByMapCenter: boolean;
    w92: boolean;
    a96: number;
    b96: number;
    private state;
    /**
     * 获取消息类型
     * @return 消息类型
     */
    abstract getType(): number;
    constructor(state: number);
    setState(state: number): void;
    /**重置一些状态，比如宽高anchor等，新增统一属性时也需要添加到这个reset中，避免重复使用对象时，参数出现影响 **/
    reset(): void;
    /**
     * 将消息处理成最终地图状态
     * @param proj 地图状态
     */
    abstract y111(b177: x59): void;
    protected c177(a177: x59, screenX: number, screenY: number, result: Point): void;
    protected b113(y176: x59, x: number, y: number): Point;
    t152(): number;
}
