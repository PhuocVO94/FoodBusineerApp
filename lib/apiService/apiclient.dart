import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
   final String appBaseUrl;
   late Map<String, String> _mainHeaders;

  ApiClient(  {required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = Duration(seconds: 30);
    token = "";
    _mainHeaders = {
       'Content': 'application/json; charset=UTF-8',
      'Authorization': 'Beared $token'
    };
  }
  Future<Response> getData(String uri) async {
    try {
      Response response  = await get(uri);
          return response;
    }catch(e) {
      return Response(statusCode: 1, statusText: e.toString() );
    }
  }

}