// @keepTs
// @ts-nocheck
export declare class SensorManager {
    private static instance;
    private f213;
    private g213;
    private h213;
    private i213;
    private constructor();
    static getInstance(context?: Context): SensorManager;
    startListening(): void;
    stopListening(): void;
    getCurrentAngle(): number;
    addAngleListener(listener: (angle: number) => void): void;
    removeAngleListener(listener: (angle: number) => void): void;
    private j213;
    private k213;
}
