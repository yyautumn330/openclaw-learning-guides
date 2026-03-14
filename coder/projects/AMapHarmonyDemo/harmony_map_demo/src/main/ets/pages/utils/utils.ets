import { intl } from "@kit.LocalizationKit";

export class utils{

  public static queryFirstInterval = 5;
  public static queryInterval = 5;
  public static commendDiff = 5;

  public static times(time: number): string {
    const date: Date = new Date(time * 1000)
    let shortFormat: intl.DateTimeFormat = new intl.DateTimeFormat('zh-CN', { timeStyle: 'short', hourCycle: 'h24' });
    const formattedDate = shortFormat.format(date); // formattedDate = '2021/9/17 13:04'
    return formattedDate
  }
}