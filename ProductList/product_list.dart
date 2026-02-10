import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo/Bloc/Bloc.dart';
import 'package:demo/Bloc/Event.dart';
import 'package:demo/Bloc/State.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late final StreamSubscription<List<ConnectivityResult>> _connectivitySub;
  bool isOnline = true;
  final TextEditingController searchData = TextEditingController();

  @override
  void initState() {

    _connectivitySub =
        Connectivity().onConnectivityChanged.listen((_) async {
          final online = await hasInternet();
          if (!mounted) return;
          setState(() {
            isOnline = online;
          });
        });

    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<ProductListBloc>().add(ProductListAttempt(isOnline));
    });
    // checkConnectionState();
    super.initState();
  }


  Future<void>checkConnectionState()async{
    final List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    setState(() {
      isOnline = !result.contains(ConnectivityResult.none);
    });
  }

  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void>refreshFunction()async{
    final online = await hasInternet();

    print("Online variavleeee $online");
    setState(() {
      isOnline = online;
    });

    context.read<ProductListBloc>().add(
      ProductListAttempt(isOnline),
    );
  }

  List<Map<String,dynamic>> filterByBrand(List<Map<String,dynamic>> data){
    final search = searchData.text.toString().toLowerCase();
    return data.where((item){
      final brand = (item['brand'] ?? "").toString().toLowerCase();
      final matchedData  = search.isEmpty || brand.contains(search);
      return matchedData;
    }).toList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _connectivitySub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4a5759),
        title: Text(
          textAlign: TextAlign.center,
          "Product List",
          style: TextStyle(
            color: Colors.white,
        ),),
      ),
      body: RefreshIndicator(
        onRefresh: refreshFunction,
        child: Stack(
          children: [
             Column(
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SearchBar(
                    controller: searchData,
                    leading: Icon(Icons.search),
                    hintText: "Search brand name",
                    hintStyle: MaterialStateProperty.all(
                      TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600
                      )
                    ),
                    onChanged: (String value){
                      setState(() {
                        searchData.text = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 10,),
                BlocBuilder<ProductListBloc,ProductListState>(
                  builder: (content,state){
                    if(state is ProductListFailure){
                      print(state.error);
                    } else if(state is ProductListSuccess){
                      final data = state.productList;
                      final product = filterByBrand(data);

                      print("datatypreeeeeeee ${data.runtimeType}");
                      return
                        Expanded(
                            child: ListView.builder(
                                itemCount: product.length,
                                itemBuilder: (content,index){
                                  final products = product[index];
                                  return Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(products['id'].toString(), style: TextStyle(
                                                  color: Colors.white
                                              ),),
                                              Chip(label: Text(products['category']))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Brand : ",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Text(products['brand'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(products['rating'].toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Hurry Up Guys We have Only : ",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text(products['stock'].toString(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text(" Stocks",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                    }
                    return Expanded(
                        child: ListView(
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(height: 200),
                            Center(
                              child: Text("Pull me down to refresh"),
                            )
                          ],
                        )
                    );
                  },
                ),
              ],
            ),
            if(!isOnline)...[
              BackdropFilter(
                  filter:ImageFilter.blur(
                    sigmaX: 3,   // horizontal blur strength
                    sigmaY: 3,   // vertical blur strength
                  ),
                child: Container(
                  color: Colors.black.withOpacity(0.10), // slight dark overlay
                  width: double.infinity,
                  height: double.infinity,
                ),
              )
            ],
            if(!isOnline)...[
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
      ),
    );
  }
}
