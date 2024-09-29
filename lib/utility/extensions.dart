extension AsyncWhere<T> on Stream<T> {
  Stream<T> asyncWhere(Future<bool> Function(T) test) async* {
    await for (var element in this) {
      if(await test(element)) yield element;
    }
  }
}
