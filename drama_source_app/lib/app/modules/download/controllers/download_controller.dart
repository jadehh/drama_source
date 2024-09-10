/*
 * @File     : download_controller.dart
 * @Author   : jade
 * @Date     : 2024/9/2 13:24
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter_qjs/flutter_qjs.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class DownloadController extends GetxController{
  final TextEditingController textEditingController = TextEditingController(text: "javascript code test");
  late IsolateQjs? engine ;
  final resp = "".obs;

  ensureEngine(){
    engine = IsolateQjs(
      moduleHandler: (String module) async {
        return await rootBundle.loadString(
            "js/" + module.replaceFirst(new RegExp(r".js$"), "") + ".js");
      },
    );
  }

  eval() async{
    try {
      resp.value = (await engine!.evaluate(textEditingController.text ,
          name: "<eval>"))
        .toString();
    } catch (e) {
    resp.value = e.toString();
    }
  }

  close() {
     engine!.close();
  }
}
