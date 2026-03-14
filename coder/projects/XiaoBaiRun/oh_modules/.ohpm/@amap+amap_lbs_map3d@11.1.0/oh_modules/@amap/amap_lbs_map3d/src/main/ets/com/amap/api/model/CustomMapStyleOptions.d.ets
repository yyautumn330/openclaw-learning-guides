// @keepTs
// @ts-nocheck
/**
 *
 * 自定义样式属性集
 * @since 1.0.0
 */
export declare class CustomMapStyleOptions {
    private styleId;
    private enable;
    private v25;
    private w25?;
    private x25;
    private y25?;
    private z25?;
    private a26;
    private b26;
    private c26?;
    /**
     *
     * 设置的底图自定义样式对应的styleID
     * @return 设置底图自定义样式对应的styleID
     * @since 1.0.0
     */
    getStyleId(): string;
    /**
     * 设置底图自定义样式对应的styleID，id从官网获取。
     * 设置了之后官网修改会同步展示到客户端（客户端下次启动时生效）
     * @param styleId 样式id
     * @return 修改样式属性后的对象
     * @since 1.0.0
     *
     */
    setStyleId(styleId: string): CustomMapStyleOptions;
    /**
     * 是否开启底图自定义样式， 默认为开启
     *
     * @return 是否开启底图自定义样式， 默认为开启
     * @since 1.0.0
     */
    isEnable(): boolean;
    /**
     *
     * 设置是否开启底图自定义样式， 默认为开启
     * @return 修改样式属性后的对象
     * @since 1.0.0
     */
    setEnable(enable: boolean): CustomMapStyleOptions;
    /**
     * 自定义样式路径
     *
     * @return 自定义样式路径
     * @since 2.2.2
     */
    getStyleDataPath(): string;
    /**
     * 自定义样式路径
     *
     * @return 修改样式属性后的对象
     * @since 2.2.2
     */
    setStyleDataPath(u25: string): CustomMapStyleOptions;
    /**
     *  自定义样式纹理路径
     *
     * @return 自定义样式纹理路径
     * @since 2.2.2
     */
    getStyleTexturePath(): string;
    /**
     * 自定义样式纹理路径
     *
     * @return 修改样式属性后的对象
     * @since 2.2.2
     */
    setStyleTexturePath(t25: string): CustomMapStyleOptions;
    /**
     * 自定义样式二进制，使用二进制可以更快加载出自定义样式
     *
     * @return 自定义样式二进制
     * @since 2.2.2
     */
    getStyleData(): Uint8Array | undefined;
    /**
     * 自定义样式二进制，使用二进制可以更快加载出自定义样式，如果设置了则不会读取{@link #setStyleDataPath(String)}
     *
     * @return 修改样式属性后的对象
     * @since 2.2.2
     */
    setStyleData(s25: Uint8Array | undefined): CustomMapStyleOptions;
    /**
     * 自定义样式纹理二进制，使用二进制可以更快加载出自定义样式
     *
     * @return 自定义样式纹理二进制
     * @since 2.2.2
     */
    getStyleTextureData(): Uint8Array | undefined;
    /**
     *
     * 自定义样式纹理二进制，使用二进制可以更快加载出自定义样式，如果设置了则不会读取{@link #setStyleTexturePath(String)} }
     * @return 修改样式属性后的对象
     * @since 2.2.2
     */
    setStyleTextureData(r25: Uint8Array | undefined): CustomMapStyleOptions;
    /**
     * 样式额外的配置，比如路况，背景颜色等，使用二进制可以更快加载出自定义样式，如果设置了则不会读取styleExtraPath
     * @return 二进制样式文件
     * @since 2.2.2
     */
    getStyleExtraData(): Uint8Array | undefined;
    /**
     * 样式额外的配置，比如路况，背景颜色等，使用二进制可以更快加载出自定义样式，如果设置了则不会读取styleExtraPath
     * @param styleExtraData 二进制样式文件
     * @return 修改样式属性后的对象
     * @since 2.2.2
     */
    setStyleExtraData(q25: Uint8Array | undefined): CustomMapStyleOptions;
    /**
     * 样式额外的配置，比如路况，背景颜色等 文件路径
     * @return 样式额外的配置路径
     * @since 2.2.2
     */
    getStyleExtraPath(): string;
    /**
     * 样式额外的配置，比如路况，背景颜色等 文件路径
     * @param styleExtraPath 样式额外的配置路径
     * @return 修改样式属性后的对象
     * @since 2.2.2
     *
     */
    setStyleExtraPath(p25: string): this;
    /**
     * 自定义样式，资源文件路径，包含自定义图标
     *
     * @return 路径
     * @since 2.2.2
     * @exclude javadoc中不显示
     */
    d26(): string;
    /**
     * 自定义样式，资源文件路径，包含自定义图标
     *
     * @return 修改样式属性后的对象
     * @since 2.2.2
     * @exclude javadoc中不显示
     */
    e26(o25: string): CustomMapStyleOptions;
    /**
     * 自定义样式，资源文件二进制，包含自定义图标
     *
     * @return 二进制内容
     * @since 2.2.2
     * @exclude javadoc中不显示
     */
    f26(): Uint8Array | undefined;
    /**
     * 自定义样式二进制，资源文件路径，包含自定义图标
     *
     * @return 修改样式属性后的对象
     * @since 2.2.2
     * @exclude javadoc中不显示
     */
    g26(n25: Uint8Array): CustomMapStyleOptions;
}
