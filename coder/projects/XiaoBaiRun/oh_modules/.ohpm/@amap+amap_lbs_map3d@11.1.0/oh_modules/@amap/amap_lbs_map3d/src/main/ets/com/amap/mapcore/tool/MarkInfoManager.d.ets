// @keepTs
// @ts-nocheck
export declare class r245 {
    private static readonly h248;
    private static readonly i248;
    private static readonly j248;
    private static readonly k248;
    /**
     * 方法要批量调用，避免频繁io导致性能问题
     *
     * @param details 具体的marker信息 例如：[{"lon": 114,"lat": 39,"title": "肯德基XX店","snippet": "肯德基XX店，联系电话XXXXXXX"},{"lon":
     *                115,"lat": 38,"title": "肯德基XX店","snippet": "肯德基XX店，联系电话XXXXXXX"}]
     * @param context 传入ApplicationContext避免，iO操作持有Context时间过久
     */
    static apply(details: string | null, context: Context | null): void;
    static l248(/* final */ context: Context | null): void;
    private static getUniqueId;
}
