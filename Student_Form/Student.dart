import "package:expansion_tile_card/expansion_tile_card.dart";
import "package:flutter/material.dart";

void main(){
  runApp(Student());
}

class Student extends StatelessWidget{
  const Student({super.key});


    @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(
      iconTheme: IconThemeData(
        color: Colors.white
      ),
      title: Text("Student Details", style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.black54,

    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
              newMethod(context,"Priya", '20211061105104', "A-", "9123456780", "Madurai","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiahxkm_eZ3qtmhUEHVxhDhMRjvHBFnVaoZQ&s","400045","54673","47733"),
              newMethod(context,"Rahul", '20211061105105', "B+", "9012345678", "Coimbatore","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiahxkm_eZ3qtmhUEHVxhDhMRjvHBFnVaoZQ&s","400045","54673","47733"),
              newMethod(context,"Arjun", '20211061105103', "O+", "9876543210", "Chennai","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiahxkm_eZ3qtmhUEHVxhDhMRjvHBFnVaoZQ&s","400045","54673","47733"),
               newMethod(context,"Arthi", '20211061105101', "O-", "9876543242", "Tenkasi","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiahxkm_eZ3qtmhUEHVxhDhMRjvHBFnVaoZQ&s","400045","54673","47733"),
              newMethod(context,"Rio", '20211061105102', "O-", "98246543242", "Tirunelveli","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiahxkm_eZ3qtmhUEHVxhDhMRjvHBFnVaoZQ&s","400045","54673","47733"),

        ],
      ),
    ),
   );
  }

    ExpansionTileCard newMethod(BuildContext context,name,no,blood, number,native,image,firstSemFee,secondSemFee,thirdSemFee) {
      return ExpansionTileCard(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(image),
            ),
            title: Text(name),
            subtitle: Text(no),
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(Icons.bloodtype, color: Colors.red, size: 25,),
                    SizedBox(width: 10),
                    Text(blood, style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),
                Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(Icons.call, color: Colors.blue, size: 22,),
                    SizedBox(width: 10),
                    Text(number, style: TextStyle(fontSize: 20),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
 Icon(Icons.home, color: Colors.blue, size: 22,),
                    SizedBox(width: 10),
                    Text(native, style: TextStyle(fontSize: 22),),
                    ],
                ),
                ),
                OverflowBar(

                  children: [
                      TextButton(onPressed: (){

                      }, child: Column(
                        children: [
                          Icon(Icons.schedule),
                          SizedBox(height: 10),
                          Text("Exam Details")
                        ],
                      )),
                       TextButton(onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(

                                title: Text("Student Fee Structure"),
                                content:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("First Sem : ${firstSemFee}",style: TextStyle(color: Colors.black54, fontSize: 16),),
                                    SizedBox(height: 10,),
                                    Text("Second Sem : ${secondSemFee}",style: TextStyle(color: Colors.black54, fontSize: 16),),
                                    SizedBox(height: 10,),
                                    Text("Third Sem : ${thirdSemFee}",style: TextStyle(color: Colors.black54, fontSize: 16),)
                                  ],
                                  ),
                              );
                            });
                      }, child: Column(
                        children: [
                          Icon(Icons.money),
                          SizedBox(height: 10),
                          Text("Fees Details")
                        ],
                      )),
                       TextButton(onPressed: (){

                      }, child: Column(
                        children: [
                          Icon(Icons.schedule),
                          SizedBox(height: 10),
                          Text("Exam Details")
                        ],
                      ))
                  ],
                )
            ],);
    }
}