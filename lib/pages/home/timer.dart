import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class DDayTimer extends StatefulWidget {
  const DDayTimer({Key? key}) : super(key: key);

  @override
  State<DDayTimer> createState() => _DDayTimerState();
}

class _DDayTimerState extends State<DDayTimer> {
  final stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    presetMillisecond: StopWatchTimer.getMilliSecFromHour(24*21),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

