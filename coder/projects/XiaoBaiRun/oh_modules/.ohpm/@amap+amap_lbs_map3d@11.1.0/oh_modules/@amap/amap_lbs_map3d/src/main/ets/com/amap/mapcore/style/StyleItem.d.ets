// @keepTs
// @ts-nocheck
/**
 * 自定义样式子类
 * @since V2.0.0
 */
import { f218 } from './StyleElement';
export declare class v72 {
    private d219;
    mainKey: number;
    subKey: number[];
    private e219;
    constructor(typeId: number);
    /**
     * 获取属性列表
     * @return
     */
    f219(): f218[] | undefined;
    get(elementId: number): f218;
    put(elementId: number, c219: f218): void;
    /**
     * 是否有效
     * @return
     */
    isValid(): boolean;
    toString(): string;
}
