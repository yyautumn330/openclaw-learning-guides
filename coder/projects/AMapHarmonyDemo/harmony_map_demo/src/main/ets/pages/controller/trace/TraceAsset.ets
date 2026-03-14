import { TraceLocation } from "@amap/amap_lbs_map3d"
import { ArrayList, util } from "@kit.ArkTS"
import { resourceManager } from "@kit.LocalizationKit"

export class TraceAsset{

  public static async parseLocationsData(rm: resourceManager.ResourceManager,
    filePath: string): Promise<ArrayList<TraceLocation>> {
    let locLists = new ArrayList<TraceLocation>()
    try {
      const fileData: Uint8Array = await rm.getRawFileContent(filePath);
      let decoder = util.TextDecoder.create('utf-8');
      let fileStr = decoder.decodeToString(fileData);
      const lines = fileStr.split(/\r?\n/);
      for (let line of lines) {
        if (!line.trim()) {
          continue;
        } // 跳过空行
        try {
          let traceItem: object = JSON.parse(line) as object ; // ArkTS 直接用 JSON.parse
          let location:TraceLocation = new TraceLocation();
          location.setLatitude(traceItem['lat']);
          location.setLongitude(traceItem['lon']);
          location.setSpeed(traceItem['speed']);
          location.setBearing(traceItem['bearing']);
          location.setTime(traceItem['loctime']);
          locLists.add(location);
        } catch (jsonErr) {
          // console.error("JSON parse error:", jsonErr);
          locLists = new ArrayList<TraceLocation>()
          break
        }
      }
    } catch (e) {
      locLists = new ArrayList<TraceLocation>()
    }

    return locLists
  }


  public static  recordNames(): string[] {
    const dir = 'traceRecord'
    try {
      const files = getContext().resourceManager.getRawFileListSync(dir) //resourceManager.getSystemResourceManager()
      return files
    } catch (e) {
      return []
    }
  }
}