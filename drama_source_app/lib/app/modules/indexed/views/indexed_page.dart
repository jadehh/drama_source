import 'package:drama_source_app/app/modules/indexed/controllers/indexed_controller.dart';
import 'package:drama_source_app/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class IndexedPage extends GetView<IndexedController> {
  const IndexedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return AppScaffold(
          child:  controller.getBodyWidgets(orientation),
          bottomView: controller.getNavNuttomView(orientation),
        );
      });
  }
}
