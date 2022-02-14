import 'package:app/services/camera.service.dart';
import 'package:app/services/facenet.service.dart';
import 'package:app/services/ml_kit_service.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class FuncionarioController extends GetxController {
  final CameraService cameraService = CameraService();
  final MLKitService mlKitService = MLKitService();
  final FaceNetService faceNetService = FaceNetService();
  CameraDescription? cameraDescription;
  Size imageSize = const Size(0, 0);

  bool detectingFaces = false;
  RxBool cameraInitializated = false.obs;
  Face? faceDetected;
  Future? initializeControllerFuture;

  bool _saving = false;

  @override
  Future<void> onInit() async {
    List<CameraDescription> cameras = await availableCameras();
    cameraDescription = cameras.firstWhere(
      (CameraDescription camera) =>
          camera.lensDirection == CameraLensDirection.front,
    );

    initializeControllerFuture = cameraService.startService(cameraDescription!);
    await initializeControllerFuture;

    await faceNetService.loadModel();
    mlKitService.initialize();

    cameraInitializated.value = true;

    frameFaces();

    super.onInit();
  }

  @override
  void dispose() {
    cameraService.dispose();
    mlKitService.dispose();
    faceNetService.dispose();
    super.dispose();
  }

  frameFaces() {
    imageSize = cameraService.getImageSize();

    cameraService.cameraController!.startImageStream((image) async {
      if (cameraService.cameraController != null) {
        if (detectingFaces) return;

        detectingFaces = true;

        try {
          List<Face> faces = await mlKitService.getFacesFromImage(image);

          if (faces.isNotEmpty) {
            faceDetected = faces[0];

            if (_saving) {
              _saving = false;
              faceNetService.setCurrentPrediction(image, faceDetected!);
            }
          } else {
            faceDetected = null;
          }

          detectingFaces = false;
        } catch (e) {
          print(e);
          // _detectingFaces = false;
        }
      }
    });
  }

  Future<bool> onShot() async {
    bool saving = false;
    if (faceDetected == null) {
      /* showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('No face detected!'),
          );
        },
      ); */

      print('No face detected!');

      return false;
    } else {
      saving = true;

      await Future.delayed(const Duration(milliseconds: 500));
      await cameraService.cameraController!.stopImageStream();
      await Future.delayed(const Duration(milliseconds: 200));
      XFile file = await cameraService.takePicture();

      /*      setState(() {
        _bottomSheetVisible = true;
        pictureTaked = true;
        imagePath = file.path;
      }); */

      return true;
    }
  }
}
