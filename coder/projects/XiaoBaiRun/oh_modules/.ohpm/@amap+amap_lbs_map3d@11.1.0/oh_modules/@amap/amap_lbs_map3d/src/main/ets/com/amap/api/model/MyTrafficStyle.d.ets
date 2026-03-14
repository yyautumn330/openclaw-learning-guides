// @keepTs
// @ts-nocheck
/**
 * 路况拥堵情况对应的颜色<br>
 * 默认颜色分布为：<br>
 * 畅通： 0xff00a209<br>
 * 缓慢： 0xffff7508<br>
 * 拥堵： 0xffea0312<br>
 * 严重拥堵： 0xff92000a<br>
 * @author zxy
 */
export declare class l39 {
    /**极度畅通*/
    private s39;
    /**畅通*/
    private t39;
    /**：缓慢*/
    private u39;
    /**：拥堵*/
    private v39;
    /**：严重拥堵*/
    private w39;
    /**路况线宽系数*/
    private ratio;
    /**
     * 路况底色，开启路况时默认道路颜色会变成白色
     * 配置之后，开启路况时所有道路颜色都会变成此颜色
     * 注：需要配合自定义样式使用
     */
    private x39;
    /**
     * 返回行驶极度畅通路段的标记颜色。默认颜色为0xff179F55。
     *
     * @return 行驶极度畅通路段的标记颜色
     * @since V9.7.0
     */
    y39(): number;
    /**
     * 设置行驶极度畅通路段的标记颜色。
     *
     * @param extremelySmoothColor 颜色值。
     * @since V9.7.0
     */
    z39(r39: number): void;
    /**
     * 返回行驶畅通路段的标记颜色。默认颜色为0xff00a209。
     *
     * @return 行驶畅通路段的标记颜色。
     * @since V2.1.3
     */
    a40(): number;
    /**
     * 设置行驶畅通路段的标记颜色。
     *
     * @param smoothColor 颜色值。
     * @since V2.1.3
     */
    b40(q39: number): void;
    /**
     * 返回行驶缓慢路段的标记颜色。默认颜色为0xffff7508。
     *
     * @return 行驶缓慢路段的标记颜色。
     * @since V2.1.3
     */
    c40(): number;
    /**
     * 设置行驶缓慢路段的标记颜色。
     *
     * @param slowColor 颜色值。
     * @since V2.1.3
     */
    d40(p39: number): void;
    /**
     * 返回行驶拥堵路段的标记颜色。默认颜色为0xffea0312。
     *
     * @return 行驶拥堵路段的标记颜色。
     * @since V2.1.3
     */
    e40(): number;
    /**
     * 设置行驶拥堵路段的标记颜色。
     *
     * @param congestedColor 颜色值。
     * @since V2.1.3
     */
    f40(o39: number): void;
    /**
     * 返回行驶严重拥堵路段的标记颜色。默认颜色为0xff92000a。
     *
     * @return 行驶严重拥堵路段的标记颜色。
     * @since V2.1.3
     */
    g40(): number;
    /**
     * 设置行驶严重拥堵路段的标记颜色。
     *
     * @param seriousCongestedColor 颜色值。
     * @since V2.1.3
     */
    h40(n39: number): void;
    /**
     * 获取路况线宽比率系数，默认线宽是0.8。
     * @return
     * @exclude javadoc中不显示
     */
    i40(): number;
    /**
     * 设置线宽比率系数，默认线宽是0.8
     * @param ratio
     * @exclude javadoc中不显示
     */
    j40(ratio: number): void;
    /**
     * 获取开启路况时路线颜色
     * @since 6.4.0
     * @return 颜色
     * @exclude javadoc中不显示
     */
    k40(): number;
    /**
     * 设置开启路况时 路线颜色
     *  需要配合自定义样式使用，需要在开启自定义样式之前调用，否则首次自定义样式不会生效
     * @param trafficRoadBackgroundColor 颜色
     * @since 6.4.0
     * @exclude javadoc中不显示
     */
    l40(m39: number): void;
}
