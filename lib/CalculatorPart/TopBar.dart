// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calculator_app/CalculatorPart/MyDatas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final myDatas = Provider.of<MyDatas>(context, listen: true);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double cardH = constraints.maxHeight;
        double cardW = constraints.maxWidth;

        return Container(
          height: cardH,
          width: cardW,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: () {
                        // Scaffold.of(context).openDrawer();
                      },
                      icon: Icon(
                        Icons.menu,
                        size: cardH * 0.55,
                        color: myDatas.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                  Text(
                    "Calculator",
                    style: TextStyle(
                        color: myDatas.isDarkMode ? Colors.white : Colors.black,
                        fontSize: cardH * 0.47),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    Icon(
                      myDatas.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      color: myDatas.isDarkMode
                          ? Colors.white
                          : Color.fromARGB(255, 118, 111, 111),
                    ),
                    Switch(
                      value: myDatas.isDarkMode,
                      onChanged: (val) {
                        myDatas.setDarkMode(val);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
