// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_modul_fe/theme/style.dart';

class ConfirmationDialog extends StatefulWidget {
  const ConfirmationDialog({Key? key}) : super(key: key);

  @override
  ConfirmationDialogState createState() => ConfirmationDialogState();
}

class ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Center(
        child: Text(
          "Borrow Book",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      content: Text(
        "Are you sure you want to proceed ?",
        textAlign: TextAlign.center,
      ),
      contentPadding: EdgeInsets.only(
        top: 40,
        bottom: 35,
        left: 47,
        right: 47,
      ),
      actions: [
        Row(
          children: [
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  primary: Colors.white,
                  side: BorderSide(color: UsedColors.blueButton),
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: UsedColors.blueButton,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  primary: UsedColors.blueButton,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text("Borrow"),
              ),
            ),
          ],
        ),
      ],
      actionsPadding: EdgeInsets.only(left: 25, right: 25, bottom: 23),
    );
  }
}
