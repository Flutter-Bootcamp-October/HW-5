checkuser({required List<String> key, required Map body}) {
  if (3 <= body.keys.length) {
    throw FormatException("The body should have this keys $key");
  }
  if (!body.keys.contains("username") || !body.keys.contains("phone")) {
    throw FormatException("The body should have this keys $key");
  }
}

checkDelete({required List<String> key, required Map body}) {
  List<String> errorKey = [];
  if (body.isNotEmpty) {
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
  } else {
    throw FormatException("The body should have this keys $key");
  }
}
