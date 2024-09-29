/*
 * @Author: jadehh
 * @Date: 2024-08-19 23:40:38
 * @LastEditTime: 2024-08-20 10:33:31
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\widgets\net_image.dart
 * 
 */

import 'package:drama_source_core/drama_source_core.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ok_http/ok_http.dart';


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
    var errorImage  =  Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/res/ic_img_error.png'),
            fit: BoxFit.fill)
      ),
    );


    var loadImage  = Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/res/ic_img_loading.png'),
              fit: BoxFit.fill)
      ),
    );
    if (picUrl.isEmpty) {
      return errorImage;
    }

    var results = Utils.getPic(picUrl);


    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        imageUrl: results["pic"],
        httpHeaders: results["headers"],
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: imageProvider,
                fit: fit)
          ),
        ),
        cacheManager: HttpClientCacheManger.instance,
        placeholder: (context, url) => loadImage,
        errorWidget: (context, url, error) => errorImage,
      ),
    );
  }
}
