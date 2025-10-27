import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_bugok_business/utils/provider/auth_provider.dart';

Widget authPageCountDownTime(BuildContext context) {
  final auth = context.watch<AuthProvider>();

  return Container(
  width: 300,
  height: 50,
  decoration: BoxDecoration(
    color: Colors.red.withAlpha(20),
    border: Border.all(
      color: Colors.red,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  child: Center(
    child: Text(
      "${auth.currentDur}",
      style: TextStyle(
        color: Colors.red,
      ),
    ),
  ),
);
}
