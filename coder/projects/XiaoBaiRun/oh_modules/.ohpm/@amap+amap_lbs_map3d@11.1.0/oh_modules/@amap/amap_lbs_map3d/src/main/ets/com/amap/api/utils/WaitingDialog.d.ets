// @keepTs
// @ts-nocheck
/**
 * 加载弹窗
 */
@CustomDialog
export declare struct u52 {
    @Link
    isWaiting: boolean;
    controller?: CustomDialogController;
    @State
    rotateAngle: number;
    build(): void;
}
