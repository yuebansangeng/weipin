import 'dart:async';

Timer? timer;

Function throttle(
  Function func, {
  Duration delay = const Duration(milliseconds: 400),
}) {
  target(args) {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
    timer ??= Timer(delay, () {
      func?.call(args);
      timer?.cancel();
      timer = null;
    });
  }

  return target;
}
