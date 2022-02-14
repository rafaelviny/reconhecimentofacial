import 'package:get/get.dart';
import './funcionario_controller.dart';

class FuncionarioBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(FuncionarioController());
  }
}
