// ignore_for_file: prefer_inlined_adds

import 'package:drama_source_app/app/modules/indexed/controllers/indexed_controller.dart';
import 'package:drama_source_app/app/modules/indexed/views/indexed_page.dart';
import 'package:get/get.dart';

import 'route_path.dart';

class AppPages {
  AppPages._();
  static final routes = [
    // 首页
    GetPage(
      name: RoutePath.kIndex,
      page: () => const IndexedPage(),
      bindings: [
        BindingsBuilder.put(() => IndexedController()),
        //BindingsBuilder.put(() => HomeController()),
      ],
    ),
  ];
}
