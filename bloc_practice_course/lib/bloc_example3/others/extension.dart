import 'dart:math' as math;
import 'package:async/async.dart' show StreamGroup;


extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(
    math.Random().nextInt(length)
  );
}


extension StartWith<T> on Stream<T>{
  Stream<T> startWith(T value)
    => StreamGroup.merge(
      [this, Stream<T>.value(value)]
    );
}


extension Comparison<E> on List<E>{
  bool isEqualTo(List<E> other) {
    if (identical(this, other)){
      return true;
    }
    if (length != other.length){
      return false;
    }
    for(var i = 0; i < length; i++){
      if (this[i] != other[i]){
        return false;
      }
    }
    return true;
  }
}