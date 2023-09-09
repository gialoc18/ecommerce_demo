import 'package:http/http.dart' as http;
import 'package:ecommerce_demo/env.dart';

class HttpService{

  Uri? url;
  HttpService({Uri? url, String? accessToken}){
    this.url = url ?? Uri.https(AppEnvironment.redirectUrl, AppEnvironment.gameApiUrl);

  }

 post({Object? body, Map<String, String>? headers,Map<String, dynamic>? parameter,}) async {
    return await http.post(Uri.https(AppEnvironment.redirectUrl, AppEnvironment.gameApiUrl, parameter), body: body, headers: headers,);
  }

  get({Map<String, dynamic>? body, Map<String, String>? headers}) async {
  return await http.get(Uri.https(AppEnvironment.redirectUrl, AppEnvironment.gameApiUrl, body),headers: headers);
  }
}