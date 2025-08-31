import 'package:flutter/material.dart';
import 'package:ui_challenge_01/constants/my_contant.dart';

class HomeBottomList extends StatelessWidget {
  const HomeBottomList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  "https://picsum.photos/200/300",
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 10),
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
                Icon(Icons.lightbulb_outline, color: Colors.red),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
