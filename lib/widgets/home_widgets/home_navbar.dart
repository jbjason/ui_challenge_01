import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/media_query_extension.dart';
import 'package:ui_challenge_01/constants/my_color.dart';
import 'package:ui_challenge_01/constants/my_image.dart';

class HomeNavbar extends StatelessWidget {
  const HomeNavbar(
      {super.key, required this.currentPage, required this.onPageChange});
  final int currentPage;
  final Function onPageChange;

  @override
  Widget build(BuildContext context) {
    final width = context.screenWidth / 3;
    return SizedBox(
      height: kBottomNavigationBarHeight * 1.1,
      child: Row(
        children: [
          SizedBox(
            width: width,
            child:
                _getNavBarItem(index: 0, img: MyImage.homeIcon, width: width),
          )
        ],
      ),
    );
  }

  Widget _getNavBarItem(
      {required int index, required String img, required double width}) {
    return GestureDetector(
      onTap: () => onPageChange(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            color: index == currentPage ? Colors.red : MyColor.logBackColor,
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }
}
