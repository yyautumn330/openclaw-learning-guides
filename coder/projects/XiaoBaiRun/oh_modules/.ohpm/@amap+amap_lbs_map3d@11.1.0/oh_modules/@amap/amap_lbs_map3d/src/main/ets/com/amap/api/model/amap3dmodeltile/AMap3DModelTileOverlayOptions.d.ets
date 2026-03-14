// @keepTs
// @ts-nocheck
import { BaseOptions } from "../../../../../../../../Index";
import ArrayList from "@ohos.util.ArrayList";
import { TileProvider } from "../TileProvider";
import { e16 } from "../TileProviderInner";
import { n16 } from "./AMap3DTileBuildingColor";
import { o16 } from "./AMap3DTileBuildingMaterialOptions";
/**
 *
 * 3DTile覆盖物参数配置类
 * @since v9.6.0
 *
 * @exclude javadoc中不显示 后续开放
 */
export declare class f16 extends BaseOptions {
    private q16?;
    private tileProvider?;
    private zIndex;
    private visible;
    private r16;
    private s16;
    constructor();
    /**
     * 设置数据提供
     * @since v9.6.0
     * @exclude javadoc中不显示 后续开放
     * @param provider
     */
    t16(p16: TileProvider): void;
    m16(): e16 | undefined;
    u16(colors: ArrayList<n16>): void;
    v16(): ArrayList<n16>;
    w16(options: ArrayList<o16>): void;
    x16(): ArrayList<o16>;
    /**
     * 设置zindex
     *
     * @param zIndex
     */
    setZIndex(zIndex: number): void;
    /**
     * 获取zindex
     *
     * @return
     */
    getZIndex(): number;
    /**
     * 设置是否可见
     *
     * @param visible
     */
    setVisible(visible: boolean): void;
    /**
     * 获取是否可见
     *
     * @return
     */
    isVisible(): boolean;
}
