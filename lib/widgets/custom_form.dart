import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, required this.started, required this.children});

  final bool started;
  final List<Widget> children;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.sizeOf(context).width - 20,
      height: widget.started
          ? MediaQuery.sizeOf(context).height * 7 / 8
          : MediaQuery.sizeOf(context).height * 2 / 3,
      duration: const Duration(seconds: 1),
      curve: Curves.decelerate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.children,
      ),
    );
  }
}
