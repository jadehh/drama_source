/*
 * @Author: jadehh
 * @Date: 2024-08-19 23:40:38
 * @LastEditTime: 2024-08-20 10:33:31
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\widgets\net_image.dart
 * 
 */
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class NetImage extends StatelessWidget {
  final String picUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;
  const NetImage(this.picUrl,
      {this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.borderRadius = 0,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (picUrl.isEmpty) {
      return Image.asset(
        'assets/images/res/ic_img_error.png',
        width: width,
        height: height,
        fit: fit,
      );
    }
    var pic = picUrl;
    if (pic.startsWith("//")) {
      pic = 'https:$pic';
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: ExtendedImage.network(
        pic,
        fit: fit,
        height: height,
        width: width,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(borderRadius),
        loadStateChanged: (e) {
          if (e.extendedImageLoadState == LoadState.loading) {
            return const Icon(
              Icons.image,
              color: Colors.grey,
              size: 24,
            );
          }
          if (e.extendedImageLoadState == LoadState.failed) {
            return const Icon(
              Icons.broken_image,
              color: Colors.grey,
              size: 24,
            );
          }
          return null;
        },
      ),
    );
  }
}
