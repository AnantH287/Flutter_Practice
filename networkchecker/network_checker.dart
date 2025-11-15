import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker extends StatefulWidget {
  const NetworkChecker({super.key});

  @override
  State<NetworkChecker> createState() => _NetworkCheckerState();
}

class _NetworkCheckerState extends State<NetworkChecker> {

  // Connectivity()onConnectivityChanged.listen((ConnectivityResult result){
  //
  // })
  bool inOnline = true;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   checkConnectionState();
  //
  //   Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
  //     if (result == ConnectivityResult.none) {
  //       setState(() {
  //         inOnline = false;
  //       });
  //     } else {
  //       setState(() {
  //         inOnline = true;
  //       });
  //     }
  //   });
  // }
  @override
  void initState() {
    super.initState();

    checkConnectionState();

    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {

      final bool isDisconnected = result.contains(ConnectivityResult.none);

      setState(() {
        inOnline = !isDisconnected;
      });

      if (!isDisconnected) {
        checkNetWorker();
      }
    });
  }

  Future<void> checkConnectionState() async {
    final List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    setState(() {
      inOnline = !result.contains(ConnectivityResult.none);
    });
  }

  Future<List<Map<String,dynamic>>>checkNetWorker() async{
    try{  
        final url  = Uri.parse("https://jsonplaceholder.typicode.com/posts");
        final response  = await http.get(url);
        if(response.statusCode == 200){
          final result  = List<Map<String, dynamic>>.from(jsonDecode(response.body)) ;
          return result;
        } else {
          print("Failed to Fetch");
          return [];
        }
    } catch(e){
      print("Failed to fetch ${e}");
      return [];
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Network Checker",style: TextStyle(color: Colors.white, fontFamily: "Roboto"),),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black54,
        actions: [
          Icon(Icons.network_cell, color: Colors.red,),
          SizedBox(width: 15,),
        ],
      ),
      body: Stack(
        children: [

          Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Map<String,dynamic>>>(
                  future: checkNetWorker(),
                  builder: (context, snapshot){
                    if(snapshot.hasError){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snapshot.error.toString())));
                    } else if (snapshot.connectionState == ConnectionState.waiting){
                      return   Center(child: CircularProgressIndicator(),);
                    }
                    final data = snapshot.data;
                    return ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (context, index){
                          final items  = data[index];
                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(child: Text(items['title'],style: TextStyle(color: Colors.black,fontSize: 14,), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                                Chip(
                                  label:Text(items["id"].toString(), style: TextStyle(color: Colors.black),),
                                  backgroundColor: Colors.grey,
                                )
                              ],
                            ),
                          );
                        });
                  },
                ),
              )
            ],
          ),
          if (!inOnline)
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3,   // horizontal blur strength
                sigmaY: 3,   // vertical blur strength
              ),
              child: Container(
                color: Colors.black.withOpacity(0.10), // slight dark overlay
                width: double.infinity,
                height: double.infinity,
              ),
            ),

          if(!inOnline)...[
            Positioned(
              top: 30,
                left: 0,
                right: 0,
                child:Center(
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                        borderRadius: BorderRadius.circular(10)
                  ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text("You're Offline", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  )

                )
            )
          ]
        ],
      ),
    );
  }
}
