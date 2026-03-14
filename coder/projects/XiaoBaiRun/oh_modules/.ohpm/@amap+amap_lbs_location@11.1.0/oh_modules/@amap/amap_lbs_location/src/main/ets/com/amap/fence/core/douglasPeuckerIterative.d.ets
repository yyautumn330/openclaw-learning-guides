// @keepTs
// @ts-nocheck
import { DPoint } from '../../location/DPoint';
import { Point } from './GeoFenceSearchResultParser';
/**
 * 将 DPoint 转为 Plain Object（可序列化）
 */
export declare function t(p: DPoint): Point;
export declare function u(p: Point): DPoint;
/**
 * 道格拉斯-普克算法（循环版本，无递归）
 * @param points - 输入点数组
 * @param tolerance - 简化阈值
 * @returns 简化后的点数组
 */
export declare function a1(b1: Point[], threshold: number): Point[];
