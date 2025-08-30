import 'package:flutter/material.dart';

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
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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
              children: [
                SizedBox(
                  width: 100,
                  height: 120,
                  child: Image.network("https://picsum.photos/200/300"),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                          "A Simple way to start your day with a good breakfast"),
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
