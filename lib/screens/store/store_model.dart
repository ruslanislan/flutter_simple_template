import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_template/models/hint.dart';
import 'package:flutter_simple_template/services/preference_service.dart';
import 'package:flutter_simple_template/utils/utils.dart';

class StoreModel extends ChangeNotifier {
  final PreferenceService preferenceService;

  int _selected = -1;
  int counter = 1;
  int coins = 0;

  int randomHintCount = 0;
  int selectedHintCount = 0;
  int wordHintCount = 0;
  int level = 0;
  bool premium = false;

  StoreModel(this.preferenceService) {
    randomHintCount = preferenceService.getRandomHintCount();
    selectedHintCount = preferenceService.getSelectedHintCount();
    wordHintCount = preferenceService.getWordHintCount();
    coins = preferenceService.getCoins();
    level = preferenceService.getLevel();
    premium = preferenceService.getPremium();
    final dateTimeData = preferenceService.getLastUpdated();
    lastUpdated = DateTime.parse(dateTimeData);
  }

  int get selected => _selected;

  set selected(int value) {
    if (value == _selected) return;
    _selected = value;
    counter = 1;
    notifyListeners();
  }

  Hint? get selectedHint => selected == -1 ? null : hints[selected];

  final hints = [
    Hint(
      id: 0,
      price: 10,
      text: 'Opens random letter',
      widget: Text(
        '?',
        style: AppThemes.helper3,
      ),
    ),
    Hint(
      id: 1,
      price: 15,
      text: 'Opens selected letter',
      widget: Image.asset(
        'assets/png/icons/pencil.png',
        width: 20.w,
        height: 20.h,
      ),
    ),
    Hint(
      id: 2,
      price: 50,
      text: 'Opens whole word',
      widget: Text(
        'aA',
        style: AppThemes.helper3,
      ),
    ),
  ];

  void decrement() {
    counter--;
    notifyListeners();
  }

  void increment() {
    counter++;
    notifyListeners();
  }

  int getCount(index) {
    switch (index) {
      case 0: return randomHintCount;
      case 1: return selectedHintCount;
      case 2: return wordHintCount;
      default: return 0;
    }
  }

  void buy() {
    if (selectedHint == null) return;
    coins -= selectedHint!.price * counter;
    preferenceService.setCoins(coins);
    switch (selected) {
      case 0:
        randomHintCount += counter;
        preferenceService.setRandomHintCount(randomHintCount);
        break;
      case 1:
        selectedHintCount += counter;
        preferenceService.setSelectedHintCount(selectedHintCount);
        break;
      case 2:
        wordHintCount += counter;
        preferenceService.setWordHintCount(wordHintCount);
        break;
      default:
        break;
    }
    if (coins < selectedHint!.price) {
      selected = -1;
    }
    notifyListeners();
  }

  void useRandomHint() {
    randomHintCount -= 1;
    preferenceService.setRandomHintCount(randomHintCount);
    notifyListeners();
  }

  void useSelectedHint() {
    selectedHintCount -= 1;
    preferenceService.setSelectedHintCount(selectedHintCount);
    notifyListeners();
  }

  void useWordHint() {
    wordHintCount -= 1;
    preferenceService.setWordHintCount(wordHintCount);
    notifyListeners();
  }

  void completeQuiz(){
    level++;
    coins += 20;
    preferenceService.setLevel(level);
    preferenceService.setCoins(coins);
  }

  void buyPremium(){
    premium = true;
    preferenceService.setPremium();
  }

  void getDailyMoney() {
    if(!premium) return;
    coins+=100;
    preferenceService.setCoins(coins);
    preferenceService.setLastUpdated();
    lastUpdated = DateTime.now();
    notifyListeners();
  }

  bool get canTake =>
      DateTime.now().day != lastUpdated.day ||
          DateTime.now().year != lastUpdated.year ||
          DateTime.now().month != lastUpdated.month;

  DateTime lastUpdated = DateTime.now();
}
