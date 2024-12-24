import 'package:http/http.dart' as http;

// import '../models/user_info.dart';
// import '../services/api_helper.dart';
import '../services/api_response.dart';
import '../services/shared_pref_helper.dart';

class UpdateUserController {
  // late ApiResponse _apiResponse;
  // final ApiBaseHelper _helper = ApiBaseHelper();

  Future<ApiResponse> updateUserController({
    required String name,
    required dynamic image,
  }) async {
    String? token = await SharedPreferencesHelper.getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.MultipartRequest(
      //http://palmail.gazawar.wiki/api https://palmail.gsgtt.tech/api
        'POST', Uri.parse('http://palmail.gazawar.wiki/api/user/update'));
    request.fields.addAll({'name': name});
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return ApiResponse.completed(response);
    } else {
      print(response.reasonPhrase);
      return ApiResponse.error('Errorrr');
    }
  }

  Future<ApiResponse> updateNameController({
    required String newName,
  }) async {
    print(1);
    String? token = await SharedPreferencesHelper.getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    print(2);

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://palmail.gazawar.wiki/api/user/update'));
    request.fields.addAll({'name': newName});
    print(3);

    request.headers.addAll(headers);
    print(4);

    http.StreamedResponse response = await request.send();
    print(5);

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(6);

      print(await response.stream.bytesToString());
      return ApiResponse.completed(response);
    } else {
      print(response.reasonPhrase);
      return ApiResponse.error('Errorrr');
    }
  }
}

    // _apiResponse = ApiResponse.loading('Featching data');
    // String? token = await SharedPreferencesHelper.getUserToken();
    // var headers = {
    //   'Authorization': 'Bearer $token',
    //   'Accept': 'application/json'
    // };
    // var response = await http.post(
    //     Uri.parse('https://palmail.gsgtt.tech/api/user/update'),
    //     headers: headers,
    //     body: {
    //       'name': name,
    //       'image': image,
    //     });
    // try {
    //   if (response.statusCode == 200) {
    //     var _apiResponse = userInfoFromJson(response.body);
    //     return ApiResponse.completed(_apiResponse);
    //   }
    // } catch (e) {
    //   var _apiResponse = ApiResponse.error('Errorrrr');
    //   return _apiResponse;
    // }
    // return _apiResponse;


    
  // Future<ApiResponse> updateUserController({
  //   required String name,
  //   required dynamic image,
  // }) async {
  //   _apiResponse = ApiResponse.loading('Featching data');
  //   String? token = await SharedPreferencesHelper.getUserToken();

  //   var headers = {'Authorization': 'Bearer $token'};

  //   var response = await _helper.post(
  //     "/user/update",
  //     {
  //       'name': name,
  //       'image': image,
  //     },
  //     headers,
  //   );
  //   var updateUser = UserInfo.fromJson(response);
  //   _apiResponse = ApiResponse.completed(updateUser);

  //   return _apiResponse;
  // }