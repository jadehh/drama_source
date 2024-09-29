/*
 * @Author: jadehh
 * @Date: 2024-08-20 10:01:41
 * @LastEditTime: 2024-08-20 11:06:45
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\widgets\cards\vod_card.dart
 * 
 */

import 'package:drama_source_app/app/app_style.dart';
import 'package:drama_source_app/widgets/cards/shadow_card.dart';
import 'package:drama_source_app/widgets/net_image.dart';
import 'package:drama_source_core/drama_source_core.dart';
import 'package:drama_source_log/drama_source_log.dart';
import 'package:flutter/material.dart';

class VodCard extends StatelessWidget {
  final SiteViewModel siteViewModel;
  final Vod vod;
  const VodCard(this.siteViewModel,this.vod,{Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowCard(
      onTap: () {
        Log.i("详情界面,id:${vod.getVodId()}");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: AppStyle.edgeInsetsA8,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: NetImage(
                    vod.getVodPic(),
                    fit: BoxFit.cover,
                    height: 160,
                    width: double.infinity,
                    borderRadius: 5,
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 25,
                  child: Text(vod.getVodRemarks(),
                      overflow: TextOverflow.ellipsis,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text(
                          vod.getVodName(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
