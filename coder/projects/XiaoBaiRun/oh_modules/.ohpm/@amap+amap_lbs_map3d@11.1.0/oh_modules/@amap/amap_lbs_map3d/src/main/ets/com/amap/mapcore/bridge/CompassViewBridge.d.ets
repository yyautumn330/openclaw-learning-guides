// @keepTs
// @ts-nocheck
import { u107, v107, w107, x107, y107, z107 } from '../interface/bridge/ICompassViewBridge';
import image from '@ohos.multimedia.image';
import matrix4 from '@ohos.matrix4';
export declare class k12 implements u107 {
    private d108?;
    private e108?;
    private f108?;
    private g108?;
    private h108?;
    i108(visible: boolean): void;
    j108(resource: Resource | image.PixelMap): void;
    k108(matrix: matrix4.Matrix4Transit): void;
    c15(event?: TouchEvent | undefined): void;
    d15(oldValue: Area, newValue: Area): void;
    l108(change: v107): void;
    m108(click?: w107 | undefined): void;
    x13(c108?: x107 | undefined): void;
    w13(b108?: y107 | undefined): void;
    v13(a108?: z107): void;
}
