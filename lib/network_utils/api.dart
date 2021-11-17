import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qstar/screen/register/model/hobbies.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
class Network {
  final String _url = 'https://qstar.mindethiopia.com/api/';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  // ignore: prefer_typing_uninitialized_variables
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();

    token = localStorage.getString('token');
  }

  authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);
    return await http.post(uri, body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);

    await _getToken();
    print("inside gett datatatat");
    print(token);
    print(_setHeaders().toString());
    return await http.get(uri, headers: _setHeaders());
  }
    uploadFile(apiUrl,file,stream,length) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);
      await _getToken();
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll(_setFileHeaders());
    request.fields["_method"]="put";
    var multipartFile = new http.MultipartFile('profile_picture', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    return await request.send();
  }
  getpassedData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    var uri = Uri.parse(fullUrl);

    await _getToken();
    return await http.post(uri, body: jsonEncode(data), headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      _setFileHeaders() => {
        'Content-type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
}
