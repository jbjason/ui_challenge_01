// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

class DailyGoal {
  final String title;
  final String value;
  final Color color;
  final String image;
  const DailyGoal({
    required this.title,
    required this.value,
    required this.color,
    required this.image,
  });

  DailyGoal copyWith({
    String? title,
    String? value,
    Color? color,
    String? image,
  }) {
    return DailyGoal(
      title: title ?? this.title,
      value: value ?? this.value,
      color: color ?? this.color,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'value': value,
      'color': color.value,
      'image': image,
    };
  }

  factory DailyGoal.fromMap(Map<String, dynamic> map) {
    return DailyGoal(
      title: map['title'].toString(),
      value: map['value'].toString(),
      color: Color(map['color'] as int),
      image: map['image'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyGoal.fromJson(dynamic source) =>
      DailyGoal.fromMap(source as Map<String, dynamic>);
}
