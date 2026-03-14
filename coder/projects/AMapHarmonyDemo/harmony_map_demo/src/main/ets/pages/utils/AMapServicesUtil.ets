import { LatLng } from "@amap/amap_lbs_map3d";
import { LatLonPoint } from "@amap/amap_lbs_search";
import { ArrayList } from "@kit.ArkTS";

export class AMapServicesUtil {
  public static convertToLatLonPoint(latlon: LatLng) {
    return new LatLonPoint(latlon.latitude, latlon.longitude);
  }

  public static convertToLatLng(latLonPoint: LatLonPoint) {
    return new LatLng(latLonPoint.getLatitude(), latLonPoint.getLongitude());
  }

  public static convertArrList(shapes: ArrayList<LatLonPoint>) {
    let lineShapes = new ArrayList<LatLng>();
    for (let point of shapes) {
      let latLngTemp = AMapServicesUtil.convertToLatLng(point);
      lineShapes.add(latLngTemp);
    }
    return lineShapes;
  }
}
