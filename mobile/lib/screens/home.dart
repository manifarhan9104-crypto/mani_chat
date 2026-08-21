import 'package:flutter/material.dart';
import 'chat.dart';


class HomePage extends StatelessWidget {

  const HomePage({super.key});


  final chats = const [

    {
      "name":"علی",
      "message":"سلام، خوبی؟",
      "time":"12:30"
    },

    {
      "name":"گروه دوستان",
      "message":"یک عکس ارسال شد 📷",
      "time":"11:20"
    },

    {
      "name":"پشتیبانی مانی چت",
      "message":"به پیام‌رسان خوش آمدید",
      "time":"10:00"
    },

  ];



  @override
  Widget build(BuildContext context){

    return Directionality(

      textDirection: TextDirection.rtl,

      child: Scaffold(


        appBar: AppBar(

          title:
          const Text("مانی چت"),


          actions:[


            IconButton(

              icon:
              const Icon(Icons.search),

              onPressed:(){},

            ),


            IconButton(

              icon:
              const Icon(Icons.more_vert),

              onPressed:(){},

            ),

          ],

        ),



        body:

        ListView.builder(


          itemCount: chats.length,


          itemBuilder:(context,index){


            return ListTile(


              onTap:(){


                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder:(context)=>

                    const ChatPage(),

                  ),

                );


              },



              leading:


              const CircleAvatar(

                radius:25,

                child:
                Icon(Icons.person),

              ),



              title:


              Text(

                chats[index]["name"]!,

                style:

                const TextStyle(

                  fontWeight:
                  FontWeight.bold,

                ),

              ),



              subtitle:


              Text(

                chats[index]["message"]!,

              ),



              trailing:


              Text(

                chats[index]["time"]!,

              ),


            );


          },


        ),



        floatingActionButton:


        FloatingActionButton(

          child:

          const Icon(Icons.edit),


          onPressed:(){},


        ),



      ),

    );

  }

}
