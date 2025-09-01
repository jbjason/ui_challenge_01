// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:ui_challenge_01/constants/my_image.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class HomeMovingActor extends StatelessWidget {
  const HomeMovingActor({super.key, required this.cameraOrbit});
  final String cameraOrbit ;

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      src: MyImage.rhinoImageGLB,
      disableZoom: true,
      disableTap: true,
      ar: false,
      autoPlay: false, 
      cameraControls: false,
      touchAction: TouchAction.none,
      cameraOrbit: cameraOrbit,
    );
  }
}
