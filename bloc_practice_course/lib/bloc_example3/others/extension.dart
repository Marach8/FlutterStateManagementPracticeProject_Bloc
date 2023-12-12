import 'dart:math' as math;
import 'package:async/async.dart' show StreamGroup;


extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}


extension StartWith<T> on Stream<T>{
  Stream<T> startWith(T value) => StreamGroup.merge([this, Stream<T>.value(value)]);
}