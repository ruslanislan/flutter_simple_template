import 'package:flutter/material.dart';

class Hint {
  final int id;
  final int price;
  final String text;
  final Widget widget;

  Hint({
    required this.id,
    required this.price,
    required this.text,
    required this.widget,
  });
}