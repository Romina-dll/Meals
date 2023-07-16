import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal.dart';
import 'package:meals2/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  MealDetailsScreen({super.key, required this.meal });

  final Meal meal;
  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(onPressed: (){
            final wasAdded = ref.read(favoriteMealsProvider.notifier).toggleMealFavoriteStatus(meal);
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(wasAdded ? 'Meal added as a favorite' : 'Meal remove.')
                )
            );
          },
              icon:AnimatedSwitcher(
                duration: Duration(microseconds: 300),
                transitionBuilder: (child , animation) {
                  return RotationTransition(turns: Tween<double>(begin: 0.8 ,end: 1).animate(animation), child: child,);
                },
                child: Icon(isFavorite ? Icons.star : Icons.star_border, key: ValueKey(isFavorite),),
              )
          )
        ],
      ),
      body: SingleChildScrollView(
        child :Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                  meal.imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,)
            ),
            SizedBox(height: 14,),
            Text('Ingredients' ,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary ,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 14,),
            for(final ingredient in meal.ingredients)
              Text(ingredient , style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground),
              ),
            SizedBox(height: 24,),
            Text('Steps' ,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary ,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 14,),
            for(final step in meal.steps)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8 , horizontal: 12),
                child: Text(step ,
                  textAlign: TextAlign.center,
                  style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              )
          ],
        ),
      )
    );
  }
}
