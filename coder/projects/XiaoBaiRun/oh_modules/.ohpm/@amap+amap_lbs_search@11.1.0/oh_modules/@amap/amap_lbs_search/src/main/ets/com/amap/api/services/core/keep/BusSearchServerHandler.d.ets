// @keepTs
// @ts-nocheck
import { b7 } from "./BasicLBSRestHandler";
import ArrayList from "@ohos.util.ArrayList";
import { SuggestionCity } from "../SuggestionCity";
import { BusLineResult } from "../../busline/BusLineResult";
import { BusStationResult } from "../../busline/BusStationResult";
export declare class k8<T> extends b7<T, Object> {
    private itemCount;
    private f3;
    private t8;
    constructor(context: Context, s8: T);
    getQuery(): T;
    u8(): number;
    k6(): string;
    protected n6(json: string): BusLineResult | BusStationResult | undefined;
    z8(): ArrayList<string>;
    getSearchSuggestionCities(): ArrayList<SuggestionCity>;
    protected m6(): string;
}
