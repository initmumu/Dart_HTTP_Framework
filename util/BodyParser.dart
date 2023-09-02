import 'dart:convert';

class BodyParser {
  static Map<String, String> urlEncodedDataParser(String urlEncodedData) {
    urlEncodedData = '?$urlEncodedData';
    return Uri.parse(urlEncodedData).queryParameters;
  }

  static Map<String, dynamic> jsonParser(String jsonFormString) {
    return jsonDecode(jsonFormString);
  }
}
