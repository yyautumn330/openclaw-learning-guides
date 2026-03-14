// @keepTs
// @ts-nocheck
import ArrayList from '@ohos.util.ArrayList';
import { BaseOptions } from './BaseOptions';
import { LatLng } from './LatLng';
/**
 * @exclude javadoc中不显示
 */
export declare abstract class BaseHoleOptions extends BaseOptions {
    isPolygonHoleOptions: boolean;
    abstract getPoints(): ArrayList<LatLng>;
}
