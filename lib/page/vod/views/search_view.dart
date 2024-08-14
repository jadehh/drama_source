/*
 * @File     : search_bar.dart
 * @Author   : jade
 * @Date     : 2024/07/11 07:53:42
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:dramasource/theme/text_buttom_custom_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
      child: Container(
        height: 30,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextButton(
                onPressed: () {
                  if (kDebugMode) {
                    print("按下热搜按钮");
                  }
                },
                style: TextButtomCustomStyle().lightTextButtonNormalStyle(),
                child: const Text("热搜", textAlign: TextAlign.left),
              ),
            )),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                size: 18,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
