import 'package:riverpod/riverpod.dart';

enum TwentyOneDate{
  none, ongoing, done
}

final dateProvider = StateNotifierProvider((ref) => DateProvider(TwentyOneDate.none));

class DateProvider extends StateNotifier{
  DateProvider(super.state);

  void start() {
    state = TwentyOneDate.ongoing;
  }

  void finishCycle() {
    state = TwentyOneDate.done;
  }

  void done() {
    state = TwentyOneDate.none;
  }
}