import 'package:get/get.dart';

class DownloadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DownloadBinding>(() => DownloadBinding(), fenix: true);
  }
}
