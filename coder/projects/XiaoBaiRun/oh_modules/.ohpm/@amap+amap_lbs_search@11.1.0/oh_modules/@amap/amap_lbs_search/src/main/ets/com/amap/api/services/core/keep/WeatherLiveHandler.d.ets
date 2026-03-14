// @keepTs
// @ts-nocheck
import { LocalWeatherLive } from "../../weather/LocalWeatherLive";
import { WeatherSearchQuery } from "../../weather/WeatherSearchQuery";
import { b7 } from "./BasicLBSRestHandler";
export declare class i53 extends b7<WeatherSearchQuery, LocalWeatherLive> {
    constructor(context: Context, task: WeatherSearchQuery);
    getQuery(): WeatherSearchQuery | undefined;
    k6(): string;
    protected n6(json: string): LocalWeatherLive | undefined;
    protected m6(): string;
}
