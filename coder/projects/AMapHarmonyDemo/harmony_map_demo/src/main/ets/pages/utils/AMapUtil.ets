import { LatLng } from "@amap/amap_lbs_map3d";
import { LatLonPoint } from "@amap/amap_lbs_search";
import { ChString } from "./ChString";
import { ArrayList } from "@kit.ArkTS";

export class AMapUtil {
  //路径规划方向指示和图片对应
  public static getDriveActionID(actionName: string) {
    if (!actionName || actionName === "") {
      return $r("app.media.dir3");
    }
    if ("左转" === actionName) {
      return $r("app.media.dir2");
    }
    if ("右转" === actionName) {
      return $r("app.media.dir1");
    }
    if ("向左前方行驶" === actionName || "靠左" === actionName) {
      return $r("app.media.dir6");
    }
    if ("向右前方行驶" === actionName || "靠右" === actionName) {
      return $r("app.media.dir5")
    }
    if ("向左后方行驶" === actionName || "左转调头" === actionName) {
      return $r("app.media.dir7");
    }
    if ("向右后方行驶" === actionName) {
      return $r("app.media.dir8");
    }
    if ("直行" === actionName) {
      return $r("app.media.dir3");
    }
    if ("减速行驶" === actionName) {
      return $r("app.media.dir4");
    }
    return $r("app.media.dir3");
  }

  public static getWalkActionID(actionName: string) {
    if (actionName == null || actionName === "") {
      return $r("app.media.dir13");
    }
    if ("左转" === actionName) {
      return $r("app.media.dir2");
    }
    if ("右转" === actionName) {
      return $r("app.media.dir1");
    }
    if ("向左前方" === actionName || "靠左" === actionName || actionName.includes("向左前方")) {
      return $r("app.media.dir6");
    }
    if ("向右前方" === actionName || "靠右" === actionName || actionName.includes("向右前方")) {
      return $r("app.media.dir5");
    }
    if ("向左后方" === actionName || actionName.includes("向左后方")) {
      return $r("app.media.dir7");
    }
    if ("向右后方" === actionName || actionName.includes("向右后方")) {
      return $r("app.media.dir8");
    }
    if ("直行" === actionName) {
      return $r("app.media.dir3");
    }
    if ("通过人行横道" === actionName) {
      return $r("app.media.dir9");
    }
    if ("通过过街天桥" === actionName) {
      return $r("app.media.dir11");
    }
    if ("通过地下通道" === actionName) {
      return $r("app.media.dir10");
    }
    return $r("app.media.dir13");
  }

  /**
   * 把集合体的LatLonPoint转化为集合体的LatLng
   */
  public static convertArrList(shapes: ArrayList<LatLonPoint>) {
    let lineShapes = new ArrayList<LatLng>();
    for (let point of shapes) {
      let latLngTemp = AMapUtil.convertToLatLng(point);
      lineShapes.add(latLngTemp);
    }
    return lineShapes;
  }

  /**
   * 把LatLonPoint对象转化为LatLon对象
   */
  public static convertToLatLng(latLonPoint: LatLonPoint) {
    return new LatLng(latLonPoint?.getLatitude(), latLonPoint?.getLongitude());
  }

  public static getFriendlyTime(second: number) {
    if (second > 3600) {
      const hour = Math.floor(second / 3600);
      const miniate = Math.floor((second % 3600) / 60);
      return hour + "小时" + miniate + "分钟";
    }
    if (second >= 60) {
      const miniate = Math.floor(second / 60);
      return miniate + "分钟";
    }
    return second + "秒";
  }

  public static getFriendlyLength(lenMeter: number) {
    if (lenMeter > 10000) // 10 km
    {
      const dis = Math.floor(lenMeter / 1000);
      return dis + ChString.Kilometer;
    }

    if (lenMeter > 1000) {
      const dis = lenMeter / 1000;
      const dstr = Math.round(dis * 10) / 10
      return dstr + ChString.Kilometer;
    }

    if (lenMeter > 100) {
      const dis = Math.floor(lenMeter / 50) * 50;
      return dis + ChString.Meter;
    }

    let dis = Math.floor(lenMeter / 10) * 10;
    if (dis == 0) {
      dis = 10;
    }

    return dis + ChString.Meter;
  }

  public static getRailwayTime(time: string) {
    return time.substring(0, 2) + ":" + time.substring(2, time.length);
  }
}