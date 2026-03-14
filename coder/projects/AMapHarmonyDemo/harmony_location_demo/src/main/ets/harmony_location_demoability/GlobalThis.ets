import { common } from '@kit.AbilityKit';

export class GlobalThis {
  private constructor() {
  }

  private static instance: GlobalThis;
  private _uiContexts = new Map<string, common.UIAbilityContext>();

  public static getInstance(): GlobalThis {
    if (!GlobalThis.instance) {
      GlobalThis.instance = new GlobalThis();
    }
    return GlobalThis.instance;
  }

  getContext(key: string): common.UIAbilityContext | undefined {
    return this._uiContexts.get(key);
  }

  setContext(key: string, value: common.UIAbilityContext): void {
    this._uiContexts.set(key, value);
  }

  // 其他需要传递的内容依此扩展
}