// @keepTs
// @ts-nocheck
import { w167 } from '../../interface/IUnzipItem';
import { z167 } from '../../interface/IUnZipListener';
import { w193 } from './IDownloadListener';
/**
 *
 * @author zxy94400
 * @date 2016/3/7
 * 下载和解压目前放在一起
 */
export interface u181 extends w193, w167, z167 {
    /**
     * 下载链接
     *
     * @return
     */
    getUrl(): string;
    /**
     * 检查Sdk是否充足
     *
     * @return
     */
    m185(): boolean;
    /**
     * 下载保存位置
     *
     * @return
     */
    n185(): string;
    /**
     * 唯一标识，如果是离线地图是这个值为adCode
     * @return
     */
    getId(): string;
}
