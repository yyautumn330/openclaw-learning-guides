// @keepTs
// @ts-nocheck
import { CameraPosition } from '../../api/model/CameraPosition';
import { LatLng } from '../../api/model/LatLng';
import { LatLngBounds } from '../../api/model/LatLngBounds';
import { Point } from '../../api/model/Point';
import { v6 } from '../camera/AbstractCameraUpdateMessage';
export interface b7 {
    zoomIn(): v6;
    zoomOut(): v6;
    scrollBy(xPixel: number, yPixel: number): v6;
    zoomTo(zoom: number): v6;
    zoomBy(amount: number): v6;
    zoomBy(amount: number, focus?: Point): v6;
    newCameraPosition(cameraPosition: CameraPosition): v6;
    o114(geo: Point): v6;
    changeLatLng(geo: LatLng): v6;
    changeTilt(tilt: number): v6;
    changeBearing(angle: number): v6;
    changeBearingGeoCenter(angle: number, geo: Point): v6;
    changeGeoCenterZoom(geo: Point, zoom: number): v6;
    newLatLng(latLng: LatLng): v6;
    newLatLngZoom(latLng: LatLng, zoom: number): v6;
    p114(zoom: number, bearing: number, tilt: number, geoCenter: Point | LatLng): v6 | undefined;
    newLatLngBounds(bounds: LatLngBounds, padding: number): v6;
    newLatLngBoundsWithSize(bounds: LatLngBounds, width: number, height: number, padding: number): v6;
    newLatLngBoundsRect(latlngbounds: LatLngBounds, paddingLeft: number, paddingRight: number, paddingTop: number, paddingBottom: number): v6;
    j7(): v6;
}
