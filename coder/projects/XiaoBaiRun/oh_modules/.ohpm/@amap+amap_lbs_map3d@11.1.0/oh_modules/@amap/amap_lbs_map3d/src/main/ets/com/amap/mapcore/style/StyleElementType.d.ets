// @keepTs
// @ts-nocheck
/**
 *
 * 每一项样式配置的具体类型
 * 其中包含  颜色、边框颜色、是否显示等信息
 *
 * 其中枚举数字 和c++层代码对应，如果要修改 c++层也需要修改
 *
 */
export declare class j218 {
    private static m218;
    private n218;
    private o218;
    static p218(): void;
    y218(): string;
    z218(): number;
    /**
     * type 对应引擎的 如果要修改
     * typedef enum {
     kMapStyleSetType_labelFill = 0,
     kMapStyleSetType_labelStroke,
     kMapStyleSetType_geometryStroke,
     kMapStyleSetType_geometryFill,
     kMapStyleSetType_backgroundFill,
     kMapStyleSetType_visible
     } eMapStyleSetType；
     通过int 数字来对应
     * @param elementTypeName
     * @return
     */
    static a219(k218: string): number;
}
