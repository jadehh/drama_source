/*
 * @Author: jadehh
 * @Date: 2024-07-15 14:56:56
 * @LastEditTime: 2024-07-29 11:09:06
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\setting\bindings\language_binding.dart
 * 
 */
import 'package:get/get.dart';


class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageBinding>(() => LanguageBinding(), fenix: true);
  }
}





