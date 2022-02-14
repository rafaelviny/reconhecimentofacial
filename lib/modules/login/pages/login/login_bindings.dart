import 'package:app/services/reconhecimento_facial_service.dart';
import 'package:get/get.dart';
import './login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(() => ReconhecimentoFacialService(), permanent: true);
    Get.put(LoginController());
  }
}
