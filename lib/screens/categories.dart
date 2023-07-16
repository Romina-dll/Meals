import 'package:flutter/material.dart';
import 'package:meals2/data/dummy_data.dart';
import 'package:meals2/screens/meals.dart';
import 'package:meals2/widgets/category_grid.dart';
import 'package:meals2/models/category.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<StatefulWidget> createState() {
    return _CategoriesScreen();
  }
}

class _CategoriesScreen extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 300),
      lowerBound: 0, //it is default
      upperBound: 1, //it is default
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => MealsScreen(
              meals: filteredMeals,
              title: category.title,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            for (final category in availableCategories)
              CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              )
          ],
        ),
        builder: (context, child) => SlideTransition(
              position: Tween(begin: Offset(0, 0.3), end: Offset(0, 0)).animate(
                CurvedAnimation(
                    parent: _animationController, curve: Curves.easeInOut),
              ),
              child: child,
            ));
  }
}
