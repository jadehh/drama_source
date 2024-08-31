/*
 * @Author: jadehh
 * @Date: 2024-08-20 09:17:42
 * @LastEditTime: 2024-08-20 09:26:07
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\widgets\cards\adapter_vod.dart
 * 
 */
import 'dart:io';

import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';

class AdapterVod extends StatelessWidget{
  @override
  Container build(BuildContext context)  {
      return Container(
        width: 60,
        height: 100,
              decoration:  BoxDecoration(
              image: DecorationImage(
                  image: FileImage(File(FileUtil.getWall(Setting.getWall()))),
                  fit: BoxFit.cover),
            ),
        child: Positioned.fill(child: Text("123")),
      );
  }

}






