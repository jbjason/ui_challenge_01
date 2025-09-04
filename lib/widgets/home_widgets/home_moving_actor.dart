import 'package:flutter/material.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:ui_challenge_01/constants/my_constant.dart';
import 'package:ui_challenge_01/constants/my_image.dart';

class HomeMovingActor extends StatelessWidget {
  const HomeMovingActor({super.key, required this.controller});
  final Flutter3DController controller;
  @override
  Widget build(BuildContext context) {
    return Flutter3DViewer(
      controller: controller,
      enableTouch: false,
      src: MyImage.rhinoImageGLB,
      onLoad: (modelAddress) {
      //  controller.playAnimation();
        controller.setCameraOrbit(
          MyConstant.cameraOrbitList[0][0],
          MyConstant.cameraOrbitList[0][1],
          MyConstant.cameraOrbitList[0][2],
        );
      },
    );
  }
}
