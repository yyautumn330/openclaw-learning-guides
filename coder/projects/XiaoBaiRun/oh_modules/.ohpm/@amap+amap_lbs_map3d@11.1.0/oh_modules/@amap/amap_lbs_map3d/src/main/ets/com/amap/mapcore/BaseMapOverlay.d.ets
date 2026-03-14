// @keepTs
// @ts-nocheck
import { i73 } from './GLOverlay';
import { IAMap } from './interface/IAMap';
import { BitmapDescriptor } from '../api/model/BitmapDescriptor';
import { p66 } from './interface/IAMapNativeDelegate';
/**
 * @author qianweiwang
 *
 * @param <T>
 *            几何图形
 * @param <E>
 *            item属性数据
 * 用法：
 * @2014-2-25
 */
export declare abstract class j73<T extends i73, E extends object> {
    private static z3;
    /**
     * 几何图层
     *
     * 一个地图图层 要包含几何数据和属性数据
     */
    protected z106: T | null;
    /**
     * 属性数据
     */
    protected a107: Array<E>;
    /**
     * 需要获取资源 或者动态生成图片时会用
     */
    protected mContext: Context | null;
    protected b107: p66 | null;
    /**  默认主图 */
    protected f93: number;
    /**
     * 焦点索引
     */
    protected d107: number;
    /**
     * 初始化几何图层
     */
    abstract e107(): void;
    /**
     * 添加
     * @param item item
     */
    abstract addItem(item: E): void;
    /**
     *
     * onresume的时候 重新putx需要的marker
     * @param bitmap 图片
     */
    abstract w89(bitmap: BitmapDescriptor): void;
    constructor(x106: number, context: Context, y106: IAMap);
    f107(): T | null;
    abstract setVisible(visible: boolean): void;
    isVisible(): boolean;
    setClickable(click: boolean): void;
    isClickable(): boolean;
    getSize(): number;
    clear(): boolean;
    g107(): boolean;
    clearFocus(): void;
    getItem(position: number): E | null;
    h107(position: number): void;
    removeItem(item: E): void;
    getItems(): E[];
    i107(): void;
}
