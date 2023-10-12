// ignore_for_file: prefer_const_constructors

import 'package:calculator_app/CalculatorPart/MainBoard.dart';
import 'package:calculator_app/CalculatorPart/MyDatas.dart';
import 'package:calculator_app/SideDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor:
          Color.fromARGB(255, 0, 0, 0), // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ),
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => MyDatas(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // drawer: SideDrawer(),
          backgroundColor: Colors.black,
          body: SafeArea(
            child: MainBoard(),
          ),
        ),
      ),
    ),
  );
}
