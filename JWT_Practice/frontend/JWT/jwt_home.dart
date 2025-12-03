import 'dart:convert';

import 'package:demo/Screens/JWT/LoginScreen.dart';
import 'package:demo/Screens/JWT/indoor_screen.dart';
import 'package:demo/Screens/JWT/out_door.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JwtHomeScreen extends StatefulWidget {
  final String token;

  const JwtHomeScreen({super.key, required this.token});

  @override
  State<JwtHomeScreen> createState() => _JwtHomeScreenState();
}

class _JwtHomeScreenState extends State<JwtHomeScreen> {

  final Dio dio = Dio();

  String message = '';
 final DateTime select = DateTime.now();

  Future<Map<String,dynamic>> checkToken(token) async{

    print("indoor fontend triggered  ");

    try{

    final reponse = await dio.get("http://192.168.1.165:3003/indoor",
    options: Options(
      headers: {
        "authorization":"Bearer $token",
      }
    )
    );

    print("indoor fontend response ${reponse.data}");

    final result = reponse.data;

    if( reponse.statusCode== 200){
      return{
        "status":true,
        "message":result['message'],
      };
    } else {
      return{
        "status":false,
        "message":result['message'],
      };
    }
  } catch(e){
      return{
        "status":false,
        "message":e.toString(),
      };
    }
  }

  String receivedToken ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("JWT Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login Successful 🎉",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              const Text("Your JWT Token:", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                widget.token,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blue),
              ),
              const SizedBox(height: 40),

              // Buttons
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () async{
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString("token");
                    print("cooooooooooo ${token}");
                
                   setState(() {
                    receivedToken = token ?? "";
                   });
                    
                    if(token == null || token.isEmpty){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    } 
                    
                    if(token != null){

                      print("mmmmmmmmmmmmmm");

                    final results = await checkToken(token);

                    if(results['status'] == true){

                     Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => IndoorScreen(token: token),
                        ),
                      );

                    } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(results['message'])));
                    } 
                  }
                  },
                  child:  Center(child: Text("Go to Indoor Screen", style: TextStyle(color: Colors.white),)),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  final token = prefs.getString("token");
                  print("Toooooooooooo ${token}");
                  setState(() {
                    receivedToken = token ?? "";
                  });
                  if(token == null || token.isEmpty){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OutdoorScreen(token: token),
                      ),
                    );
                  }
                },
                child: const Text("Go to Outdoor Screen"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
