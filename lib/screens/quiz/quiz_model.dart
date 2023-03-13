import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_simple_template/screens/screens.dart';
import 'package:flutter_simple_template/utils/crypto_coins.dart';

class QuizModel extends ChangeNotifier {
  final StoreModel storeModel;
  String word = '';
  String targetWord = '';
  final Map<int, String> lettersMap = {};
  List<Map<int, String>> targetLetters = [];
  bool _canUseHint = true;
  bool usingSelectedHint = false;

  String get _wordFromTargetLetters => targetLetters.fold(
      '', (previousValue, element) => previousValue + element.values.first);

  bool get canUseHint => _canUseHint;

  bool get canClear => targetLetters.any(
      (element) => element.values.first != '' && element.values.length < 2);

  set canUseHint(bool value) {
    if (_canUseHint == value) return;
    _canUseHint = value;
    notifyListeners();
  }

  QuizModel(this.storeModel) {
    generateLevel(storeModel.level);
  }

  void selectLetter(int index, {int? cellIndex}) {
    var letter = lettersMap[index];
    if (letter == null || letter.isEmpty) return;
    var emptyCellIndex = cellIndex ??
        targetLetters.indexWhere((element) => element.values.first.isEmpty);
    if (emptyCellIndex == -1) return;
    targetLetters[emptyCellIndex] = {
      index: letter,
      if (cellIndex != null) 99: 'rand',
    };
    lettersMap[index] = '';
    notifyListeners();

    ///check complete level
    if (_wordFromTargetLetters == targetWord) {
      completeLevel();
    }
  }

  void generateLevel(int level) {
    final crypto = cryptoCoins[level];
    targetWord = crypto.name.toUpperCase();
    const maxValue = 12;
    word =
        targetWord + randomString(maxValue - targetWord.length).toUpperCase();

    final splintedWord = word.split('');
    splintedWord.shuffle();

    targetLetters.clear();
    lettersMap.clear();
    for (var i = 0; i < splintedWord.length; ++i) {
      var letter = splintedWord[i];
      lettersMap[i] = letter;
    }
    for (var i = 0; i < targetWord.length; ++i) {
      targetLetters.add({i: ''});
    }
    notifyListeners();
  }

  void unselect(int index) {
    if (usingSelectedHint) {
      usingSelectedHint = false;
      storeModel.useSelectedHint();
      useRandomHint(index2: index);
      return;
    }
    var map = targetLetters[index];
    if (map.values.first.isEmpty) return;
    var key = map.keys.first;
    var value = map.values.first;
    lettersMap[key] = value;
    targetLetters[index] = {index: ''};
    notifyListeners();
  }

  Future<void> useRandomHint({int? index2}) async {
    List<int> indexes = [];
    for (var i = 0; i < targetLetters.length; ++i) {
      var map = targetLetters[i];
      var values = map.values.toList();
      if (values[0] == targetWord[i]) continue;
      if (values.length > 1) continue;
      indexes.add(i);
    }
    if (indexes.isEmpty) return;
    indexes.shuffle();

    if (index2 != null) {
      indexes.remove(index2);
    }
    int index = index2 ?? indexes.first;

    var targetLetter = targetWord[index];
    int newIndex = -1;

    var list = lettersMap.values.toList();
    for (var i = 0; i < list.length; ++i) {
      var letter = list[i];
      if (letter == targetLetter) {
        newIndex = i;
        break;
      }
    }
    if (newIndex == -1) {
      for (var i = 1; i < indexes.length; ++i) {
        var item = targetLetters[indexes[i]];
        if (item.values.first == targetLetter) {
          newIndex = indexes[i];
          break;
        }
      }
      if (newIndex == -1) return;
      var item1 = targetLetters[index];
      targetLetters[index] = targetLetters[newIndex]..addAll({99: ''});
      targetLetters[newIndex] = item1;
      notifyListeners();
      return;
    }

    unselect(index);
    selectLetter(newIndex, cellIndex: index);
    storeModel.useRandomHint();
  }

  void useSelectedHint() {
    usingSelectedHint = !usingSelectedHint;
  }

  void useWordHint() {
    for (var i = 0; i < targetWord.length; ++i) {
      unselect(i);
      useRandomHint(index2: i);
    }
    storeModel.useWordHint();
  }

  void clear() {
    final index = targetLetters.lastIndexWhere(
        (element) => element.values.first != '' && element.values.length < 2);
    if (index == -1) return;
    unselect(index);
  }

  static const _alphabet = "abcdefghiklmnopqrstuvwxyz";

  String randomString(int n) {
    const length = _alphabet.length;
    String string = "";
    for (int i = 0; i < n; i++) {
      string += _alphabet[Random().nextInt(length)];
    }
    return string;
  }

  Future<void> completeLevel() async {
    await Future.delayed(const Duration(milliseconds: 300));
    storeModel.completeQuiz();
    generateLevel(storeModel.level);
  }
}
