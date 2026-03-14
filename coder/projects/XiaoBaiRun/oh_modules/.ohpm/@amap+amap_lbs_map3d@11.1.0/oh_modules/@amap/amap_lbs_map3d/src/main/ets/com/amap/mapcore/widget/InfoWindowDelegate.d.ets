// @keepTs
// @ts-nocheck
/**
 * 统一管理对外的InfoWindow
 *
 */
import { BaseOverlay } from '../../api/model/BaseOverlay';
import { n60 } from './IInfoWindow';
import { o60 } from './IInfoWindowAction';
export declare class p60 implements n60 {
    private static readonly y274;
    /**
     * 是否使用默认InfoWindow样式
     */
    private z274;
    /**
     * 默认InfoWindow样式
     */
    protected mContext: Context;
    private a275?;
    private b275?;
    private n51?;
    private c275?;
    constructor(context: Context);
    o274(): CustomBuilder | undefined;
    setInfoWindowAdapter(adapter: CustomBuilder, isDefault?: boolean): void;
    w63(x274: o60): void;
    k89(w274: o60): void;
    /**
     * 默认的InfoWindow样式
     */
    /**
     * 默认的InfoWindow样式
     */
    p274(): boolean;
    /**
     * 更新默认InfoWindow控件的内容
     *
     * @param title
     * @param snippet
     */
    d275(title: string, snippet: string): void;
    /**
     * 设置自定义InfoWindow样式
     *
     * @param adapter
     */
    /**
     * 销毁资源
     */
    destroy(): void;
    /**
     * 收集InfoWindow信息,仅针对自定义的InfoWindow
     * 使用默认的Infowindow通过Marker的title和snippet收集
     * @param view
     * @param marker
     */
    redrawInfoWindow(): void;
    /**
     * 确定是使用view来支持InfoWindow还是使用OPengl来支持InfoWindow
     *
     * @return
     */
    e275(): o60 | undefined;
    o97(e: GestureEvent): boolean;
    t97(e: GestureEvent): BaseOverlay | undefined;
    hideInfoWindow(): void;
    showInfoWindow(marker: BaseOverlay): void;
    isInfoWindowShown(): boolean;
}
