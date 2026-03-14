// @keepTs
// @ts-nocheck
/**
* Class name :GLMapStaticValue
*
* 引擎功能参数设置，共用一个接口
*
* author:ruimin.cao
*
* Version information :755
*
* Date :2015/11/26
*
*/
export declare class q12 {
    /**
     * 地图状态常量
     */
    static readonly j177: number;
    static readonly k177: number;
    static readonly v171: number;
    static readonly e97: number;
    /**
     *  是否适用惯性手势
     */
    static readonly p237: boolean;
    static readonly k132: number;
    /**
     * 是否适用惯性手势
     */
    static readonly l132: number;
    /**
     * 是否适用惯性手势
     */
    static readonly m132: number;
    /** 地图渲染状态*/
    static readonly q237: number;
    static readonly r237: number;
    static readonly s237: number;
    static readonly t237: number;
    static readonly s67: number;
    static readonly v67: number;
    static readonly x67: number;
    static readonly u237: number;
    static readonly v237: number;
    static readonly w237: number;
    static readonly x237: number;
    /**
     * 导航三维退出
     */
    static readonly y237: number;
    /**
     * 底图渲染全部完成
     */
    static readonly z67: number;
    static readonly z237: number;
    /**
     * @brief 地图设置开关
     */
    /** 设置是否开启建筑物绘制*/
    static readonly a238: number;
    /** 设置是否开启3D建筑物绘制*/
    static readonly b238: number;
    /** 设置是否开启二维道路箭头绘制*/
    static readonly c238: number;
    /** 设置是否开启标注绘制*/
    static readonly d238: number;
    /** 设置是否开启室内地图*/
    static readonly e238: number;
    /** 设置是否开启导览图*/
    static readonly f238: number;
    /** 设置景区搜索过滤的索引*/
    static readonly g238: number;
    /** 设置景区搜索图标个数*/
    static readonly h238: number;
    /** 设置是否开启景区功能*/
    static readonly i238: number;
    /** 设置地图投影中心*/
    static readonly j238: number;
    /** 设置是否处理导航过程中的标注*/
    static readonly k238: number;
    /** 设置是否开启实时路况*/
    static readonly l238: number;
    /** 设置是否开启卫星图*/
    static readonly m238: number;
    /** 清除选中的地铁id和状态*/
    static readonly n238: number;
    /** 设置是否开启热度图*/
    static readonly o238: number;
    /** 设置是否显示普通建筑物*/
    static readonly p238: number;
    /** 设置是否显示地标建筑物poi*/
    static readonly q238: number;
    /** 设置是否清除室内激活控件相关缓存信息*/
    static readonly r238: number;
    /** 设置是否开启开放图层*/
    static readonly s238: number;
    /** 设置图标宽高(没有使用)*/
    static readonly t238: number;
    /** 设置是否清除上次访问室内楼层信息(没有使用)*/
    static readonly u238: number;
    /** 设置是否碰撞视线上的建筑物(相机原点到地图中心)*/
    static readonly v238: number;
    /** 设置是否显示建筑物纹理*/
    static readonly w238: number;
    /** 是否显示简易三维*/
    static readonly x238: number;
    /** 是否开启简易三维高度*/
    static readonly y238: number;
    /** 激活TMC强制刷新标记位*/
    static readonly z238: number;
    /** 是否开启FBO优化绘制1*/
    static readonly a239: number;
    /**
     * 设置机型屏幕显示内容适配系数
     */
    static readonly b239: number;
    /** 设置文字缩放系数*/
    static readonly c239: number;
    /** 退到后台时记录地图当下状态 */
    static readonly d239: number;
    /** 建筑物是否有动画和透明度：0～1生长效果*/
    static readonly e239: number;
    /** 手势消息*/
    static readonly v177: number;
    static readonly g179: number;
    static readonly q178: number;
    static readonly i177: number;
    static readonly f239: number;
    /**
     * 鹰眼边框纹理ID
     */
    static readonly g239: number;
    static readonly h239: number;
    static readonly i239: number;
    static readonly j239: number;
    /** ===========================地图功能参数==============*/
    static readonly k239: number;
    /**
     * 开启预渲染栅格图方块
     */
    static readonly l239: number;
    static readonly m239: number;
    static readonly n239: number;
    static readonly o239: number;
    static readonly p239: number;
    /**
     * 设置室内是否开启
     */
    static readonly q239: number;
    /**
     * 景区相关
     *  设置是否开启导览图
     */
    static readonly r239: number;
    /**
     * 设置景区搜索过滤的index
     */
    static readonly s239: number;
    /**
     * 设置景区搜索图标个数
     */
    static readonly t239: number;
    /**
     * 设置地图左边长度, 设置的值要落在[0,屏幕宽度w][0,屏幕高度h]内
     */
    static readonly u239: number;
    /**
     * 强制刷新导航文字标签
     */
    static readonly v239: number;
    /**
     * 重新加载路况纹理，第一个参数代表，是否是正常状态显示
     */
    static readonly w239: number;
    /**
     * 设置色盲开关状态，第一个参数代表，1:开，0:关
     */
    static readonly x239: number;
    static readonly y239: number;
    /**
     * 更新地图当下状态
     */
    static readonly z239: number;
    /**
     * 清除选中的地铁id和状态
     */
    static readonly a240: number;
    /**
     * 设置是否开启热度图
     */
    static readonly b240: number;
    /**
     * 是否显示建筑物
     */
    static readonly c240: number;
    /**
     * 是否显示地标建筑物
     */
    static readonly d240: number;
    /**
     * 是否显示地标建筑物POI
     */
    static readonly e240: number;
    /**
     * 是否清除室内激活控件相关缓存信息
     */
    static readonly f240: number;
    /**
     * 是否显示开放图层
     */
    static readonly g240: number;
    /**
     * 设置icon资源的宽高信息
     */
    static readonly h240: number;
    /**
     *  建筑物是否采用纹理贴图
     */
    static readonly i240: number;
    /** 建筑物是否有动画和透明度：0～1生长效果*/
    static readonly j240: number;
    /** AUTO:如果tmc没有开启，用纹理填充，否则用颜色填充*/
    static readonly k240: number;
    /**
     * 是否开启简易三维
     */
    static readonly l240: number;
    /**
     * 是否开启简易三维高度
     */
    static readonly m240: number;
    /** 激活TMC强制刷新标记位*/
    static readonly n240: number;
    /**
     * 是否开启FBO优化
     */
    static readonly o240: number;
    static readonly p240: number;
    /**
     * 设置文字信息缩放系数
     */
    static readonly q240: number;
    /**
     * 设置文字近大远小修正系数
     */
    static readonly r240: number;
    /**
     * 设置进来的地图样式值:保存应用层设置的参数,仅提供给应用层获取参数使用
     */
    static readonly s240: number;
    /**
     * 当外部通过控制绘制循环来改变FPS时, 请设置最大FPS以保证文字显示等动画的效果. pIntValue1 = maxfps (0~60), 默认是60
     */
    static readonly t240: number;
    static readonly u240: number;
    /**
     * 停止或者启动后台线程
     */
    static readonly v240: number;
    /**
     * 停止或启动读写数据库
     */
    static readonly w240: number;
    /**
     * 保存在线缓存索引文件
     */
    static readonly x240: number;
    /**
     * 清理缓存
     */
    static readonly y240: number;
    /**
     * 清空在线文件缓存
     */
    static readonly z240: number;
    /**
     * 是否监听地图渲染完成
     */
    static readonly a241: number;
    /**
     * 设置REAL3D是否开启
     */
    static readonly b241: number;
    /**
     * 3D路径线是否存在
     */
    static readonly c241: number;
    /**
     *  设置是否开启动画
     */
    static readonly d241: number;
    /**
     * 半级缩放
     */
    static readonly e241: number;
    /**
     * 设置网络状态
     */
    static readonly f241: number;
    /**
     * 设置最大刷新间隔 第一个参数 单位为微秒
     */
    static readonly g241: number;
    /**
     * 是否显示避让框
     */
    static readonly h241: number;
    static readonly i241: number;
    static readonly j241: number;
    static readonly k241: number;
    static readonly l241: number;
    static readonly m241: number;
    static readonly n241: number;
    static readonly o241: number;
    static readonly p241: number;
    static readonly q241: number;
    static readonly r241: number;
    static readonly s241: number;
    static readonly t241: number;
    static readonly u241: number;
    static readonly v241: number;
    static readonly w241: number;
    static readonly x241: number;
    /** 没有用到了，后面可以考虑删除*/
    static readonly y241: number;
    /** TMC强制刷新时间间隔5秒*/
    static readonly z241: number;
    /**
     * 异步加载资源
     * */
    static readonly a242: number;
    static readonly b242: number;
    /** 底层回调上层，请求室内数据网络出错*/
    static readonly c242: number;
    /** =============================鹰眼图==================================================*/
    /** 整体设置显示内容配置变量*/
    static readonly d242: number;
    /** 单独设置显示内容配置变量*/
    static readonly e242: number;
    /** 路网*/
    static readonly f242: number;
    /** 楼块*/
    static readonly g242: number;
    /** 路网*/
    static readonly h242: number;
    /** tmc*/
    static readonly i242: number;
    /** 背景面*/
    static readonly j242: number;
    /** poi*/
    static readonly k242: number;
    /** 室内地图*/
    static readonly l242: number;
    /** 开放图层*/
    static readonly m242: number;
    /** 导览图*/
    static readonly n242: number;
    /** 热力图*/
    static readonly o242: number;
    /** 三维*/
    static readonly p242: number;
    /** 三维路口放大图*/
    static readonly q242: number;
    static readonly r242: number;
    static readonly s242: number;
    static readonly p14: number;
    static readonly q14: number;
    static readonly r14: number;
    static readonly t242: number;
    static readonly u242: number;
    static readonly v242: number;
    /** 放大*/
    static readonly w242: number;
    /** 缩小*/
    static readonly x242: number;
    /**滑动*/
    static readonly y242: number;
    /**捏合*/
    static readonly z242: number;
    /**旋转*/
    static readonly a243: number;
    /**相机*/
    static readonly b243: number;
    /**长按*/
    static readonly c243: number;
    /**单击*/
    static readonly d243: number;
    /**单击缩放*/
    static readonly e243: number;
    /**
     * 手势锚点类型，影响手势为单指双击，双指缩放。
     * 默认为手指位置（单指手势）或双指之间的中心点（双指手势）为手势锚点。
     */
    static readonly f243: number;
    /**
     * 以屏幕中心点为手势锚点。
     */
    static readonly g243: number;
    /**
     * auto开关
     * */
    static readonly h243: boolean;
    /**
     * 地图Overlay绘制顺序
     */
    /** 按照既有的默认顺序*/
    static readonly i243: number;
    /**地图文字之前绘制*/
    static readonly j243: number;
    /** 地图文字之后绘制*/
    static readonly k243: number;
    /**
     * 后台截图开关
     * */
    static readonly l243: boolean;
    /**
     * 前台截图开关
     * */
    static readonly m243: boolean;
    static readonly o68: number;
    static readonly p68: number;
    static readonly q68: number;
    static readonly r68: number;
    /**
     * 渲染帧率设置
     */
    static readonly s68: number;
    static t68: number;
    static u68: number;
    static v68: number;
    static w68: number;
    static n243: number;
    /**导航消息的日志，供上层分析地图中心使用*/
    static o243: boolean;
    /** 截图模式*/
    /** 不截图*/
    static p243: number;
    /** 后台截图*/
    static q243: number;
    /** 前台截图*/
    static r243: number;
    /** 截图车型*/
    /** 默认车型*/
    static s243: number;
    /** 吉利车型*/
    static t243: number;
    /** 路畅车型*/
    static u243: number;
    /** 截图存储图片的压缩率*/
    static v243: number;
    /** 截图结果返回方法*/
    /** BUFFER返回*/
    static w243: number;
    /** 图片返回*/
    static x243: number;
    /** 文件返回*/
    static y243: number;
    /** 默认屏幕，一般对应apk运行的设备本身的屏幕*/
    static z243: number;
    static readonly a244: number;
}
export declare class MapStyle {
    /**
     * 标准地图
     */
    static readonly TYPE_NORMAL: number;
    /**
     * 卫星地图
     */
    static readonly TYPE_SATELLITE: number;
    /**
     * 导航地图
     */
    static readonly TYPE_NAVI: number;
    /**
     * 公交地图
     */
    static readonly TYPE_BUS: number;
}
export declare class MapTime {
    /**
     * 白天
     */
    static readonly TYPE_DAY: number;
    /**
     * 黑夜
     */
    static readonly TYPE_NIGHT: number;
}
