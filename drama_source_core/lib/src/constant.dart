/*
 * @File     : constant.dart
 * @Author   : jade
 * @Date     : 2024/8/23 上午11:22
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
class Constant {
  //快進時間單位
  static final int INTERVAL_SEEK = 10 * 1000;

  //控件隱藏時間
  static final int INTERVAL_HIDE = 5 * 1000;

  //網路偵測間隔
  static final int INTERVAL_TRAFFIC = 500;

  //點播爬蟲時間
  static final int TIMEOUT_VOD = 30 * 1000;

  //直播爬蟲時間
  static final int TIMEOUT_LIVE = 30 * 1000;

  //節目爬蟲時間
  static final int TIMEOUT_EPG = 5 * 1000;

  //節目爬蟲時間
  static final int TIMEOUT_XML = 15 * 1000;

  //播放超時時間
  static final int TIMEOUT_PLAY = 15 * 1000;

  //解析預設時間
  static final int TIMEOUT_PARSE_DEF = 15 * 1000;

  //嗅探超時時間
  static final int TIMEOUT_PARSE_WEB = 15 * 1000;

  //直播解析時間
  static final int TIMEOUT_PARSE_LIVE = 10 * 1000;

  //同步超時時間
  static final int TIMEOUT_SYNC = 2 * 1000;

  //传送超時時間
  static final int TIMEOUT_TRANSMIT = 60 * 1000;

  //搜尋線程數量
  static final int THREAD_POOL = 5;

  static final int DOWNLOAD_OUTER_TYPE = 1;

  static final int DOWNLOAD_INNER_TYPE = 2;

  //下载类型
  static final int THUNDER_DOWNLOAD_TYPE = 0; // 迅雷下载类型

  static final int JIANPIAN_DOWNLOAD_TYPE = 1; // 荐片下载类型
  static final int M3U8_DOWNLOAD_TYPE = 2; // M3U8下载类型


  static final int CUSTOM_DOWNLOAD_TYPE = 3; // 自定义下载类型


  static final int DOWNLOAD_CONNECTION = 0; // 连接中
  static final int DOWNLOAD_LOADING = 1; // 下载中
  static final int DOWNLOAD_SUCCESS = 2; //下载完成
  static final int DOWNLOAD_FAIL = 3; //失败
  static final int DOWNLOAD_STOP = 4; //停止
  static final int DOWNLOAD_WAIT = 5; //等待


  //开启下载消息类型
  static final int DOWNLOAD_UPDATE_MESSAGE_TYPE = 0; // 更新下载信息
  static final int DOWNLOAD_Success_MESSAGE_TYPE = 1; // 更新完成下载
}