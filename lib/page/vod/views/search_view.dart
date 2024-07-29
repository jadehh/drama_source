/*
 * @File     : search_bar.dart
 * @Author   : jade
 * @Date     : 2024/07/11 07:53:42
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 10.0),
                child: TextButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print("按下热搜按钮");
                    }
                  },
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        var focused = states.any((value) {
                          return value == WidgetState.focused;
                        });
                        if (!focused) {
                          return Colors.transparent;
                        }else{
                          return  Colors.grey.withOpacity(0.1);
                        }
                      },
                    ),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0))),
                    textStyle:
                        WidgetStateProperty.all(const TextStyle(fontSize: 16)),
                    alignment: Alignment.centerLeft,
                  ),
                  child: const Text("热搜", textAlign: TextAlign.left),
                ),
              )),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // 处理搜索逻辑
                },
              ),
            ],
          ),
        ));
  }
}
