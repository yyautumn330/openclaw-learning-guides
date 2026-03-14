// @keepTs
// @ts-nocheck
export default class q46 {
    static readonly u46: string;
    /**
     * Http request success status code.
     */
    static readonly v46: number;
    /**
     * The animation delay time.
     */
    static readonly w46: number;
    /**
     * The delay time.
     */
    static readonly x46: number;
    /**
     * The animation duration.
     */
    static readonly y46: number;
    /**
     * The http timeout duration.
     */
    static readonly z46: number;
    /**
     * Content maxLine.
     */
    static readonly a47: number;
    /**
     * List space.
     */
    static readonly b47: number;
    /**
     * Item img space.
     */
    static readonly c47: number;
    /**
     * Type font weight.
     */
    static readonly d47: number;
    /**
     * Title font weight.
     */
    static readonly e47: number;
    /**
     * Desc font weight.
     */
    static readonly f47: number;
    /**
     * Type aspect ratio.
     */
    static readonly g47: number;
    /**
     * Desc opacity.
     */
    static readonly h47: number;
}
/**
 * The RefreshConstant constants.
 */
export declare const enum r46 {
    DELAY_PULL_DOWN_REFRESH = 50,
    CLOSE_PULL_DOWN_REFRESH_TIME = 150,
    DELAY_SHRINK_ANIMATION_TIME = 500
}
/**
 * The refresh state enum.
 */
export declare const enum s46 {
    DropDown = 0,
    Release = 1,
    Refreshing = 2,
    Success = 3,
    Fail = 4
}
/**
 * The newsList state enum.
 */
export declare const enum PageState {
    Loading = 0,
    Success = 1,
    Fail = 2
}
/**
 * The file upload state enum.
 */
export declare const enum t46 {
    COMPLETE = "complete",
    FAIL = "fail"
}
/**
 * The request method enum.
 */
export declare const enum RequestMethod {
    POST = "POST",
    GET = "GET"
}
/**
 * The request content type enum.
 */
export declare const enum ContentType {
    JSON = "application/json",
    FORM = "multipart/form-data"
}
