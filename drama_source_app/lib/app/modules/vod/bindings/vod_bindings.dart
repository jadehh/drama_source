import 'package:get/get.dart';

class VodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VodBinding>(() => VodBinding(), fenix: true);
  }
}
