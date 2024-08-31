/*
 * @Author: jadehh
 * @Date: 2024-08-20 10:01:41
 * @LastEditTime: 2024-08-20 11:06:45
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\widgets\cards\live_room_card.dart
 * 
 */

import 'package:drama_source_app/widgets/cards/shadow_card.dart';
import 'package:drama_source_app/widgets/net_image.dart';
import 'package:flutter/material.dart';

class LiveRoomCard extends StatelessWidget {
  const LiveRoomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      // onTap: () {
      //   AppNavigator.toLiveRoomDetail(site: site, roomId: item.roomId);
      // },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: NetImage(
                  "",
                  fit: BoxFit.fill,
                  height: 120,
                  width: double.infinity,
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 25,
                child: Text('文本',
                      textAlign: TextAlign.left, // 文本居中对齐
                      style: TextStyle(
                          backgroundColor: Colors.green,
                          color: Colors.white, fontSize: 12)),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8)),
              ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "name",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
