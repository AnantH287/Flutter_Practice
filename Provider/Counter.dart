// import 'package:demo/Screens/Provider/COunterProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Counter extends StatefulWidget {
//   const Counter({super.key});
//
//   @override
//   State<Counter> createState() => _CounterState();
// }
//
// class _CounterState extends State<Counter> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     final counter = Provider.of<CounterProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         title: Text('Counter App',style: TextStyle(color: Colors.white, fontSize: 20),),
//       ),
//       body: Center(
//         child: Text("Count : ${counter.count}",
//           style: const TextStyle(fontSize: 28),
//         ),
//       ),
//       floatingActionButton: Row(
//         children: [
//           FloatingActionButton(onPressed: (){
//             counter.increment();
//           },
//           child: Icon(Icons.add),
//           ),
//           FloatingActionButton(onPressed: (){
//             counter.decrement();
//           },
//           child: Icon(Icons.remove),
//           )
//         ],
//       ),
//     );
//   }
// }

//
// import 'package:demo/Screens/Provider/COunterProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Counter extends StatelessWidget {
//   const Counter({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//     final counter = Provider.of<CounterProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Second Counter App"),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text("Count ${counter.count}"),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 100,
//                 child: ElevatedButton(onPressed: (){
//                     counter.increment();
//                   }, child: Icon(Icons.add),),
//                 ),
//                 SizedBox(
//                   height: 100,
//                   child: ElevatedButton(onPressed: (){
//                     counter.decrement();
//                   }, child: Icon(Icons.remove),),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:demo/Screens/Provider/COunterProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class Counter extends StatefulWidget {
//   const Counter({super.key});
//
//   @override
//   State<Counter> createState() => _CounterState();
// }
//
// class _CounterState extends State<Counter> {
//
//    int? indexR;
//    TextEditingController NameController = TextEditingController();
//
//    @override
//    void dispose() {
//     NameController.dispose();
//     super.dispose();
//   }
//    @override
//   Widget build(BuildContext context) {
//
//     final provider = Provider.of<ToDoProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.pink,
//         title: Text("ToDo List", style: TextStyle(color: Colors.white),),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             SizedBox(height: 30,),
//             Padding(
//               padding: EdgeInsetsGeometry.all(10),
//               child: TextField(
//                 controller: NameController,
//                 decoration: InputDecoration(
//                   labelText: "Name",
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.black),
//                     borderRadius: BorderRadius.circular(10),
//                   )
//                 )
//               ),
//             ),
//             SizedBox(height: 10,),
//             SizedBox(
//               width: 100,
//               child: Row(
//                 children: [
//                   MaterialButton(
//                     onPressed: (){
//                       if(NameController.text.trim().isNotEmpty){
//                         provider.addData(NameController.text);
//                         NameController.clear();
//                       }
//                     },
//                     child: Text("Add Name"),
//                   ),
//                 ],
//               ),
//             ),
//
//
//             SizedBox(height: 10,),
//             Expanded(
//               child: ListView.builder(
//                   itemCount: provider.data.length,
//                   itemBuilder: (context, index){
//                 return ListTile(
//                   title: Text(provider.data[index], style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold),),
//                   trailing: SizedBox(
//                     width: 100, // You can adjust this width as needed
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         IconButton(
//                             onPressed: (){
//                               provider.removeData(index);
//                             },
//                             icon: Icon(Icons.remove_circle, color: Colors.red,size: 20,)
//                         ),
//                       ],
//
//                     ),
//                   ),
//
//                 );
//               }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:demo/Screens/Provider/COunterProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter extends StatelessWidget {
   Counter({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<ValidateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: Text("Register Page", style: TextStyle( color: Colors.white),),
      ),

      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsetsGeometry.all(10),
              child: Column(
                children: [
                  TextField(
                    controller:nameController,
                    decoration: InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.pink),
                        )
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller:emailController,
                    decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.pink),
                        )
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller:passwordController,
                    decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.pink),
                        )
                    ),
                  ),
                  SizedBox(height: 10,),

                  ElevatedButton(onPressed: (){
                    provider.onClick(nameController.text,emailController.text,passwordController.text);
                  }, child: Text("Register"))
                ],
              ),
            ),
          ),
          if (provider.result.isNotEmpty)
            Positioned(
              // top: 20,
              left: 20,
              right: 20,
              bottom: 20,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: provider.result == "Register Success" ? Colors.greenAccent :Colors.redAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  provider.result,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
