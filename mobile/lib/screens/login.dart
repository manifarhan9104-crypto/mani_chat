import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

}


class _LoginPageState extends State<LoginPage>{

  final phoneController = TextEditingController();


  void login(){

    if(phoneController.text.isNotEmpty){

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text("ورود موفق بود")
        )

      );

    }

  }


  @override
  Widget build(BuildContext context){

    return Directionality(

      textDirection: TextDirection.rtl,

      child: Scaffold(

        appBar: AppBar(
          title: const Text("ورود به مانی چت"),
        ),


        body: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            children: [

              TextField(

                controller: phoneController,

                keyboardType: TextInputType.phone,

                decoration: const InputDecoration(

                  labelText: "شماره موبایل"

                ),

              ),


              const SizedBox(height:20),


              ElevatedButton(

                onPressed: login,

                child: const Text("ورود"),

              )

            ],

          ),

        ),

      ),

    );

  }

}
