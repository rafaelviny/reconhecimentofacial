import 'package:app/services/camera.service.dart';
import 'package:app/services/facenet.service.dart';
import 'package:app/services/ml_kit_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ReconhecimentoFacialService {
  final CameraService cameraService = CameraService();
  final MLKitService mlKitService = MLKitService();
  final FaceNetService faceNetService = FaceNetService();
  CameraDescription? cameraDescription;
  Size imageSize = const Size(0, 0);

  bool detectingFaces = false;
  RxBool cameraInitializated = false.obs;
  Face? faceDetected;
  Future? initializeControllerFuture;

  Future<void> onInit() async {
    List<CameraDescription> cameras = await availableCameras();
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

/*     initializeControllerFuture = cameraService.startService(cameraDescription!);
    await initializeControllerFuture; */

    await faceNetService.loadModel();
    mlKitService.initialize();

    /*    cameraInitializated.value = true; */
  }

  void dispose() {
    cameraService.dispose();
    mlKitService.dispose();
    faceNetService.dispose();
  }
}
