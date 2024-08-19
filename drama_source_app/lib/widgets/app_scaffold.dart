/*
 * @File     : app_scaffold.dart
 * @Author   : jade
 * @Date     : 2024/08/19 04:34:36
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;
  const AppScaffold({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
             decoration:  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(FileUtil.getWall(Setting.getWall())),
                  fit: BoxFit.cover),
            ),
          
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
