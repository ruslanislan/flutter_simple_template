import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  final SharedPreferences preferences;

  PreferenceService(this.preferences);

  static const randomHintKey = 'randomHintKey';
  static const selectedHintKey = 'selectedHintKey';
  static const wordHintKey = 'wordHintKey';
  static const coinsKey = 'coinsKey';
  static const levelKey = 'levelKey';
  static const premiumKey = 'premiumKey';
  static const _lastUpdatedKey = "LAST_UPDATED_KEY";

  int getRandomHintCount() {
    return preferences.getInt(randomHintKey) ?? 1;
  }

  int getSelectedHintCount() {
    return preferences.getInt(selectedHintKey) ?? 1;
  }

  int getWordHintCount() {
    return preferences.getInt(wordHintKey) ?? 1;
  }

  int getCoins() {
    return preferences.getInt(coinsKey) ?? 30;
  }

  int getLevel() {
    return preferences.getInt(levelKey) ?? 0;
  }

  bool getPremium() {
    return preferences.getBool(premiumKey) ?? false;
  }

  FutureOr<void> setRandomHintCount(int value) async {
    await preferences.setInt(randomHintKey, value);
  }

  FutureOr<void> setSelectedHintCount(int value) async {
    await preferences.setInt(selectedHintKey, value);
  }

  FutureOr<void> setWordHintCount(int value) async {
    await preferences.setInt(wordHintKey, value);
  }

  FutureOr<void> setCoins(int value) async {
    await preferences.setInt(coinsKey, value);
  }

  FutureOr<void> setLevel(int value) async {
    await preferences.setInt(levelKey, value);
  }

  FutureOr<void> setPremium() async {
    await preferences.setBool(premiumKey, true);
  }

  Future<void> setLastUpdated() async {
    await preferences.setString(
        _lastUpdatedKey, DateTime.now().toIso8601String());
  }

  String getLastUpdated() {
    return preferences.getString(_lastUpdatedKey) ??
        DateTime.now().subtract(const Duration(days: 1)).toIso8601String();
  }
}
