// @keepTs
// @ts-nocheck
import { Marker } from '../../api/model/Marker';
import { IAMap } from '../interface/IAMap';
import { m211 } from './ISensorEventHelper';
export declare class p212 implements m211 {
    private static readonly TAG;
    static readonly w212: number;
    private static readonly x212;
    private y212;
    private mContext?;
    private g102?;
    private z212?;
    private a213?;
    private b213?;
    /**
      * 旋转地图还是旋转Marker
     */
    private c213;
    constructor(context: Context, u212?: IAMap, v212?: (angle: number) => void);
    n211(): void;
    o211(): void;
    p211(marker?: Marker): void;
    q211(q212: boolean): void;
    /**
     * 获取当前屏幕旋转角度
     *
     * @param context
     * @return 0表示是竖屏; 90表示是左横屏; 180表示是反向竖屏; 270表示是右横屏
     */
    private static d213;
}
