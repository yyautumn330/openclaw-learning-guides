// @keepTs
// @ts-nocheck
import { e9 } from '../CityObject';
import { v208 } from './ICityState';
export declare abstract class w181 implements v208 {
    private z208;
    u208: e9;
    constructor(x208: number, y208: e9);
    getId(): number;
    setId(id: number): void;
    equal(state: w181): boolean;
    a209(): void;
    t208(w208: w181): void;
    k184(): void;
    /**
     * 实现为了增加log
     */
    start(): void;
    /**
     * 实现为了增加log
     */
    i184(): void;
    /**
     * 实现为了增加log
     */
    pause(): void;
    /**
     * 实现为了增加log
     */
    delete(): void;
    /**
     * 实现为了增加log
     */
    fail(type: number): void;
    /**
     * 实现为了增加log
     */
    p184(): void;
    /**
     * 实现为了增加log
     */
    complete(): void;
}
