// Auto Content Class
import 'package:flutter/material.dart';

class AutoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.blue[50],
      child: Center(child: Text("Auto Content", style: TextStyle(fontSize: 16))),
    );
  }
}