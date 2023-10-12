// ignore_for_file: prefer_const_constructors

import 'package:calculator_app/CalculatorPart/MyDatas.dart';

import 'Buttons.dart';
import 'Display.dart';
import 'TopBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myDatas = Provider.of<MyDatas>(context, listen: true);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: myDatas.isDarkMode
            ? const Color.fromARGB(255, 54, 71, 79)
            : Colors.white,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: TopBar(),
          ),
          Expanded(
            flex: 7,
            child: Display(),
          ),
          Expanded(
            flex: 14,
            child: Buttons(),
          ),
        ],
      ),
    );
  }
}
