// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyDatas.dart';
import 'package:vibration/vibration.dart';

class Buttons extends StatelessWidget {
  Buttons({super.key});
  List<String> btns = [
    "DEL", "(", ")", "%", //
    "7", "8", "9", "/", //
    "4", "5", "6", "X", //
    "1", "2", "3", "-", //
    "0", ".", "=", "+", //
  ];

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
          color: myDatas.isDarkMode
              ? Color.fromARGB(255, 24, 33, 42)
              : Color.fromARGB(255, 199, 186, 186),
          child: Padding(
            padding: EdgeInsets.all(cardH * 0.02),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: btns.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: cardH * 0.17,
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Container(
                    width: cardH * 0.1, child: MyButtons(val: btns[index]));
              },
            ),
          ),
        );
      },
    );
  }
}

class MyButtons extends StatelessWidget {
  String val;
  MyButtons({required this.val});

  Color retBtnColor(String val) {
    if (val == "DEL") {
      return Color.fromARGB(255, 66, 53, 53);
    } else if (val == "%" ||
        val == "/" ||
        val == "X" ||
        val == "-" ||
        val == "+") {
      return Color.fromARGB(255, 229, 229, 229);
    } else if (val == "=") {
      return Colors.red;
    } else {
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final myDatas = Provider.of<MyDatas>(context, listen: true);

    double cardH;
    double cardW;

    return GestureDetector(
      onTap: () async {
        try {
          myDatas.updateExpr(val);
        } catch (err) {
          Vibration.vibrate(duration: 300);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 1),
              content: Text("Error :$err"),
            ),
          );
          return;
        }
        Vibration.vibrate(amplitude: 20, duration: 70);
      },
      onLongPress: () {
        if (val == "DEL") myDatas.updateExpr("DEL LONG PRESS");
        Vibration.vibrate(duration: 130);
      },
      child: Container(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            cardH = constraints.maxHeight;
            cardW = constraints.maxWidth;
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: retBtnColor(val),
              ),
              child: Center(
                child: (val == "DEL")
                    ? Icon(
                        Icons.backspace_outlined,
                        color: Color.fromARGB(255, 199, 189, 189),
                      )
                    : Text(
                        val,
                        style: TextStyle(
                            color: (val == "%" ||
                                    val == "/" ||
                                    val == "X" ||
                                    val == "-" ||
                                    val == "+")
                                ? Colors.black
                                : myDatas.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                            fontSize: cardW * 0.33),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
