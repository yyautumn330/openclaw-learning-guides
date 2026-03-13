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

import { drawing } from '@kit.ArkGraphics2D';
import { DesignTokens } from '../constants/DesignTokens';

/**
 * 轨迹绘制组件
 */
@Component
export struct TrackCanvas {
  @State trackPoints: { lat: number; lng: number }[] = [];
  @State isDarkMode: boolean = false;
  
  private canvas: drawing.DrawingCanvas | null = null;
  
  getColors() {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  aboutToAppear() {
    // 初始化画布
  }
  
  /**
   * 添加轨迹点
   */
  addPoint(lat: number, lng: number) {
    this.trackPoints.push({ lat, lng });
  }
  
  /**
   * 清除轨迹
   */
  clearTrack() {
    this.trackPoints = [];
  }
  
  build() {
    Canvas(this.canvas)
      .width('100%')
      .height('100%')
      .onReady((canvas: drawing.DrawingCanvas) => {
        this.canvas = canvas;
        this.drawTrack();
      })
  }
  
  /**
   * 绘制轨迹
   */
  drawTrack() {
    if (!this.canvas || this.trackPoints.length < 2) return;
    
    const ctx = this.canvas.getContext('2d') as drawing.CanvasRenderingContext2D;
    const width = this.canvas.width;
    const height = this.canvas.height;
    
    // 清空画布
    ctx.clearRect(0, 0, width, height);
    
    // 设置样式
    ctx.strokeStyle = this.getColors().primaryColor;
    ctx.lineWidth = 3;
    ctx.lineCap = 'round';
    ctx.lineJoin = 'round';
    
    // 绘制轨迹线
    ctx.beginPath();
    
    // 计算缩放比例
    const lats = this.trackPoints.map(p => p.lat);
    const lngs = this.trackPoints.map(p => p.lng);
    const minLat = Math.min(...lats);
    const maxLat = Math.max(...lats);
    const minLng = Math.min(...lngs);
    const maxLng = Math.max(...lngs);
    
    const latRange = maxLat - minLat || 0.001;
    const lngRange = maxLng - minLng || 0.001;
    
    // 绘制轨迹点
    this.trackPoints.forEach((point, index) => {
      const x = ((point.lng - minLng) / lngRange) * (width - 40) + 20;
      const y = height - ((point.lat - minLat) / latRange) * (height - 40) - 20;
      
      if (index === 0) {
        ctx.moveTo(x, y);
      } else {
        ctx.lineTo(x, y);
      }
    });
    
    ctx.stroke();
    
    // 绘制起点
    if (this.trackPoints.length > 0) {
      const startPoint = this.trackPoints[0];
      const startX = ((startPoint.lng - minLng) / lngRange) * (width - 40) + 20;
      const startY = height - ((startPoint.lat - minLat) / latRange) * (height - 40) - 20;
      
      ctx.fillStyle = '#52C41A';
      ctx.beginPath();
      ctx.arc(startX, startY, 6, 0, 2 * Math.PI);
      ctx.fill();
    }
    
    // 绘制终点
    if (this.trackPoints.length > 1) {
      const endPoint = this.trackPoints[this.trackPoints.length - 1];
      const endX = ((endPoint.lng - minLng) / lngRange) * (width - 40) + 20;
      const endY = height - ((endPoint.lat - minLat) / latRange) * (height - 40) - 20;
      
      ctx.fillStyle = '#FF4D4F';
      ctx.beginPath();
      ctx.arc(endX, endY, 6, 0, 2 * Math.PI);
      ctx.fill();
    }
  }
}
