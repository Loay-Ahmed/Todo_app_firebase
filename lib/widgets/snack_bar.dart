import 'package:flutter/material.dart';

class CustomSnack extends StatelessWidget {
  const CustomSnack({super.key});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      width: MediaQuery.of(context).size.width * 0.8,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: const Text(
        "You must enter a valid data!",
        textAlign: TextAlign.center,
        style: TextStyle(
            // color: provider.isDark
            //     ? myColors.white
            //     : myColors.black),
            ),
        // backgroundColor: provider.isDark
        //     ? myColors.black
        //     : myColors.white,
      ),
    );
  }
}
