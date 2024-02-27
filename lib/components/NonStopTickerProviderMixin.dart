import 'package:flutter/scheduler.dart';

mixin NonStopTickerProviderMixin implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}
