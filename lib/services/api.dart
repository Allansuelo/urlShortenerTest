import 'package:http/http.dart' as http;
import 'dart:convert';

const aliasApiUrl = "https://url-shortener-server.onrender.com/api/alias";

abstract class JSONable {
  String toJson();
}

class AliasToCreate extends JSONable {
  String url = "";

  AliasToCreate(this.url);
  @override
  String toJson() {
    Map<String, String> data = {"url": url};
    return json.encode(data);
  }
}

Future<http.Response> getAlias(String id) async{
  var url = Uri.parse('$aliasApiUrl/$id');
  return await http.get(url, headers: {
    "Access-Control-Allow-Origin": "*",
    'Content-Type': 'application/json',
  });
}

Future<http.Response> createAlias(AliasToCreate alias) async {
  var url = Uri.parse(aliasApiUrl);
  return await http.post(url,
      body: alias.toJson(), headers: {"Content-Type": "application/json"});
}