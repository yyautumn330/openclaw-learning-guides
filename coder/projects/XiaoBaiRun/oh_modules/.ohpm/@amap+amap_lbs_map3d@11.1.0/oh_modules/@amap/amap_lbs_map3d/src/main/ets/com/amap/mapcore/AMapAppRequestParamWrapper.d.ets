// @keepTs
// @ts-nocheck
import { w52 } from './AMapAppRequestParam';
import { ResourceCallback } from './ResourceCallback';
export declare class AMapAppRequestParamWrapper {
    param: w52;
    callback?: ResourceCallback;
    constructor(param: w52);
    generateCallback(): void;
}
