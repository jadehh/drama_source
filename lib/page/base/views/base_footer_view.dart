/*
 * @File     : custom_footer_view
 * @Author   : jade
 * @Date     : 2024/08/12 10:32:26
 * @Email    : jadehh@1ive.com
 * @Software : Samples
 * @Desc     :
 */

import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BaseFooterView extends StatelessWidget {
  const BaseFooterView( {super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(builder: (BuildContext context, LoadStatus? mode) { 
          Widget body ;
            if(mode==LoadStatus.idle){
              body =  const Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  const CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = const Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
              body = const Text("release to load more");
            }
            else{
              body = const Text("No more Data");
            }
            return Center(child:body);
         });
  }
}




