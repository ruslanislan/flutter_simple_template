import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class NavigatorModel extends ChangeNotifier {
  late final GoRouter goRouter;

  final List<Item> items = [
    const Item(
      asset: 'assets/png/icons/quiz.png',
      text: 'Quiz',
      path: '/',
    ),
    const Item(
      asset: 'assets/png/icons/store.png',
      text: 'Store',
      path: '/store',
    ),
    const Item(
      asset: 'assets/png/icons/collections.png',
      text: 'Collections',
      path: '/collection',
    ),
    const Item(
      asset: 'assets/png/icons/setting.png',
      text: 'Settings',
      path: '/settings',
    ),
  ];

  int _selected = 0;

  int get selected => _selected;

  set selected(int value) {
    if(value == _selected) return;
    _selected = value;
    notifyListeners();
    goRouter.go(items[_selected].path);
  }
}
class Item {
  final String asset;
  final String text;
  final String path;

  const Item({
    required this.asset,
    required this.text,
    required this.path,
  });
}