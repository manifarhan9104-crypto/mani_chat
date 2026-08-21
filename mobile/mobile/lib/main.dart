import 'package:flutter/material.dart';

void main() {
  runApp(const ManiChat());
}

class ManiChat extends StatelessWidget {
  const ManiChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "مانی چت",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatPage(),
    );
  }
}


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}


class _ChatPageState extends State<ChatPage> {

  final TextEditingController controller =
      TextEditingController();

  List<String> messages = [];


  void sendMessage(){

    if(controller.text.isNotEmpty){

      setState(() {
        messages.add(controller.text);
      });

      controller.clear();
    }

  }


  @override
  Widget build(BuildContext context) {

    return Directionality(

      textDirection: TextDirection.rtl,

      child: Scaffold(

        appBar: AppBar(
          title: const Text("پیام‌رسان مانی"),
        ),


        body: Column(

          children: [

            Expanded(

              child: ListView.builder(

                itemCount: messages.length,

                itemBuilder: (context,index){

                  return ListTile(
                    title: Text(messages[index]),
                  );

                },

              ),

            ),


            Row(

              children: [

                Expanded(

                  child: TextField(

                    controller: controller,

                    decoration:
                    const InputDecoration(
                      hintText: "پیام خود را بنویسید..."
                    ),

                  ),

                ),


                IconButton(

                  icon: const Icon(Icons.send),

                  onPressed: sendMessage,

                )

              ],

            )

          ],

        ),

      ),

    );

  }
}
