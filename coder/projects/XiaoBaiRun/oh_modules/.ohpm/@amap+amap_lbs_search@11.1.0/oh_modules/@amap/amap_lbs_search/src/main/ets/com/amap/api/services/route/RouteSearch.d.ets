// @keepTs
// @ts-nocheck
import { BusRouteQuery } from "./BusRouteQuery";
import { DrivePlanQuery } from "./DrivePlanQuery";
import { DriveRouteQuery } from "./DriveRouteQuery";
import { OnRoutePlanSearchListener } from "./OnRoutePlanSearchListener";
import { OnRouteSearchListener } from "./OnRouteSearchListener";
import { OnTruckRouteSearchListener } from "./OnTruckRouteSearchListener";
import { RideRouteQuery } from "./RideRouteQuery";
import { TruckRouteQuery } from "./TruckRouteQuery";
import { WalkRouteQuery } from "./WalkRouteQuery";
/**
 * 该类路径规划搜索的入口，定义此类开始路径规划搜索
 *
 * @since V1.0.0
 */
export declare class RouteSearch {
    private static readonly v44;
    /**
     * 最快捷模式。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#BUS_DEFAULT}
     */
    static readonly BusDefault = 0;
    /**
     * 最经济模式。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#BUS_SAVE_MONEY}
     */
    static readonly BusSaveMoney = 1;
    /**
     * 最少换乘。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#BUS_LEASE_CHANGE}
     */
    static readonly BusLeaseChange = 2;
    /**
     * 最少步行。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#BUS_LEASE_WALK}
     */
    static readonly BusLeaseWalk = 3;
    /**
     * 最舒适。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#BUS_COMFORTABLE}
     */
    static readonly BusComfortable = 4;
    /**
     * 不乘地铁。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#BUS_NO_SUBWAY}
     */
    static readonly BusNoSubway = 5;
    /**
     * 速度优先。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#DRIVING_SINGLE_DEFAULT}
     */
    static readonly DrivingDefault = 0;
    /**
     * 费用优先（不走收费路的最快道路）。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#DRIVING_SINGLE_SAVE_MONEY}
     */
    static readonly DrivingSaveMoney = 1;
    /**
     * 距离优先。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#DRIVING_SINGLE_SHORTEST}
     */
    static readonly DrivingShortDistance = 2;
    /**
     * 不走快速路。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#DRIVING_SINGLE_NO_EXPRESSWAYS}
     */
    static readonly DrivingNoExpressways = 3;
    /**
     * 避免拥堵。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#DRIVING_SINGLE_AVOID_CONGESTION}
     */
    static readonly DrivingAvoidCongestion = 4;
    /**
     * 同时使用速度优先、费用优先、距离优先三个策略计算路径。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#DRIVING_MULTI_STRATEGY_FASTEST_SAVE_MONEY_SHORTEST}
     */
    static readonly DrivingMultiStrategy = 5;
    /**
     * 不走高速。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#DRIVING_SINGLE_NO_HIGHWAY}
     */
    static readonly DrivingNoHighWay = 6;
    /**
     * 不走高速且避免收费。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#DRIVING_SINGLE_NO_HIGHWAY_SAVE_MONEY}
     */
    static readonly DrivingNoHighWaySaveMoney = 7;
    /**
     * 避免收费与拥堵。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#DRIVING_SINGLE_SAVE_MONEY_AVOID_CONGESTION}
     */
    static readonly DrivingSaveMoneyAvoidCongestion = 8;
    /**
     * 不走高速且躲避收费和拥堵。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#DRIVING_SINGLE_NO_HIGHWAY_SAVE_MONEY_AVOID_CONGESTION}
     */
    static readonly DrivingNoHighAvoidCongestionSaveMoney = 9;
    /**
     * 路径为步行模式。只提供一条步行方案。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#WALK_DEFAULT}
     */
    static readonly WalkDefault = 0;
    /**
     * 提供备选步行方案（有可能无备选方案）。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#WALK_MULTI_PATH}
     */
    static readonly WalkMultipath = 1;
    /**
     * 骑行推荐路线及最快路线综合。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#RIDING_DEFAULT}
     */
    static readonly RidingDefault = 0;
    /**
     * 骑行推荐路线。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#RIDING_RECOMMEND}
     */
    static readonly RidingRecommend = 1;
    /**
     * 骑行最快路线。
     *
     * @since V1.0.0
     * @deprecated 自 V1.0.0以后，请参考 {@link RouteSearch#RIDING_FAST}
     */
    static readonly RidingFast = 2;
    /**
     * 最快捷模式。
     *
     * @since V1.0.0
     */
    static readonly BUS_DEFAULT = 0;
    /**
     * 最经济模式。
     *
     * @since V1.0.0
     */
    static readonly BUS_SAVE_MONEY = 1;
    /**
     * 最少换乘。
     *
     * @since V1.0.0
     */
    static readonly BUS_LEASE_CHANGE = 2;
    /**
     * 最少步行。
     *
     * @since V1.0.0
     */
    static readonly BUS_LEASE_WALK = 3;
    /**
     * 最舒适。
     *
     * @since V1.0.0
     */
    static readonly BUS_COMFORTABLE = 4;
    /**
     * 不乘地铁。
     *
     * @since V1.0.0
     */
    static readonly BUS_NO_SUBWAY = 5;
    /**
     * 路径为步行模式。只提供一条步行方案。
     *
     * @since V1.0.0
     * @deprecated 步行不再提供模式相关设置
     */
    static readonly WALK_DEFAULT = 0;
    /**
     * 提供备选步行方案（有可能无备选方案）。
     *
     * @since V1.0.0
     * @deprecated 步行不再提供模式相关设置
     */
    static readonly WALK_MULTI_PATH = 1;
    /**
     * 骑行推荐路线及最快路线综合。
     *
     * @since V1.0.0
     * @deprecated 骑行不再提供模式相关设置
     */
    static readonly RIDING_DEFAULT = 0;
    /**
     * 骑行推荐路线。
     *
     * @since V1.0.0
     * @deprecated 骑行不再提供骑行相关设置
     */
    static readonly RIDING_RECOMMEND = 1;
    /**
     * 骑行最快路线。
     *
     * @since V1.0.0
     * @deprecated 骑行不再提供模式相关设置
     */
    static readonly RIDING_FAST = 2;
    /**
     * 速度优先
     *
     * @since V1.0.0
     */
    static readonly DRIVING_SINGLE_DEFAULT = 0;
    /**
     * 费用优先（不走收费路的最快道路）。
     *
     * @since V1.0.0
     */
    static readonly DRIVING_SINGLE_SAVE_MONEY = 1;
    /**
     * 距离优先。
     *
     * @since V1.0.0
     */
    static readonly DRIVING_SINGLE_SHORTEST = 2;
    /**
     * 不走快速路。
     *
     * @since V1.0.0
     */
    static readonly DRIVING_SINGLE_NO_EXPRESSWAYS = 3;
    /**
     * 避免拥堵。
     *
     * @since V1.0.0
     */
    static readonly DRIVING_SINGLE_AVOID_CONGESTION = 4;
    /**
     * 同时使用速度优先、费用优先、距离优先三个策略计算路径。
     *
     * @since V1.0.0
     */
    static readonly DRIVING_MULTI_STRATEGY_FASTEST_SAVE_MONEY_SHORTEST = 5;
    /**
     * 不走高速。
     *
     * @since V1.0.0
     */
    static readonly DRIVING_SINGLE_NO_HIGHWAY = 6;
    /**
     * 不走高速且避免收费。
     *
     * @since V1.0.0
     */
    static readonly DRIVING_SINGLE_NO_HIGHWAY_SAVE_MONEY = 7;
    /**
     * 避免收费与拥堵。
     *
     * @since V1.0.0
     */
    static readonly DRIVING_SINGLE_SAVE_MONEY_AVOID_CONGESTION = 8;
    /**
     * 不走高速且躲避收费和拥堵。
     *
     * @since V1.0.0
     */
    static readonly DRIVING_SINGLE_NO_HIGHWAY_SAVE_MONEY_AVOID_CONGESTION = 9;
    /**
     * 多备选，时间最短，距离最短，躲避拥堵（考虑路况）
     *
     * @since V1.0.0
     */
    static readonly DRIVING_MULTI_STRATEGY_FASTEST_SHORTEST_AVOID_CONGESTION = 10;
    /**
     * 多备选，时间最短，距离最短
     *
     * @since V1.0.0
     */
    static readonly DRIVING_MULTI_STRATEGY_FASTEST_SHORTEST = 11;
    /**
     * 多备选，躲避拥堵（考虑路况）
     *
     * @since V1.0.0
     */
    static readonly DRIVING_MULTI_CHOICE_AVOID_CONGESTION = 12;
    /**
     * 多备选，不走高速
     *
     * @since V1.0.0
     */
    static readonly DRIVING_MULTI_CHOICE_NO_HIGHWAY = 13;
    /**
     * 多备选，费用优先
     *
     * @since V1.0.0
     */
    static readonly DRIVING_MULTI_CHOICE_SAVE_MONEY = 14;
    /**
     * 多备选，躲避拥堵，不走高速（考虑路况）
     *
     * @since V1.0.0
     */
    static readonly DRIVING_MULTI_CHOICE_AVOID_CONGESTION_NO_HIGHWAY = 15;
    /**
     * 多备选，费用有限，不走高速
     *
     * @since V1.0.0
     */
    static readonly DRIVING_MULTI_CHOICE_SAVE_MONEY_NO_HIGHWAY = 16;
    /**
     * 多备选，躲避拥堵，费用优先（考虑路况）
     *
     * @since V1.0.0
     */
    static readonly DRIVING_MULTI_CHOICE_AVOID_CONGESTION_SAVE_MONEY = 17;
    /**
     * 多备选，躲避拥堵，不走高速，费用优先（考虑路况）
     *
     * @since V1.0.0
     */
    static readonly DRIVING_MULTI_CHOICE_AVOID_CONGESTION_NO_HIGHWAY_SAVE_MONEY = 18;
    /**
     * 多备选，高速优先
     *
     * @since V1.0.0
     */
    static readonly DRIVING_MULTI_CHOICE_HIGHWAY = 19;
    /**
     * 多备选，高速优先，躲避拥堵（考虑路况）
     *
     * @since V1.0.0
     */
    static readonly DRIVING_MULTI_CHOICE_HIGHWAY_AVOID_CONGESTION = 20;
    /**
     * 普通汽车
     * @since V1.0.0
     */
    static readonly DRIVING_NORMAL_CAR = 0;
    /**
     * 纯电动车
     * @since V1.0.0
     */
    static readonly DRIVING_PURE_ELECTRIC_VEHICLE = 1;
    /**
     * 插电混动车
     * @since V1.0.0
     */
    static readonly DRIVING_PLUGIN_HYBRID_CAR = 2;
    /**
     * 结果考虑路况，尽量躲避拥堵而规划路径，与高德地图的“躲避拥堵”策略一致
     *
     * @since V1.0.0
     */
    static readonly TRUCK_AVOID_CONGESTION = 1;
    /**
     * 结果不走高速，与高德地图“不走高速”策略一致
     *
     * @since V1.0.0
     */
    static readonly TRUCK_NO_HIGHWAY = 2;
    /**
     * 结果尽可能规划收费较低甚至免费的路径，与高德地图“避免收费”策略一致
     *
     * @since V1.0.0
     */
    static readonly TRUCK_SAVE_MONEY = 3;
    /**
     * 结果考虑路况，尽量躲避拥堵而规划路径，并且不走高速，与高德地图的“躲避拥堵&不走高速”策略一致
     *
     * @since V1.0.0
     */
    static readonly TRUCK_AVOID_CONGESTION_NO_HIGHWAY = 4;
    /**
     * 结果尽量不走高速，并且尽量规划收费较低甚至免费的路径结果，与高德地图的“避免收费&不走高速”策略一致
     *
     * @since V1.0.0
     */
    static readonly TRUCK_SAVE_MONEY_NO_HIGHWAY = 5;
    /**
     * 结果会尽量的躲避拥堵，并且规划收费较低甚至免费的路径结果，与高德地图的“躲避拥堵&避免收费”策略一致
     *
     * @since V1.0.0
     */
    static readonly TRUCK_AVOID_CONGESTION__SAVE_MONEY = 6;
    /**
     * 结果尽量躲避拥堵，规划收费较低甚至免费的路径结果，并且尽量不走高速路，与高德地图的“避免拥堵&避免收费&不走高速”策略一致
     *
     * @since V1.0.0
     */
    static readonly TRUCK_AVOID_CONGESTION__SAVE_MONEY_NO_HIGHWAY = 7;
    /**
     * 结果会优先选择高速路，与高德地图的“高速优先”策略一致
     *
     * @since V1.0.0
     */
    static readonly TRUCK_CHOICE_HIGHWAY = 8;
    /**
     * 结果会优先考虑高速路，并且会考虑路况躲避拥堵，与高德地图的“躲避拥堵&高速优先”策略一致
     *
     * @since V1.0.0
     */
    static readonly TRUCK_AVOID_CONGESTION_CHOICE_HIGHWAY = 9;
    /**
     * 微型车
     *
     * @since V1.0.0
     */
    static readonly TRUCK_SIZE_MINI = 1;
    /**
     * 轻型车
     *
     * @since V1.0.0
     */
    static readonly TRUCK_SIZE_LIGHT = 2;
    /**
     * 中型车
     *
     * @since V1.0.0
     */
    static readonly TRUCK_SIZE_MEDIUM = 3;
    /**
     * 重型车
     *
     * @since V1.0.0
     */
    static readonly TRUCK_SIZE_HEAVY = 4;
    /**
     * 返回的结果考虑路况，尽量躲避拥堵而规划路径，与高德地图的“躲避拥堵”策略一致
     *
     * @since V1.0.0
     */
    static readonly DRIVEING_PLAN_DEFAULT = 1;
    /**
     * 返回的结果不走高速，与高德地图“不走高速”策略一致
     *
     * @since V1.0.0
     */
    static readonly DRIVEING_PLAN_NO_HIGHWAY = 2;
    /**
     * 返回的结果尽可能规划收费较低甚至免费的路径，与高德地图“避免收费”策略一致
     *
     * @since V1.0.0
     */
    static readonly DRIVEING_PLAN_SAVE_MONEY = 3;
    /**
     * 返回的结果考虑路况，尽量躲避拥堵而规划路径，并且不走高速，与高德地图的“躲避拥堵&不走高速”策略一致
     *
     * @since V1.0.0
     */
    static readonly DRIVEING_PLAN_AVOID_CONGESTION_NO_HIGHWAY = 4;
    /**
     * 返回的结果尽量不走高速，并且尽量规划收费较低甚至免费的路径结果，与高德地图的“避免收费&不走高速”策略一致
     *
     * @since V1.0.0
     */
    static readonly DRIVEING_PLAN_SAVE_MONEY_NO_HIGHWAY = 5;
    /**
     * 返回路径规划结果会尽量的躲避拥堵，并且规划收费较低甚至免费的路径结果，与高德地图的“躲避拥堵&避免收费”策略一致
     *
     * @since V1.0.0
     */
    static readonly DRIVEING_PLAN_AVOID_CONGESTION_SAVE_MONEY = 6;
    /**
     * 返回的结果尽量躲避拥堵，规划收费较低甚至免费的路径结果，并且尽量不走高速路，与高德地图的“避免拥堵&避免收费&不走高速”策略一致
     *
     * @since V1.0.0
     */
    static readonly DRIVEING_PLAN_AVOID_CONGESTION_SAVE_MONEY_NO_HIGHWAY = 7;
    /**
     * 返回的结果会优先选择高速路，与高德地图的“高速优先”策略一致
     *
     * @since V1.0.0
     */
    static readonly DRIVEING_PLAN_CHOICE_HIGHWAY = 8;
    /**
     * 返回的结果会优先考虑高速路，并且会考虑路况躲避拥堵，与高德地图的“躲避拥堵&高速优先”策略一致
     *
     * @since V1.0.0
     */
    static readonly DRIVEING_PLAN_AVOID_CONGESTION_CHOICE_HIGHWAY = 9;
    /**
     * 不考虑路况，返回速度最优、耗时最短的路
     *
     * @since V1.0.0
     */
    static readonly DRIVEING_PLAN_FASTEST_SHORTEST = 10;
    /**
     * 避让拥堵&速度优先&避免收费
     *
     * @since V1.0.0
     */
    static readonly DRIVEING_PLAN_AVOID_CONGESTION_FASTEST_SAVE_MONEY = 11;
    /**
     * 海外生效 规避道路类型-收费道路
     * @since V1.0.0
     */
    static readonly DRIVING_EXCLUDE_TOLL = "toll";
    /**
     * 海外生效 规避道路类型-高速路
     * @since V1.0.0
     */
    static readonly DRIVING_EXCLUDE_MOTORWAY = "motorway";
    /**
     * 海外生效 规避道路类型-渡船
     * @since V1.0.0
     */
    static readonly DRIVING_EXCLUDE_FERRY = "ferry";
    /**
     * 扩展字段all，会返回完整参数
     * @since V1.0.0
     */
    static readonly EXTENSIONS_ALL = "all";
    /**
     * 扩展字段base，会返回部分参数
     * @since V1.0.0
     */
    static readonly EXTENSIONS_BASE = "base";
    private search?;
    /**
     * 根据给定的参数来构造一个RouteSearch的新对象。
     *
     * @param context 对应的Context。
     * @since V1.0.0
     */
    constructor(context: Context);
    /**
     * 路径搜索结果监听接口设置。
     *
     * @param listener 路径搜索结果监听接口。
     * @since V1.0.0
     */
    setRouteSearchListener(listener: OnRouteSearchListener): void;
    /**
     * 路径货车搜索结果监听接口设置。
     *
     * @param onTruckRouteSearchListener 货车路径搜索结果监听接口。
     * @since 1.0.1
     */
    setOnTruckRouteSearchListener(c85: OnTruckRouteSearchListener): void;
    /**
     * 根据指定的参数来计算步行路径。
     *
     * @param walkQuery 查询参数。
     * @throws AMapException
     * @since V1.0.0
     * @deprecated 自 1.0.0废弃 {@link RouteSearchV2#calculateWalkRoute}
     */
    calculateWalkRoute(b85: WalkRouteQuery): Promise<import("./WalkRouteResult").WalkRouteResult>;
    /**
     * 异步处理。根据指定的参数来计算步行路径的异步处理。
     *
     * @param walkQuery 查询参数。
     * @since V1.0.0
     * @deprecated 自废弃 1.0.0废弃 {@link RouteSearchV2#calculateWalkRouteAsyn}
     */
    calculateWalkRouteAsyn(a85: WalkRouteQuery): void;
    /**
     * 根据指定的参数来计算驾车路径。
     *
     * @param driveQuery 查询参数。
     * @throws AMapException 途经点太多或避让区域太大会返回非法参数
     * @since V1.0.0
     * @deprecated 自 1.0.0废弃 {@link RouteSearchV2#calculateDriveRoute}
     */
    calculateDriveRoute(z84: DriveRouteQuery): Promise<import("./DriveRouteResult").DriveRouteResult>;
    /**
     * 异步处理。根据指定的参数来计算驾车路径的异步处理。
     *
     * @param driveQuery 查询参数。
     * @since V1.0.0
     * @deprecated 自 1.0.0废弃 {@link RouteSearchV2#calculateDriveRouteAsyn}
     */
    calculateDriveRouteAsyn(y84: DriveRouteQuery): void;
    /**
     * 未来路径规划搜索结果监听接口设置。
     *
     * @param onRoutePlanSearchListener 货车路径搜索结果监听接口。
     * @since V1.0.0
     */
    setOnRoutePlanSearchListener(x84: OnRoutePlanSearchListener): void;
    /**
     * 根据指定的参数来计算驾车路径。
     *
     * @param driveQuery 查询参数。
     * @throws AMapException
     * @since V1.0.0
     */
    calculateDrivePlan(w84: DrivePlanQuery): Promise<import("./DriveRoutePlanResult").DriveRoutePlanResult>;
    /**
     * 异步处理。根据指定的参数来计算驾车路径的异步处理。
     *
     * @param driveQuery 查询参数。
     * @since V1.0.0
     */
    calculateDrivePlanAsyn(v84: DrivePlanQuery): void;
    /**
     * 根据指定的参数来计算骑行路径，同步接口。
     *
     * @param rideQuery 查询参数。
     * @throws AMapException
     * @since V1.0.0
     * @deprecated 自 1.0.0废弃 {@link RouteSearchV2#calculateRideRoute}
     */
    calculateRideRoute(u84: RideRouteQuery): Promise<import("./RideRouteResult").RideRouteResult>;
    /**
     * 异步处理。根据指定的参数来计算骑行路径的异步处理。
     *
     * @param rideQuery 查询参数。
     * @since V1.0.0
     * @deprecated 自 1.0.0废弃 {@link RouteSearchV2#calculateRideRouteAsyn}
     */
    calculateRideRouteAsyn(t84: RideRouteQuery): void;
    /**
     * 根据指定的参数来计算公交路径。只支持市内公交换乘。
     *
     * @param busQuery 查询参数。
     * @throws AMapException
     * @since V1.0.0
     * @deprecated 自1.0.0废弃 {@link RouteSearchV2#calculateBusRoute}
     */
    calculateBusRoute(s84: BusRouteQuery): Promise<import("./BusRouteResult").BusRouteResult>;
    /**
     * 异步处理。根据指定的参数来计算公交换乘路径的异步处理。只支持市内公交换乘。
     *
     * @param busQuery 查询参数。
     * @since V2.1.0
     * @deprecated 自9.4.0废弃 {@link RouteSearchV2#calculateBusRouteAsyn}
     */
    calculateBusRouteAsyn(r84: BusRouteQuery): void;
    /**
     * 异步处理。根据指定的参数来计算货车路径的异步处理。
     *
     * @param truckQuery 查询参数。
     * @since 1.0.1
     */
    calculateTruckRouteAsyn(q84: TruckRouteQuery): void;
    /**
     * 根据指定的参数来计算货车路径。
     *
     * @param truckQuery 查询参数。
     * @throws AMapException 途经点太多会返回非法参数
     * @since 1.0.1
     */
    calculateTruckRoute(p84: TruckRouteQuery): Promise<import("./TruckRouteRestult").TruckRouteRestult>;
}
