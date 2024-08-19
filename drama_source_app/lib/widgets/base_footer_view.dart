/*
 * @Author: jadehh
 * @Date: 2024-08-19 16:33:04
 * @LastEditTime: 2024-08-19 16:33:08
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \drama_source\drama_source_app\lib\widgets\base_footer_view.dart
 * 
 */
/*
 * @Author: jadehh
 * @Date: 2024-08-16 13:14:05
 * @LastEditTime: 2024-08-16 13:14:07
 * @LastEditors: jadehh
 * @Description: 
 * @FilePath: \dramasource\lib\page\widgets\base_footer_view.dart
 * 
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseFooterView extends StatelessWidget {
  const BaseFooterView( {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(builder: (BuildContext context, LoadStatus? mode) { 
          Widget body ;
            if(mode==LoadStatus.idle){
              body =   Text("pull up load",style: Theme.of(context).textTheme.bodySmall);
            }
            else if(mode==LoadStatus.loading){
              body =  const CupertinoActivityIndicator(color: Colors.white);
            }
            else if(mode == LoadStatus.failed){
              body =  Text("Load Failed!Click retry!",style: Theme.of(context).textTheme.bodySmall);
            }
            else if(mode == LoadStatus.canLoading){
              body =  Text("release to load more",style: Theme.of(context).textTheme.bodySmall);
            }
            else{
              body =  Text("No more Data",style: Theme.of(context).textTheme.bodySmall);
            }
            return Center(child:body);
         });
  }
}





