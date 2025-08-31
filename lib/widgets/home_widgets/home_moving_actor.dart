// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/constants/my_image.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class HomeMovingActor extends StatelessWidget {
  const HomeMovingActor({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..rotateY(math.radians(20)),
      child: LottieBuilder.asset(MyImage.actorImageJson,height: context.screenHeight*.4,),
    );
  }
}
