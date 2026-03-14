//GeoFence
export interface ReduceResult {
    lat: Float64Array;
    lon: Float64Array;
}
export function reducerDouglas(lat: Float64Array | Float32Array, lon: Float64Array | Float32Array, threshold: number): ReduceResult;
