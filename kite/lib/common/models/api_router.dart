class ApiRouter {

  String host = "kite.kagi.com";
  String categories = "kite.json";

  Uri uriForCategories() {
    return uriForPath(categories);
  }

  Uri uriForPath(String path) {
    return Uri.https(host, path);
  }

}