// @keepTs
// @ts-nocheck
import { IPoint } from '../utils/overlay/IPoint';
import { BaseOverlay } from './BaseOverlay';
import { LatLng } from './LatLng';
export declare abstract class BasePointOverlay extends BaseOverlay {
    /**
     * @param overlayName
     * @exclude javadoc中不显示
     */
    constructor(f22: string);
    /**
     * 获取 Marker 覆盖物的位置坐标。
     *
     * @return Marker 覆盖物的位置坐标。
     * @since 2.0.0
     */
    abstract getPosition(): LatLng;
    abstract getId(): string;
    abstract setPosition(e22: LatLng): void;
    abstract setTitle(title: string): void;
    abstract getTitle(): string;
    abstract getSnippet(): string;
    abstract setSnippet(snippet: string): void;
    abstract setVisible(visible: boolean): void;
    abstract isVisible(): boolean;
    abstract setObject(object: object): void;
    abstract getObject(): object | undefined;
    abstract setRotateAngle(rotate: number): void;
    abstract getRotateAngle(): number;
    abstract destroy(): void;
    abstract remove(): void;
    abstract showInfoWindow(): void;
    abstract isInfoWindowEnable(): boolean;
    abstract setGeoPoint(d22: IPoint): void;
}
