import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();

}


class _RegisterPageState
    extends State<RegisterPage> {

  final phoneController =
      TextEditingController();

  final nameController =
      TextEditingController();

  final passwordController =
      TextEditingController();


  bool loading = false;


  Future<void> register() async {

    if (
      phoneController.text.isEmpty ||
      nameController.text.isEmpty ||
      passwordController.text.isEmpty
    ) {

      return;

    }


    setState(() {
      loading = true;
    });


    try {

      final response = await http.post(

        Uri.parse(
          "http://YOUR_SERVER_IP:3000/register"
        ),

        headers: {
          "Content-Type":
              "application/json"
        },

        body: jsonEncode({

          "phone":
              phoneController.text,

          "name":
              nameController.text,

          "password":
              passwordController.text

        }),

      );


      final data =
          jsonDecode(response.body);


      if (!mounted) return;


      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content:
              Text(data["message"]),
        ),

      );


      if (response.statusCode == 200) {

        Navigator.pop(context);

      }


    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text("خطا در اتصال به سرور"),
        ),

      );

    }


    setState(() {
      loading = false;
    });

  }


  @override
  Widget build(BuildContext context) {

    return Directionality(

      textDirection:
          TextDirection.rtl,

      child: Scaffold(

        appBar: AppBar(

          title:
              const Text("ساخت حساب"),

        ),

        body: Padding(

          padding:
              const EdgeInsets.all(20),

          child: Column(

            children: [

              TextField(

                controller:
                    nameController,

                decoration:
                    const InputDecoration(

                  labelText:
                      "نام شما",

                  prefixIcon:
                      Icon(Icons.person),

                ),

              ),


              const SizedBox(
                height: 15
              ),


              TextField(

                controller:
                    phoneController,

                keyboardType:
                    TextInputType.phone,

                decoration:
                    const InputDecoration(

                  labelText:
                      "شماره موبایل",

                  prefixIcon:
                      Icon(Icons.phone),

                ),

              ),


              const SizedBox(
                height: 15
              ),


              TextField(

                controller:
                    passwordController,

                obscureText: true,

                decoration:
                    const InputDecoration(

                  labelText:
                      "رمز عبور",

                  prefixIcon:
                      Icon(Icons.lock),

                ),

              ),


              const SizedBox(
                height: 25
              ),


              SizedBox(

                width:
                    double.infinity,

                child:
                    ElevatedButton(

                  onPressed:
                      loading
                          ? null
                          : register,

                  child:

                      loading

                          ? const CircularProgressIndicator()

                          : const Text(
                              "ساخت حساب"
                            ),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}
