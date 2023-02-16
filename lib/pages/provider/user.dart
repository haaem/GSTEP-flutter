import 'package:riverpod/riverpod.dart';

final userProvider = StateNotifierProvider((ref) => UserProvider(['unknown']));

class UserProvider extends StateNotifier {
  UserProvider(super.state);

  void setName(String name) {
    state[0] = name;
  }
}