/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { TrajectoryPoint } from '../models/TrajectoryModel';
import { TrajectoryCanvasUtils } from '../utils/TrajectoryCanvasUtils';
import { DesignTokens } from '../constants/DesignTokens';

/**
 * 轨迹画布组件
 * 使用 Canvas 实时绘制跑步轨迹
 */
@Component
export struct TrajectoryCanvas {
  @Prop trajectoryPoints: TrajectoryPoint[] = [];
  @Prop isDarkMode: boolean = false;
  @Prop width: number = 350;
  @Prop height: number = 300;
  
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  /**
   * 绘制轨迹
   */
  private drawTrajectory(): void {
    if (!this.context || this.trajectoryPoints.length === 0) return;

    const canvasWidth = this.width;
    const canvasHeight = this.height;

    // 清除画布
    this.context.clearRect(0, 0, canvasWidth, canvasHeight);

    // 绘制背景
    this.drawBackground();

    // 绘制轨迹线
    this.drawTrajectoryLine();

    // 绘制起点和终点标记
    this.drawMarkers();

    // 绘制当前点
    this.drawCurrentPoint();
  }

  /**
   * 绘制背景
   */
  private drawBackground(): void {
    const colors = DesignTokens.getThemeColors(this.isDarkMode);
    
    this.context.fillStyle = this.isDarkMode ? '#1a1a2e' : '#e8f4f8';
    this.context.fillRect(0, 0, this.width, this.height);

    // 绘制网格
    this.context.strokeStyle = this.isDarkMode ? 'rgba(255,255,255,0.1)' : 'rgba(0,0,0,0.05)';
    this.context.lineWidth = 1;

    const gridSize = 30;
    for (let x = 0; x < this.width; x += gridSize) {
      this.context.beginPath();
      this.context.moveTo(x, 0);
      this.context.lineTo(x, this.height);
      this.context.stroke();
    }
    for (let y = 0; y < this.height; y += gridSize) {
      this.context.beginPath();
      this.context.moveTo(0, y);
      this.context.lineTo(this.width, y);
      this.context.stroke();
    }
  }

  /**
   * 绘制轨迹线
   */
  private drawTrajectoryLine(): void {
    if (this.trajectoryPoints.length < 2) return;

    const bounds = TrajectoryCanvasUtils.calculateBounds(this.trajectoryPoints);
    const padding = 40;

    // 绘制轨迹路径
    this.context.beginPath();
    this.context.strokeStyle = '#4ED1C4'; // 绿松石色
    this.context.lineWidth = 3;
    this.context.lineCap = 'round';
    this.context.lineJoin = 'round';

    for (let i = 0; i < this.trajectoryPoints.length; i++) {
      const { x, y } = TrajectoryCanvasUtils.geoToCanvas(
        this.trajectoryPoints[i].latitude,
        this.trajectoryPoints[i].longitude,
        bounds,
        this.width,
        this.height,
        padding
      );

      if (i === 0) {
        this.context.moveTo(x, y);
      } else {
        this.context.lineTo(x, y);
      }
    }

    this.context.stroke();

    // 绘制轨迹阴影效果
    this.context.beginPath();
    this.context.strokeStyle = 'rgba(78, 209, 196, 0.3)';
    this.context.lineWidth = 8;

    for (let i = 0; i < this.trajectoryPoints.length; i++) {
      const { x, y } = TrajectoryCanvasUtils.geoToCanvas(
        this.trajectoryPoints[i].latitude,
        this.trajectoryPoints[i].longitude,
        bounds,
        this.width,
        this.height,
        padding
      );

      if (i === 0) {
        this.context.moveTo(x, y);
      } else {
        this.context.lineTo(x, y);
      }
    }

    this.context.stroke();
  }

  /**
   * 绘制起点和终点标记
   */
  private drawMarkers(): void {
    if (this.trajectoryPoints.length === 0) return;

    const bounds = TrajectoryCanvasUtils.calculateBounds(this.trajectoryPoints);
    const padding = 40;

    // 起点标记（绿色）
    const startPoint = TrajectoryCanvasUtils.geoToCanvas(
      this.trajectoryPoints[0].latitude,
      this.trajectoryPoints[0].longitude,
      bounds,
      this.width,
      this.height,
      padding
    );

    this.context.beginPath();
    this.context.arc(startPoint.x, startPoint.y, 8, 0, Math.PI * 2);
    this.context.fillStyle = '#4CAF50';
    this.context.fill();
    this.context.strokeStyle = '#FFFFFF';
    this.context.lineWidth = 2;
    this.context.stroke();

    // 终点标记（红色）
    if (this.trajectoryPoints.length > 1) {
      const endPoint = TrajectoryCanvasUtils.geoToCanvas(
        this.trajectoryPoints[this.trajectoryPoints.length - 1].latitude,
        this.trajectoryPoints[this.trajectoryPoints.length - 1].longitude,
        bounds,
        this.width,
        this.height,
        padding
      );

      this.context.beginPath();
      this.context.arc(endPoint.x, endPoint.y, 8, 0, Math.PI * 2);
      this.context.fillStyle = '#F44336';
      this.context.fill();
      this.context.strokeStyle = '#FFFFFF';
      this.context.lineWidth = 2;
      this.context.stroke();
    }
  }

  /**
   * 绘制当前点（带动画效果）
   */
  private drawCurrentPoint(): void {
    if (this.trajectoryPoints.length === 0) return;

    const bounds = TrajectoryCanvasUtils.calculateBounds(this.trajectoryPoints);
    const padding = 40;

    const currentPoint = TrajectoryCanvasUtils.geoToCanvas(
      this.trajectoryPoints[this.trajectoryPoints.length - 1].latitude,
      this.trajectoryPoints[this.trajectoryPoints.length - 1].longitude,
      bounds,
      this.width,
      this.height,
      padding
    );

    // 绘制光晕效果
    this.context.beginPath();
    this.context.arc(currentPoint.x, currentPoint.y, 15, 0, Math.PI * 2);
    this.context.fillStyle = 'rgba(33, 150, 243, 0.3)';
    this.context.fill();

    // 绘制当前点
    this.context.beginPath();
    this.context.arc(currentPoint.x, currentPoint.y, 6, 0, Math.PI * 2);
    this.context.fillStyle = '#2196F3';
    this.context.fill();
    this.context.strokeStyle = '#FFFFFF';
    this.context.lineWidth = 2;
    this.context.stroke();
  }

  build() {
    Column() {
      Canvas(this.context)
        .width(this.width)
        .height(this.height)
        .onReady(() => {
          this.drawTrajectory();
        })
        .borderRadius(12)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}