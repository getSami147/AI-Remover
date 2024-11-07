import 'package:flutter/material.dart';

class LassoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.purple[50],
      child: Center(child: Text("Lasso Content", style: TextStyle(fontSize: 16))),
    );
  }
}