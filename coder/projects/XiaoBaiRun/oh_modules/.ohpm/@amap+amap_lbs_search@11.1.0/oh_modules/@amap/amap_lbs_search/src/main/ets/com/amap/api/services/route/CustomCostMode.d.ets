// @keepTs
// @ts-nocheck
import { u71 } from "./CurveCost";
import { x71 } from "./PowerTrainLoss";
import { y71 } from "./SlopeCost";
import { z71 } from "./SpeedCost";
import { a72 } from "./TransCost";
import ArrayList from "@ohos.util.ArrayList";
/**
 * 能耗模型
 *
 * @exclude javadoc中不显示
 */
export declare class b72 {
    /**
     * 速度相关权值，可以重复传多组，含多组SPEED和VALUE，每组代表一个特定速度下每行驶一公里的能耗值（不含坡度消耗），介于两个速度之间的可用线性插值计算
     */
    private s72?;
    /**
     * 弯道消耗权值
     */
    private t72?;
    /**
     * 坡度消耗权值
     */
    private u72?;
    /**
     * 辅助消耗系数，与时间成比例的能量消耗，含车辆启动后的基础能耗、附加设备的能耗（如空调、座椅加热等），随车辆驾驶模式变化，单位wh/s
     */
    private v72;
    /**
     * 转向消耗权值数组
     */
    private w72?;
    /**
     * 轮渡消耗（车辆静置场景下的消耗）默认0
     */
    private x72;
    /**
     * 能量消耗与动力总成消耗数组。主要指在动力传动系统其他额外的损耗，比如电池耗电8kwh，前几项能耗只有7.5kwh，有一部分可能损耗在传动系统或其他地方，可以通过这个参数补充修正值
     */
    private y72?;
    /**
     * 获取速度相关权值，可以重复传多组，含多组SPEED和VALUE，每组代表一个特定速度下每行驶一公里的能耗值（不含坡度消耗），介于两个速度之间的可用线性插值计算
     *
     * @return 速度相关权值，可以重复传多组，含多组SPEED和VALUE，每组代表一个特定速度下每行驶一公里的能耗值（不含坡度消耗），介于两个速度之间的可用线性插值计算
     * @exclude javadoc中不包含
     */
    z72(): ArrayList<z71>;
    /**
     * 设置速度相关权值，可以重复传多组，含多组SPEED和VALUE，每组代表一个特定速度下每行驶一公里的能耗值（不含坡度消耗），介于两个速度之间的可用线性插值计算
     *
     * @param speedCosts 速度相关权值，可以重复传多组，含多组SPEED和VALUE，每组代表一个特定速度下每行驶一公里的能耗值（不含坡度消耗），介于两个速度之间的可用线性插值计算
     * @exclude javadoc中不包含
     */
    a73(r72: ArrayList<z71>): void;
    /**
     * 获取弯道消耗权值
     *
     * @return 弯道消耗权值
     * @exclude javadoc中不包含
     */
    b73(): u71;
    /**
     * 设置弯道消耗权值
     *
     * @param curveCost 弯道消耗权值
     * @exclude javadoc中不包含
     */
    c73(q72: u71): void;
    /**
     * 获取坡度消耗权值
     *
     * @return 坡度消耗权值
     * @exclude javadoc中不包含
     */
    d73(): y71;
    /**
     * 设置坡度消耗权值
     *
     * @param slopeCost 坡度消耗权值
     * @exclude javadoc中不包含
     */
    e73(p72: y71): void;
    /**
     * 获取辅助消耗系数，与时间成比例的能量消耗，含车辆启动后的基础能耗、附加设备的能耗（如空调、座椅加热等），随车辆驾驶模式变化，单位wh/s
     *
     * @return 辅助消耗系数，与时间成比例的能量消耗，含车辆启动后的基础能耗、附加设备的能耗（如空调、座椅加热等），随车辆驾驶模式变化，单位wh/s
     * @exclude javadoc中不包含
     */
    f73(): number;
    /**
     * 设置辅助消耗系数，与时间成比例的能量消耗，含车辆启动后的基础能耗、附加设备的能耗（如空调、座椅加热等），随车辆驾驶模式变化，单位wh/s
     *
     * @param auxCost 辅助消耗系数，与时间成比例的能量消耗，含车辆启动后的基础能耗、附加设备的能耗（如空调、座椅加热等），随车辆驾驶模式变化，单位wh/s
     * @exclude javadoc中不包含
     */
    g73(o72: number): void;
    /**
     * 获取转向消耗权值数组
     *
     * @return 转向消耗权值数组
     * @exclude javadoc中不包含
     */
    h73(): a72;
    /**
     * 设置转向消耗权值数组
     *
     * @param transCost 转向消耗权值数组
     * @exclude javadoc中不包含
     */
    i73(n72: a72): void;
    /**
     *
     * 获取轮渡消耗（车辆静置场景下的消耗）默认0
     *
     * @return 轮渡消耗（车辆静置场景下的消耗）默认0
     * @exclude javadoc中不包含
     */
    j73(): number;
    /**
     * 设置轮渡消耗（车辆静置场景下的消耗）默认0
     *
     * @param ferryCost 轮渡消耗（车辆静置场景下的消耗）默认0
     * @exclude javadoc中不包含
     */
    k73(m72: number): void;
    /**
     * 获取能量消耗与动力总成消耗数组。主要指在动力传动系统其他额外的损耗，比如电池耗电8kwh，前几项能耗只有7.5kwh，有一部分可能损耗在传动系统或其他地方，可以通过这个参数补充修正值
     *
     * @return 能量消耗与动力总成消耗数组。主要指在动力传动系统其他额外的损耗，比如电池耗电8kwh，前几项能耗只有7.5kwh，有一部分可能损耗在传动系统或其他地方，可以通过这个参数补充修正值
     * @exclude javadoc中不包含
     */
    l73(): x71;
    /**
     * 设置能量消耗与动力总成消耗数组。主要指在动力传动系统其他额外的损耗，比如电池耗电8kwh，前几项能耗只有7.5kwh，有一部分可能损耗在传动系统或其他地方，可以通过这个参数补充修正值
     *
     * @param powerTrainLosses 能量消耗与动力总成消耗数组。主要指在动力传动系统其他额外的损耗，比如电池耗电8kwh，前几项能耗只有7.5kwh，有一部分可能损耗在传动系统或其他地方，可以通过这个参数补充修正值
     * @exclude javadoc中不包含
     */
    m73(l72: x71): void;
    n73(): object;
}
