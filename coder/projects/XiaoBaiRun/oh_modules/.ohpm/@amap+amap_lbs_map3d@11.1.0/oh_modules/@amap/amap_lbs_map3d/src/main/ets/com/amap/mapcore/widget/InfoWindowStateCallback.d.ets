// @keepTs
// @ts-nocheck
import { BasePointOverlay } from '../../api/model/BasePointOverlay';
import { Point } from '../../api/model/Point';
type f275 = (marker: BasePointOverlay) => void;
type g275 = (marker: BasePointOverlay, point: Point) => void;
type h275 = (marker: BasePointOverlay) => void;
type onInfoWindowAdapterChange = (adapter: CustomBuilder) => void;
type isInfoWindowShow = () => boolean;
export interface p107 {
    onInfoWindowShow: f275;
    onInfoWindowUpdate: g275;
    i14: h275;
    onInfoWindowAdapterChange: onInfoWindowAdapterChange;
    isInfoWindowShow: isInfoWindowShow;
}
export {};
