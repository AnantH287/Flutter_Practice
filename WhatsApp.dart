import 'package:flutter/material.dart';

class Whatsapp extends StatefulWidget {
  const Whatsapp({super.key});

  @override
  State<Whatsapp> createState() => _WhatsappState();
}

class _WhatsappState extends State<Whatsapp> {
  int selectedIndex = -1; // store selected index

  final List<String> items = [
    "All",
    "Unread",
    "Favorites",
    "Groups",
    "Important",
    "Archived",
    "Spam",
    "Trash",
    "Updates",
    "Promotions",
    "Social",
    "Forums",
    "+",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("WhatsApp", style: TextStyle(color: Colors.green)),
        actions: [
          IconButton(icon: const Icon(Icons.qr_code), onPressed: () {}),
          IconButton(icon: const Icon(Icons.camera), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Ask Meta AI or Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(items.length, (index) {
                    return Row(
                      children: [
                        newMethod(items[index], index),
                        const SizedBox(width: 6),
                      ],
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 10),
         Chats(Image(image: NetworkImage('https://cgfaces.com/collection/1024px/9f19a02b-a5f0-4bb8-a58b-d03ffc5ffd35.jpg')),"Rio","at gym", Colors.blue),
         SizedBox(height: 10,),
         Chats(Image(image: NetworkImage('https://cdn.pixabay.com/photo/2023/02/08/14/02/ai-generated-7776701_1280.jpg')),"Ananth","at school", Colors.grey),
        SizedBox(height: 10,),
         Chats(Image(image: NetworkImage('https://cdn.pixabay.com/photo/2023/02/08/14/02/ai-generated-7776701_1280.jpg')),"Akil","at work", Colors.blue),
        SizedBox(height: 10,),
         Chats(Image(image: NetworkImage('https://cdn.pixabay.com/photo/2023/02/08/14/02/ai-generated-7776701_1280.jpg')),"Mathav","busy", Colors.blue),
        SizedBox(height: 10,),
         Chats(Image(image: NetworkImage('https://cdn.pixabay.com/photo/2023/02/08/14/02/ai-generated-7776701_1280.jpg')),"Mani","at gym", Colors.grey),
          ],
        ),
      ),
    );
  }

  SizedBox Chats(image ,name, about, color) {
    return SizedBox(
height: 50,
width: double.infinity, 
child: Row(
  mainAxisAlignment: MainAxisAlignment.start, 
  children: [
    ClipOval(child: image),
    SizedBox(width: 20),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          about,
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
    Spacer(),
    Icon(Icons.done_all, color: color,),
  ],
),
);
  }

  Widget newMethod(String letter, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color:
              selectedIndex == index
                  ? const Color.fromARGB(255, 109, 188, 112)
                  : const Color.fromARGB(255, 253, 253, 253),
          border: Border.all(color: const Color.fromARGB(255, 204, 203, 203)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          letter,
          style: TextStyle(color: const Color.fromARGB(255, 85, 84, 84)),
        ),
      ),
    );
  }
}
