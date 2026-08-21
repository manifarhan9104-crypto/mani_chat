import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';
import 'register.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();

}


class _LoginPageState
    extends State<LoginPage> {

  final phoneController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  bool loading = false;


  Future<void> login() async {

    if (
      phoneController.text.isEmpty ||
      passwordController.text.isEmpty
    ) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text("شماره موبایل و رمز عبور را وارد کنید"),
        ),

      );

      return;

    }


    setState(() {
      loading = true;
    });


    try {

      final response = await http.post(

        Uri.parse(
          "http://YOUR_SERVER_IP:3000/login"
        ),

        headers: {

          "Content-Type":
              "application/json"

        },

        body: jsonEncode({

          "phone":
              phoneController.text,

          "password":
              passwordController.text

        }),

      );


      final data =
          jsonDecode(response.body);


      if (!mounted) return;


      if (response.statusCode == 200) {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (context) =>
                const HomePage(),

          ),

        );

      } else {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          SnackBar(
            content:
                Text(data["message"] ?? "ورود ناموفق بود"),
          ),

        );

      }


    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text("اتصال به سرور برقرار نشد"),
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

        body: SafeArea(

          child: Padding(

            padding:
                const EdgeInsets.all(24),

            child: Column(

              mainAxisAlignment:
                  MainAxisAlignment.center,

              children: [

                const CircleAvatar(

                  radius: 45,

                  child:
                      Icon(
                        Icons.chat,
                        size: 45,
                      ),

                ),


                const SizedBox(
                  height: 20
                ),


                const Text(

                  "مانی چت",

                  style:
                      TextStyle(

                    fontSize: 30,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),


                const SizedBox(
                  height: 8
                ),


                const Text(
                  "پیام‌رسان فارسی شما",
                ),


                const SizedBox(
                  height: 35
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

                    border:
                        OutlineInputBorder(),

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

                    border:
                        OutlineInputBorder(),

                  ),

                ),


                const SizedBox(
                  height: 20
                ),


                SizedBox(

                  width:
                      double.infinity,

                  height: 50,

                  child:
                      ElevatedButton(

                    onPressed:
                        loading
                            ? null
                            : login,

                    child:

                        loading

                            ? const SizedBox(

                                width: 25,

                                height: 25,

                                child:
                                    CircularProgressIndicator(),

                              )

                            : const Text(
                                "ورود"
                              ),

                  ),

                ),


                const SizedBox(
                  height: 15
                ),


                TextButton(

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) =>
                            const RegisterPage(),

                      ),

                    );

                  },

                  child:
                      const Text(
                        "حساب کاربری ندارید؟ ثبت‌نام کنید"
                      ),

                ),

              ],

            ),

          ),

        ),

      ),

    );

  }

}
