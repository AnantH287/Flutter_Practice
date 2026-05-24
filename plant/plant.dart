import 'package:demo/Bloc/Bloc.dart';
import 'package:demo/Bloc/Event.dart';
import 'package:demo/Bloc/State.dart';
import 'package:demo/Utils/app_constantsd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Plant extends StatefulWidget {
  const Plant({super.key});

  @override
  State<Plant> createState() => _PlantState();
}

class _PlantState extends State<Plant> {

  String? selectedType;
  int currentIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    print("Intistate");
    context.read<PlantBloc>().add(PlantAttempt());
    super.initState();
  }


  List<Map<String,dynamic>> filterFunction(List<Map<String,dynamic>> data){
    return data.where((i){
      final type = i['type'].toString().toLowerCase();
      final selected = selectedType?.toLowerCase() ?? "";

      final matchedRow = selected.isEmpty || type.contains(selected);
      return matchedRow;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffedf2fb),
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
      leading: Icon(Icons.arrow_back, color: Colors.black,),
        title: Text("Search Products", style: GoogleFonts.poppins(fontWeight: FontWeight.bold),),
        actions: [Padding(
            padding: EdgeInsets.only(right: 10),
            child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset(
                    AppConstants.profileIcon, width: 30, ),
                )))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: SearchBar(
                    hintText: "Search Products",
                    backgroundColor:MaterialStateProperty.all(Colors.white),
                    hintStyle:MaterialStateProperty.all(GoogleFonts.poppins(color: Colors.black)),
                  )),
                  SizedBox(width: 20,),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        AppConstants.sliderIcon,
                        height: 30,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              BlocBuilder<PlantBloc,PlantState>(
                  builder: (context,state){

                    final loading = state is PlantLoading;
                    final value = state is PlantSuccess ? state.plantData : List.generate(6, (index)=>{
                      "image":AppConstants.plant,
                      "name":"loading",
                      "price":"\$0",
                      "stock":"loading"
                    });

                    final categories = value.map((i)=>i["type"].toString()).toSet().toList();
                    final filterData = filterFunction(value);
                    print("Imgggggg $value");
                    return Expanded(
                      child: Column(
                        children: [
                          if(state is PlantSuccess)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: categories.map((i) {
                                  final isSelected = selectedType == i;

                                  return Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: ChoiceChip(
                                      label: Text(
                                        i,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color:
                                          isSelected ? Colors.white : Colors.black,
                                        ),
                                      ),

                                      selected: isSelected,

                                      selectedColor: Colors.green,

                                      backgroundColor: Colors.white,

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),

                                      side: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),

                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),

                                      onSelected: (value) {
                                        setState(() {

                                          if (value) {
                                            selectedType = i;
                                          } else {
                                            selectedType = null;
                                          }

                                        });
                                      },
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          Expanded(
                            child: Skeletonizer(
                              enabled: loading,
                              child: GridView.builder(
                                  itemCount: filterData.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemBuilder: (context,index){
                                    final result = filterData[index];
                                    return Card(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child:
                                                SizedBox(
                                                    width:double.infinity,
                                                    child: Image.asset(result['image'], fit: BoxFit.cover,))),
                                            Text(result['name'], style: GoogleFonts.actor(fontSize: 20, fontWeight: FontWeight.bold),),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(result['price'], style: GoogleFonts.poppins(color: Colors.green, fontSize: 16),),
                                                Text(result['stock'] ?? "", style: GoogleFonts.mochiyPopPOne(color: Colors.red, fontSize: 10),),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                      
                            ),
                          ),
                        ],
                      ),
                    );

                  })

            ],
          ),
        )
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   backgroundColor: Colors.grey,
      //     selectedItemColor: Colors.orange,
      //     unselectedItemColor: Colors.white,
      //     onTap: (value){
      //     setState(() {
      //       currentIndex = value;
      //     });
      //       print("valueeeeeeeeee $value");
      //     },
      //     items: [
      //       BottomNavigationBarItem(icon: Icon(Icons.add,), label:"ttt",) ,
      //       BottomNavigationBarItem(icon: Icon(Icons.tab), label:"tte"),
      //     ]),
    );
  }
}
