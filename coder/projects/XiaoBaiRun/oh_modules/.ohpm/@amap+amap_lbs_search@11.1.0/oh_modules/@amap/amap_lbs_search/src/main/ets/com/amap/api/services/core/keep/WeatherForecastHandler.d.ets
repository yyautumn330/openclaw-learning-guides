// @keepTs
// @ts-nocheck
import { LocalWeatherForecast } from "../../weather/LocalWeatherForecast";
import { WeatherSearchQuery } from "../../weather/WeatherSearchQuery";
import { b7 } from "./BasicLBSRestHandler";
export declare class f53 extends b7<WeatherSearchQuery, LocalWeatherForecast> {
    constructor(context: Context, task: WeatherSearchQuery);
    getQuery(): WeatherSearchQuery | undefined;
    k6(): string;
    protected n6(json: string): LocalWeatherForecast | undefined;
    protected m6(): string;
}
