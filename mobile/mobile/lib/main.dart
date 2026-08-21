import 'package:flutter/material.dart';

import 'screens/login.dart';


void main() {

  runApp(
    const ManiChat()
  );

}


class ManiChat
    extends StatelessWidget {

  const ManiChat({super.key});


  @override
  Widget build(
      BuildContext context
  ) {

    return MaterialApp(

      debugShowCheckedModeBanner:
          false,

      title:
          "مانی چت",

      theme:
          ThemeData(

        useMaterial3:
            true,

        colorSchemeSeed:
            Colors.blue,

      ),

      home:
          const LoginPage(),

    );

  }

}
