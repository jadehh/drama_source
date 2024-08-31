/*
 * @Author: jadehh
 * @Date: 2024-08-21 17:28:43
 * @LastEditTime: 2024-08-21 17:36:39
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_core\lib\src\utils\notify.dart
 * 
 */
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class Notify {
  static String getError(String message, Object e) {
    if (e.toString().isEmpty) return message;
    return message + "\n" + e.toString();
  }

  static void progress() {
        SmartDialog.dismiss();
        SmartDialog.showLoading();
    }
}
