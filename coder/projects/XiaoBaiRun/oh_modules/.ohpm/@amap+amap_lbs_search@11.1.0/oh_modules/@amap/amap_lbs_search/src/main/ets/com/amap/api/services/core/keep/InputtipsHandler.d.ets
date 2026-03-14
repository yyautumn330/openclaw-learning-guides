// @keepTs
// @ts-nocheck
import { InputtipsQuery } from "../../help/InputtipsQuery";
import { b7 } from "./BasicLBSRestHandler";
import ArrayList from "@ohos.util.ArrayList";
import { Tip } from "../../help/Tip";
export declare class j14 extends b7<InputtipsQuery, ArrayList<Tip>> {
    constructor(context: Context, q14: InputtipsQuery);
    protected n6(json: string): ArrayList<Tip> | undefined;
    k6(): string;
    protected m6(): string;
}
