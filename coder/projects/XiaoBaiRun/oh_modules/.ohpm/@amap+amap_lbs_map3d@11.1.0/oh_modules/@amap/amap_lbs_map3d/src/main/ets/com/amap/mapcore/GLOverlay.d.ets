// @keepTs
// @ts-nocheck
import { p66 } from "./interface/IAMapNativeDelegate";
export declare abstract class i73 {
    t8: number;
    w132: p66;
    f93: number;
    q156: boolean;
    r156: boolean;
    m146: number;
    s156: number;
    constructor(o156: number, p156: p66, code: number);
    a71(): number;
    getCode(): number;
    getType(): number;
    t156(): number;
    removeItem(index: number): void;
    g107(): void;
    getSize(): number;
    setVisible(visible: boolean): void;
    isVisible(): boolean;
    setClickable(click: boolean): void;
    isClickable(): boolean;
    clearFocus(): void;
    v156(): boolean;
    w156(flag: boolean): void;
    /**
     * 设置overlay最小显示级别
     *
     * @param level
     */
    x156(level: number): void;
    /**
     * 设置overlay最大显示级别
     *
     * @param level
     */
    y156(level: number): void;
    /**
     * 设置overlay显示级别
     *
     * @param value
     */
    z156(value: number): void;
    b157(value: number): void;
    c157(): number;
    d157(value: number): void;
    i107(): void;
    e157(flag: boolean): void;
}
export declare class x145 {
    /**
     * 覆盖物类型-导览箭头
     */
    static f157: number;
    /**
     * 覆盖物类型-路况放大图
     */
    static l146: number;
    /**
     * 引擎RouteOverlay
     */
    static g157: number;
    constructor(m156: number);
    private id;
    getId(): number;
}
