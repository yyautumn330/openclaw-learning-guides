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

import { preferences } from '@kit.ArkData';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';

const TAG = 'TreeModel';
const DOMAIN = 0x0000;

/**
 * 树木类型定义
 */
export enum TreeType {
  SEEDLING = 'seedling',      // 幼苗
  PINE = 'pine',              // 松树
  OAK = 'oak',                // 橡树
  CHERRY = 'cherry',          // 樱花树
  MAPLE = 'maple',            // 枫树
  BAMBOO = 'bamboo',          // 竹子
  PALM = 'palm',              // 棕榈树
  RARE_GOLDEN = 'rare_golden', // 稀有金色树
}

/**
 * 树木数据接口
 */
export interface Tree {
  id: string;
  type: TreeType;
  name: string;
  emoji: string;
  plantedAt: number;        // 种植时间戳
  focusMinutes: number;     // 专注时长 (分钟)
  isWithered: boolean;      // 是否枯萎
  level: number;            // 树木等级
}

/**
 * 树种信息
 */
export interface TreeSeed {
  type: TreeType;
  name: string;
  emoji: string;
  unlockMinutes: number;    // 解锁所需专注分钟数
  color: string;
}

/**
 * 森林统计
 */
export interface ForestStats {
  totalTrees: number;
  healthyTrees: number;
  witheredTrees: number;
  totalFocusMinutes: number;
  treeTypes: Map<TreeType, number>;
}

/**
 * 树木模型单例
 */
export class TreeModel {
  private static instance: TreeModel;
  private context: common.UIAbilityContext | null = null;
  private pref: preferences.Preferences | null = null;
  
  // 树木数据
  private trees: Tree[] = [];
  private totalFocusMinutes: number = 0;
  
  // 树种配置
  private readonly treeSeeds: TreeSeed[] = [
    {
      type: TreeType.SEEDLING,
      name: '幼苗',
      emoji: '🌱',
      unlockMinutes: 0,
      color: '#8BC34A',
    },
    {
      type: TreeType.PINE,
      name: '松树',
      emoji: '🌲',
      unlockMinutes: 100,
      color: '#2E7D32',
    },
    {
      type: TreeType.OAK,
      name: '橡树',
      emoji: '🌳',
      unlockMinutes: 300,
      color: '#4CAF50',
    },
    {
      type: TreeType.CHERRY,
      name: '樱花树',
      emoji: '🌸',
      unlockMinutes: 500,
      color: '#FFB7C5',
    },
    {
      type: TreeType.MAPLE,
      name: '枫树',
      emoji: '🍁',
      unlockMinutes: 800,
      color: '#FF5722',
    },
    {
      type: TreeType.BAMBOO,
      name: '竹子',
      emoji: '🎋',
      unlockMinutes: 1000,
      color: '#66BB6A',
    },
    {
      type: TreeType.PALM,
      name: '棕榈树',
      emoji: '🌴',
      unlockMinutes: 1500,
      color: '#81C784',
    },
    {
      type: TreeType.RARE_GOLDEN,
      name: '金色传说树',
      emoji: '🌟',
      unlockMinutes: 3000,
      color: '#FFD700',
    },
  ];
  
  private constructor() {}
  
  /**
   * 获取单例实例
   */
  static getInstance(): TreeModel {
    if (!TreeModel.instance) {
      TreeModel.instance = new TreeModel();
    }
    return TreeModel.instance;
  }
  
