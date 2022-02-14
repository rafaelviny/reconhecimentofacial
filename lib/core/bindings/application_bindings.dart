import 'package:app/services/reconhecimento_facial_service.dart';
import 'package:get/get.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(() => ReconhecimentoFacialService(), permanent: true);
  }
}
