import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:intl/intl.dart';

class MyDatas extends ChangeNotifier {
  String expr = "";
  String ans = "0";
  bool isDarkMode = true;
  void setDarkMode(bool val) {
    isDarkMode = val;
    notifyListeners();
  }

  void updateExpr(String val) {
    if (val == "X") {
      expr = "$expr*";
    } else if (val == "DEL") {
      if (expr.length == 1) {
        expr = "";
        ans = "0";
      } else {
        if (expr.isNotEmpty) {
          expr = expr.substring(0, expr.length - 1);
        }
      }
    } else if (val == "DEL LONG PRESS") {
      expr = "";
      ans = "0";
    } else if (val == "=") {
      updateAns();
    } else {
      expr = expr + val;
    }
    expr = expr.replaceAll(",", "");
    expr = formatExpressionWithCommas(expr);
    notifyListeners();
  }

  void updateAns() {
    String exprVal = expr.replaceAll(",", "");
    Parser p = Parser();
    Expression exp = p.parse(exprVal);
    ContextModel cm = ContextModel();
    double value = 0;
    try {
      exprVal = addMultiplicationSymbol(exprVal);
      value = exp.evaluate(EvaluationType.REAL, cm);
    } catch (err) {
      ans = "Error :)";
      expr = "";
      return;
    }
    if (value % 1 == 0) {
      ans = formatExpressionWithCommas(value.toInt().toString());
    } else {
      ans = formatExpressionWithCommas(value.toStringAsFixed(2));
    }
    expr = ans;
  }

  String formatExpressionWithCommas(String expression) {
    final regex = RegExp(r'\d+'); // Regular expression to match numbers
    final matches = regex.allMatches(expression);

    String formattedExpression = expression;
    for (final match in matches) {
      final number = match.group(0);
      final formattedNumber = NumberFormat('#,###').format(int.parse(number!));
      formattedExpression =
          formattedExpression.replaceFirst(number, formattedNumber);
    }

    return formattedExpression;
  }

  String addMultiplicationSymbol(String expression) {
    final modifiedExpression = expression.replaceAllMapped(RegExp(r'\d+\('),
        (match) => '${match.group(0)![0]}*${match.group(0)!.substring(1)}');

    return modifiedExpression;
  }
}
