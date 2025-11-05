// import 'package:flutter/material.dart';
//
//
// class CounterProvider extends ChangeNotifier{
//
//   int _count = 0;
//
//   int get count => _count;
//
//   void increment (){
//     _count++;
//     notifyListeners();
//   }
//
//
//   void decrement(){
//     _count--;
//     notifyListeners();
//   }
//
// }



// import 'package:flutter/material.dart';
//
//
// class CounterProvider extends ChangeNotifier{
//
//   int _count = 0;
//
//   int get count => _count;
//
//   void increment(){
//     _count++;
//
//     if(_count > 5){
//       _count = 0;
//     }
//     notifyListeners();
//   }
//
//   void decrement(){
//     _count--;
//     notifyListeners();
//   }
// }




// import "package:flutter/material.dart";
//
// class ToDoProvider extends ChangeNotifier{
//
//   List<String> _data =[] ;
//
//   dynamic get data => _data;
//
//   void addData(String name){
//
//       _data.add(name);
//       notifyListeners();
//
//   }
//
//   void removeData(int index){
//     print("Received index ${index}");
//     _data.removeAt(index);
//     notifyListeners();
//   }
//
//   void updateData(int index, String name){
//     print("update for update ${index} , ${name}");
//
//     if(index >= 0 && index <= _data.length){
//     _data[index] = name;
//     notifyListeners();
//     } else {
//       print("Failed to update");
//     }
//   }
//
// }


import "dart:async";

import "package:flutter/material.dart";


class ValidateProvider extends ChangeNotifier{

  String _result  = '';

  String get result => _result;


  Future<String>onClick (String name, String email, String password) async {

    final String pwd = password.toString();

    if (name.trim().isEmpty || email.trim().isEmpty || pwd.length < 3 || pwd.length > 8) {
      _result = "Invalid Credentials";
    } else if (!email.contains("@")) {
       _result = "Invalid Email";
    } else {
       _result = "Register Success";
    }
    notifyListeners();

    Timer(const Duration(seconds: 2), () {
      _result = '';
      notifyListeners();
    });

    return _result;
  }
}

