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

import { DesignTokens } from '../constants/DesignTokens';
import { TreeType } from '../utils/TreeModel';

@Component
export struct TreeCard {
  @Prop treeType: TreeType;
  @Prop treeName: string;
  @Prop isWithered: boolean;
  @State isDarkMode: boolean = false;
  
  getColors() {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  getTreeEmoji(): string {
    switch (this.treeType) {
      case TreeType.SEEDLING: return '🌱';
      case TreeType.PINE: return '🌲';
      case TreeType.OAK: return '🌳';
      case TreeType.CHERRY: return '🌸';
      case TreeType.MAPLE: return '🍁';
      case TreeType.BAMBOO: return '🎋';
      case TreeType.PALM: return '🌴';
      case TreeType.RARE_GOLDEN: return '🌟';
      default: return '🌱';
    }
  }
  
  build() {
    Column() {
      Text(this.getTreeEmoji())
        .fontSize(40)
        .margin({ bottom: DesignTokens.SPACING.sm })
        .opacity(this.isWithered ? 0.5 : 1.0)
      
      Text(this.treeName)
        .fontSize(DesignTokens.FONT_SIZE.xs)
        .fontColor(this.getColors().textPrimary)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
      
      Text(this.isWithered ? '枯萎' : '健康')
        .fontSize(10)
        .fontColor(this.isWithered ? this.getColors().errorColor : this.getColors().successColor)
        .margin({ top: DesignTokens.SPACING.xs })
    }
    .width('18%')
    .height(100)
    .backgroundColor(this.getColors().cardBackground)
    .borderRadius(DesignTokens.RADIUS.lg)
    .padding(DesignTokens.SPACING.md)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.1)',
      offsetX: 0,
      offsetY: 2
    })
  }
}
