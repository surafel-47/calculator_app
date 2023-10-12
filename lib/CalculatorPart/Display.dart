import 'MyDatas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Display extends StatelessWidget {
  const Display({super.key});

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
          child: Column(
            children: [
              const Expanded(
                child: Text(""),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: cardW,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        softWrap: false,
                        myDatas.expr,
                        style: TextStyle(
                            color: myDatas.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            fontSize: cardH * 0.20),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: cardW,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: Text(
                      myDatas.ans,
                      style: TextStyle(
                          color:
                              myDatas.isDarkMode ? Colors.white : Colors.black,
                          fontSize: cardH * 0.17),
                    ),
                  ),
                ),
              ),
              const Expanded(child: Text("")),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  color: myDatas.isDarkMode
                      ? const Color.fromARGB(255, 145, 137, 137)
                      : const Color.fromARGB(255, 5, 4, 4),
                  width: cardW * 0.2,
                  height: 3,
                  child: const Text(""),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
