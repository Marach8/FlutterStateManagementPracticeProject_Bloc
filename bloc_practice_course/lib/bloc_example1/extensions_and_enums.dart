
enum PersonsUrl{persons1, persons2}

extension MapUrl on PersonsUrl{
  String get urlString {
    switch(this){
      case PersonsUrl.persons1:
        return 'http://192.168.0.167:5500/bloc_practice_course/api/persons1.json';
      case PersonsUrl.persons2:
        return 'http://192.168.0.167:5500/bloc_practice_course/api/persons2.json';
    }
  }
}


extension ReturnIndex<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}