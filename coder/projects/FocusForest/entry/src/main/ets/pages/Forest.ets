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

import { TreeModel, Tree } from '../utils/TreeModel';
import { DesignTokens } from '../constants/DesignTokens';
import { TreeCard } from '../components/TreeCard';

@Entry
@Component
export struct Forest {
  @State treeModel: TreeModel = TreeModel.getInstance();
  @State trees: Tree[] = [];
  @State isDarkMode: boolean = false;
  @State totalTrees: number = 0;
  @State healthyTrees: number = 0;
  @State witheredTrees: number = 0;
  
  getColors() {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  async aboutToAppear() {
    await this.loadForest();
  }
  
  async loadForest() {
    try {
      const context = getContext(this) as common.UIAbilityContext;
      await this.treeModel.initialize(context);
      
      this.trees = this.treeModel.getTrees();
      const stats = this.treeModel.getForestStats();
      
      this.totalTrees = stats.totalTrees;
      this.healthyTrees = stats.healthyTrees;
      this.witheredTrees = stats.witheredTrees;
      this.isDarkMode = this.pomodoroModel.getIsDarkMode();
    } catch (error) {
      console.error('Forest loadForest error:', error);
    }
  }
  
  build() {
    Column() {
      // 页面标题
      Row() {
        Text('我的森林')
          .fontSize(DesignTokens.FONT_SIZE.xl)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().textPrimary)
      }
      .width('100%')
      .padding({ 
        top: DesignTokens.SPACING.lg, 
        bottom: DesignTokens.SPACING.md,
        left: DesignTokens.SPACING.lg 
      })
      
      // 树木网格
      Scroll() {
        Column() {
          if (this.trees.length > 0) {
            Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.SpaceAround }) {
              ForEach(this.trees, (tree: Tree) => {
                TreeCard({
                  treeType: tree.type,
                  treeName: tree.name,
                  isWithered: tree.isWithered,
                  isDarkMode: this.isDarkMode
                })
                .margin(DesignTokens.SPACING.sm)
              })
            }
            .width('100%')
            .padding(DesignTokens.SPACING.md)
          } else {
            Column() {
              Text('🌰')
                .fontSize(DesignTokens.FONT_SIZE.icon)
                .margin({ bottom: DesignTokens.SPACING.md })
              
              Text('还没有树木')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontColor(this.getColors().textSecondary)
              
              Text('开始专注，种下第一棵树吧！')
                .fontSize(DesignTokens.FONT_SIZE.sm)
                .fontColor(this.getColors().textTertiary)
                .margin({ top: DesignTokens.SPACING.xs })
            }
            .width('100%')
            .padding({ top: DesignTokens.SPACING.xxl })
            .justifyContent(FlexAlign.Center)
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
      
      // 统计信息栏
      Row() {
        Text(`总计：${this.totalTrees}棵`)
          .fontSize(DesignTokens.FONT_SIZE.sm)
          .fontColor(this.getColors().textPrimary)
        
        Text(`|`)
          .fontSize(DesignTokens.FONT_SIZE.sm)
          .fontColor(this.getColors().textTertiary)
          .margin({ left: DesignTokens.SPACING.sm, right: DesignTokens.SPACING.sm })
        
        Text(`健康：${this.healthyTrees}`)
          .fontSize(DesignTokens.FONT_SIZE.sm)
          .fontColor(this.getColors().successColor)
        
        Text(`|`)
          .fontSize(DesignTokens.FONT_SIZE.sm)
          .fontColor(this.getColors().textTertiary)
          .margin({ left: DesignTokens.SPACING.sm, right: DesignTokens.SPACING.sm })
        
        Text(`枯萎：${this.witheredTrees}`)
          .fontSize(DesignTokens.FONT_SIZE.sm)
          .fontColor(this.getColors().errorColor)
      }
      .width('100%')
      .padding({ 
        top: DesignTokens.SPACING.md, 
        bottom: DesignTokens.SPACING.md,
        left: DesignTokens.SPACING.lg,
        right: DesignTokens.SPACING.lg 
      })
      .backgroundColor(this.getColors().cardBackground)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
  }
}
