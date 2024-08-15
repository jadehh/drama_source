/*
 * @Author: jadehh
 * @Date: 2024-08-14 14:02:24
 * @LastEditTime: 2024-08-14 14:02:26
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\download\views\ajv_result_screen.dart
 * 
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'json_viewer.dart';

class AjvResultScreen extends StatelessWidget {
  const AjvResultScreen(this.jsonString, {super.key, this.notRoot = false});

  final String jsonString;
  final bool notRoot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Ajv Result')),
        body: SafeArea(
          child: SingleChildScrollView(
              //child: JsonViewerWidget(json.decode(jsonString), notRoot: notRoot )
              child: JsonViewerRoot(
            jsonObj: json.decode(jsonString),
            expandDeep: 4,
          )),
        ));
  }
}