  /**
   * 初始化
   */
  async initialize(context: common.UIAbilityContext): Promise<void> {
    this.context = context;
    
    try {
      // 加载偏好设置
      this.pref = await preferences.getPreferences(context, 'focus_forest_tree');
      
      // 加载树木数据
      await this.loadTrees();
      
      hilog.info(DOMAIN, TAG, 'TreeModel initialized, trees loaded: %{public}d', this.trees.length);
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Initialize error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
  
  /**
   * 加载树木数据
   */
  private async loadTrees(): Promise<void> {
    if (!this.pref) return;
    
    try {
      const treesJson = this.pref.get('trees', '[]') as string;
      this.trees = JSON.parse(treesJson);
      
      this.totalFocusMinutes = this.pref.get('totalFocusMinutes', 0) as number;
      
      hilog.info(DOMAIN, TAG, 'Loaded %{public}d trees, total focus: %{public}d minutes', 
        this.trees.length, this.totalFocusMinutes);
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Load trees error: %{public}s', JSON.stringify(error) ?? '');
      this.trees = [];
      this.totalFocusMinutes = 0;
    }
  }
  
  /**
   * 保存树木数据
   */
  private async saveTrees(): Promise<void> {
    if (!this.pref) return;
    
    try {
      const treesJson = JSON.stringify(this.trees);
      this.pref.put('trees', treesJson);
      this.pref.put('totalFocusMinutes', this.totalFocusMinutes);
      
      await this.pref.flush();
      hilog.debug(DOMAIN, TAG, 'Trees saved successfully');
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Save trees error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
  
  /**
   * 种植新树
   */
  async plantTree(treeType: TreeType, focusMinutes: number): Promise<Tree> {
    const seed = this.treeSeeds.find(s => s.type === treeType);
    if (!seed) {
      throw new Error('Invalid tree type');
    }
    
    const newTree: Tree = {
      id: `tree_${Date.now()}`,
      type: treeType,
      name: seed.name,
      emoji: seed.emoji,
      plantedAt: Date.now(),
      focusMinutes: focusMinutes,
      isWithered: false,
      level: 1,
    };
    
    this.trees.push(newTree);
    this.totalFocusMinutes += focusMinutes;
    
    await this.saveTrees();
    
    hilog.info(DOMAIN, TAG, 'Planted new tree: %{public}s', treeType);
    
    return newTree;
  }
  
  /**
   * 枯萎树木 (专注失败)
   */
  async witherTree(treeId: string): Promise<void> {
    const tree = this.trees.find(t => t.id === treeId);
    if (tree) {
      tree.isWithered = true;
      await this.saveTrees();
      hilog.info(DOMAIN, TAG, 'Withered tree: %{public}s', treeId);
    }
  }
  
  /**
   * 获取所有树木
   */
  getTrees(): Tree[] {
    return [...this.trees];
  }
  
  /**
   * 获取健康树木
   */
  getHealthyTrees(): Tree[] {
    return this.trees.filter(t => !t.isWithered);
  }
  
  /**
   * 获取枯萎树木
   */
  getWitheredTrees(): Tree[] {
    return this.trees.filter(t => t.isWithered);
  }
  
  /**
   * 获取可用树种 (已解锁的)
   */
  getAvailableSeeds(): TreeSeed[] {
    return this.treeSeeds.filter(s => s.unlockMinutes <= this.totalFocusMinutes);
  }
  
  /**
   * 获取所有树种
   */
  getAllSeeds(): TreeSeed[] {
    return [...this.treeSeeds];
  }
  
  /**
   * 获取森林统计
   */
  getForestStats(): ForestStats {
    const stats: ForestStats = {
      totalTrees: this.trees.length,
      healthyTrees: this.getHealthyTrees().length,
      witheredTrees: this.getWitheredTrees().length,
      totalFocusMinutes: this.totalFocusMinutes,
      treeTypes: new Map<TreeType, number>(),
    };
    
    // 统计每种树木数量
    this.trees.forEach(tree => {
      const count = stats.treeTypes.get(tree.type) || 0;
      stats.treeTypes.set(tree.type, count + 1);
    });
    
    return stats;
  }
  
  /**
   * 获取专注总时长
   */
  getTotalFocusMinutes(): number {
    return this.totalFocusMinutes;
  }
  
  /**
   * 增加专注时长
   */
  async addFocusMinutes(minutes: number): Promise<void> {
    this.totalFocusMinutes += minutes;
    await this.saveTrees();
    hilog.info(DOMAIN, TAG, 'Added %{public}d focus minutes, total: %{public}d', minutes, this.totalFocusMinutes);
  }
  
  /**
   * 检查树种是否解锁
   */
  isSeedUnlocked(treeType: TreeType): boolean {
    const seed = this.treeSeeds.find(s => s.type === treeType);
    if (!seed) return false;
    return this.totalFocusMinutes >= seed.unlockMinutes;
  }
  
  /**
   * 获取树木等级 (根据专注时长)
   */
  getTreeLevel(focusMinutes: number): number {
    if (focusMinutes >= 120) return 5;   // 大师
    if (focusMinutes >= 60) return 4;    // 专家
    if (focusMinutes >= 30) return 3;    // 高级
    if (focusMinutes >= 15) return 2;    // 中级
    return 1;                             // 初级
  }
}

// 导出单例实例
export const treeModel = TreeModel.getInstance();
