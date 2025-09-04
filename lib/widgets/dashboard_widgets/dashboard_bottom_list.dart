import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/my_color.dart';
import 'package:ui_challenge_01/constants/my_constant.dart';
import 'package:ui_challenge_01/constants/my_image.dart';

class DashboardBottomList extends StatelessWidget {
  const DashboardBottomList({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        children: List.generate(
          3,
          (i) => Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 15,
                  offset: Offset(5, 5),
                  color: Colors.grey.shade300,
                ),
                BoxShadow(
                  blurRadius: 30,
                  offset: Offset(-5, -5),
                  color: MyColor.backgroundColor,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // image
                DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(MyImage.natureImage)
                      ),),
                ),
                Image.asset(MyImage.natureImage),
                const SizedBox(width: 10),
                // title, subtitle & icon
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "A Simple way to start your day with a good breakfast",
                        style: TextStyle(
                          fontFamily: MyConstant.font3,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Dr Testoren",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.lightbulb, color: Colors.red),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
