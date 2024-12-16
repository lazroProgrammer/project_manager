import 'package:riverpod/riverpod.dart';
import 'package:tasks/core/settings.dart';

final darkmodeNotifier =
    StateNotifierProvider<DarkmodeNotifier, bool>((ref) => DarkmodeNotifier());

class DarkmodeNotifier extends StateNotifier<bool> {
  DarkmodeNotifier() : super(SettingsData().darkmode);
  void toggleDarkmode(bool v) {
    SettingsData().update(darkTheme: v);
    state = v;
  }
}
