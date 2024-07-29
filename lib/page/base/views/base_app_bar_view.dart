/*
 * @File     : base_app_bar_view
 * @Author   : jade
 * @Date     : 2024/07/29 01:49:08
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseAppBarView extends StatelessWidget {
  final String title;
  const BaseAppBarView(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CupertinoNavigationBarBackButton(color: Colors.white),
          Expanded(child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 24),
          )),
          const SizedBox(width: 50),
        ]
      ),
    );
  }
}





