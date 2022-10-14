import 'package:flutter/material.dart';
import 'package:render_object_implementations/gap/gap.dart';
import 'package:render_object_implementations/progress_bar/progress_bar.dart';

class ProgressExample extends StatelessWidget {
  const ProgressExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              ProgressBar(
                dotColor: Colors.white,
                thumbColor: Colors.greenAccent,
                thumbSize: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
