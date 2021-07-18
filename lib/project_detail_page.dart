import 'package:flutter/material.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${title}Detail'),
      ),
      body: Container(
        color: color,
      ),
    );
  }
}