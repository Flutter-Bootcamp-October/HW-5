checkAuth({required List<String> key, required Map body}) {
  List<String> errorKey = [];

  for (var keys in key) {
    if (!body.containsKey(keys)) {
      errorKey.add(keys);
    }
  }
  if (errorKey.isNotEmpty) {
    throw FormatException("The body should have this keys $errorKey");
  }
  if (key.length != body.keys.length) {
    throw FormatException("The body should have this keys $key");
  }
}
