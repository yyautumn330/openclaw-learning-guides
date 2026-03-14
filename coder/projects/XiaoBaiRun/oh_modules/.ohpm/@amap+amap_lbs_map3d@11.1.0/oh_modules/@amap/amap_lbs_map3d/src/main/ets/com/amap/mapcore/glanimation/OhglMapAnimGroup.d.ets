// @keepTs
// @ts-nocheck
import { i137 } from './AbstractOhglAnimation';
import { v138 } from './AbstractOhglAnimationParam1V';
import { e139 } from './AbstractOhglAnimationParam2V';
export declare class q140 extends i137 {
    static readonly b144: number;
    static readonly c144: number;
    static readonly d144: number;
    static readonly e144: number;
    constructor(duration: number);
    setDuration(duration: number): void;
    reset(): void;
    isValid(): boolean;
    n144(z143: number, type: number): void;
    o144(x143: number, y143: number, type: number): void;
    /**
     * no mid level
     *
     * @param toMaplevel
     * @param type
     */
    p144(w143: number, type: number): void;
    t144(t143: number, u143: number, v143: number): void;
    v144(s143: number, type: number): void;
    static r144(level: number): boolean;
    private s144;
    private u144;
    f142(param: Object): void;
    u137(param: Object): void;
    f141(t142: q140): boolean;
    protected b142: boolean;
    protected f144: boolean;
    protected h144: boolean;
    protected j144?: v138;
    protected k144?: v138;
    protected q144: number;
    protected w144: number;
    protected x144: number;
    g141: boolean;
    protected a142?: e139;
    protected g144: boolean;
    protected i144?: v138;
    protected m144: boolean;
    protected l144?: v138;
}
