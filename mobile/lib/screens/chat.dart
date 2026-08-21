import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {

  const ChatPage({super.key});


  @override
  State<ChatPage> createState() => _ChatPageState();

}



class _ChatPageState extends State<ChatPage>{


  TextEditingController controller =
  TextEditingController();


  List<Map<String,dynamic>> messages=[

    {
      "text":"سلام 👋",
      "me":false
    },

    {
      "text":"سلام، خوش آمدی به مانی چت",
      "me":true
    },

  ];



  void sendMessage(){

    if(controller.text.isNotEmpty){

      setState((){

        messages.add({

          "text":controller.text,

          "me":true

        });


        controller.clear();

      });

    }

  }



  Widget messageBubble(Map msg){

    return Align(

      alignment:

      msg["me"]

      ? Alignment.centerRight

      : Alignment.centerLeft,


      child: Container(

        margin:
        const EdgeInsets.all(8),


        padding:
        const EdgeInsets.all(12),


        decoration:

        BoxDecoration(

          color:

          msg["me"]

          ? Colors.blue[300]

          : Colors.grey[300],


          borderRadius:

          BorderRadius.circular(15),

        ),


        child:

        Text(

          msg["text"],

          textDirection:
          TextDirection.rtl,

        ),

      ),

    );

  }



  @override
  Widget build(BuildContext context){

    return Directionality(

      textDirection: TextDirection.rtl,


      child: Scaffold(


        appBar: AppBar(

          title:
          const Text("گفتگو"),

          actions:[

            IconButton(

              icon:
              const Icon(Icons.call),

              onPressed:(){},

            ),

            IconButton(

              icon:
              const Icon(Icons.video_call),

              onPressed:(){},

            ),

          ],

        ),



        body:

        Column(

          children:[


            Expanded(

              child:

              ListView(

                children:

                messages

                .map((m)=>

                messageBubble(m)

                )

                .toList(),

              ),

            ),



            Row(

              children:[


                IconButton(

                  icon:
                  const Icon(Icons.emoji_emotions),

                  onPressed:(){},

                ),



                IconButton(

                  icon:
                  const Icon(Icons.image),

                  onPressed:(){},

                ),



                Expanded(

                  child:

                  TextField(

                    controller:controller,

                    decoration:

                    const InputDecoration(

                      hintText:
                      "پیام..."

                    ),

                  ),

                ),



                IconButton(

                  icon:

                  const Icon(Icons.mic),

                  onPressed:(){},

                ),



                IconButton(

                  icon:

                  const Icon(Icons.send),

                  onPressed:sendMessage,

                )


              ],

            )


          ],

        ),


      ),

    );

  }

}
