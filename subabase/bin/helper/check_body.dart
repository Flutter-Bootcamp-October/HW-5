checkBody({required List<String> Keycheck, required Map body}) {
  final List<String> KeyNotFound = [];

  for (var element in Keycheck) {
    if (!body.containsKey(element)) {
      KeyNotFound.add(element);
    }
  }
  if (Keycheck.length != body.length) {
    throw FormatException("the body shoud have $Keycheck");
  }
  if (KeyNotFound.isNotEmpty) {
    throw FormatException("the body shoud have $KeyNotFound");
  }
}