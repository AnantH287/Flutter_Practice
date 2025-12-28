import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {

  List<Map<String, dynamic>> users = [
    {"name": "Arun", "email": "arun@gmail.com", "active": true},
    {"name": "Priya", "email": "priya@gmail.com", "active": false},
    {"name": "Karthik", "email": "karthik@gmail.com", "active": true},
    {"name": "Divya", "email": "divya@gmail.com", "active": true},
    {"name": "Ramesh", "email": "ramesh@gmail.com", "active": false},
  ];

   TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> getFilterData(){

    final searchData = _controller.text.toLowerCase();

    return users.where((item){
      final name  = item['name'].toLowerCase();

      final matchedRow = searchData.isEmpty || name.contains(searchData);

      return matchedRow;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

      final filteredData = getFilterData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0b2545),
        title: Center(
          child: Text("Hello I'm Rio",style: TextStyle(
            color: Colors.white,
            fontSize: 29,
            fontWeight: FontWeight.w700
          ),),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.all(18),
            child: SearchBar(
              controller: _controller,
              hintText: "Search Name",
              trailing: [
                if(_controller.text.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap:(){
                      setState(() {
                        _controller.clear();
                      });
                      },
                    child:Icon(Icons.close,color: Color(0xff0b2545),),
                  ),
                )
              ],
              hintStyle: MaterialStateProperty.all(
                TextStyle(color: Colors.grey)
              ),
              onChanged: (value){
                setState(() {});
              },
            ),
          ),
          Expanded(child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context,index){
                final user = filteredData[index];
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    decoration:  BoxDecoration(
                        color: Color(0xfff5f3f4),
                        borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xff0b2545)
                      )
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Color(0xff0b2545),
                              child:
                              Text(user['name'][0],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(user['name'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text(user['email'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap:(){
                                setState(() {
                                  user['active'] = !user['active'];
                                });
                               },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Color(0xff0b2545),
                                  borderRadius: BorderRadius.circular(4)
                                ),
                                child: Center(
                                  child: Text(
                                    user['active'] ? "Active" : "DeActive",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),

                                ),
                              ),
                            )
                            
                          ],
                        )
                      ],
                    ),
                  ),
                );
          }))
        ],
      ),
    );
  }
}
