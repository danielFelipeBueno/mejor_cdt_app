
import 'package:flutter/material.dart';

Future pushToPage(BuildContext context, Widget widget) async {
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => widget,
    ),
  );
}

Future pushAndReplaceToPage(BuildContext context, Widget widget) async {
  await Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => widget, 
    ),
  );
}

Future popAllAndPush(BuildContext context, Widget widget,{bool popAll = false}) async {
  await Navigator.pushAndRemoveUntil(
    context, 
    MaterialPageRoute(builder: (BuildContext context) => widget), 
    popAll?(Route<dynamic> route) => false:ModalRoute.withName('/')
  );
}

Future popToPage(BuildContext context) async {
  Navigator.of(context).pop();
}

