import 'package:demo/Components/posts/BloC/posts_bloc.dart';
import 'package:dio/dio.dart';

class ApiService{

  final String apiUrl;

  ApiService({required this.apiUrl});

  static final Dio dio = Dio();


  static Future<Map<String, dynamic>> loginApi({
    required String email,
    required String password,
  }) async {

    print("Calling login API with email: $email, password: $password");

    try {
      final response = await dio.post(
        "http://192.168.1.165:3003/logins",
        data: {
          "email": email,
          "password": password,
        },
      );

      print("api response ${response.data}");

      if (response.statusCode == 200) {
        return {
          "success": true,
          "token": response.data["token"],
          "user": response.data["user"],
        };
      } else {
        return {
          "success": false,
          "message": "Invalid response from server"
        };
      }
    } catch (e) {
      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

 static Future<Map<String, dynamic>> fetchApi()async{

  try{
    final response = await dio.get("https://dummyjson.com/users");

    print("in api service page response ${response.data.runtimeType}");

    if(response.statusCode ==  200){
      return {
        "success":true,
        "data" : response.data,
      };
    }
    else{
      return{
        "sucess":false,
        "data":null,
         };
       }
    } catch(e){
      return{
      "success":false,
      "data":e.toString(),
      };
  }
}

}