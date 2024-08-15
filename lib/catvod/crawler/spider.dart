/*
 * @Author: jadehh
 * @Date: 2024-08-14 14:30:01
 * @LastEditTime: 2024-08-14 14:44:34
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\catvod\crawler\spider.dart
 * 
 */

import 'dart:collection';

import 'package:flutter/material.dart';

abstract class Spider {
  void init(BuildContext? context) {}
  void initByExtend(BuildContext context, String extend) {
    init(context);
  }

  String homeContent(bool filter) {
    return "";
  }

  String homeVideoContent() {
    return "";
  }

  String categoryContent(
      String tid, String pg, bool filter, HashMap<String, String> extend) {
    return "";
  }

  String detailContent(List<String> ids)  {
        return "";
    }

  String searchContent(String key, bool quick) {
        return "";
    }


  String searchContentByPage(String key, bool quick, String pg){
        return "";
    }

    String playerContent(String flag, String id, List<String> vipFlags){
        return "";
    }

}
