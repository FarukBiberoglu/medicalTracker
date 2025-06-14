import 'package:flutter/material.dart';
import 'package:untitled19/core/enum/category_enum.dart';
import 'category_card_widget.dart';

class CategoryFiled extends StatelessWidget {
  const CategoryFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return   SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: CategoryEnum.values
            .map((e) => CategoryCardWidget(category: e))
            .toList(),
      ),
    );
  }
}
