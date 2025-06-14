import 'package:flutter/material.dart';
import 'package:untitled19/core/extension/padding_extension.dart';

class ProfileCard extends StatelessWidget {
  final List<Widget> children;

  const ProfileCard({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: children),
      ),
    ).symmetricPadding(horizontal: 20,vertical: 10);
  }
}
