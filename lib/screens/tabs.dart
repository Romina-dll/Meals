import 'package:flutter/material.dart';
import 'package:meals2/providers/favorites_provider.dart';
import 'package:meals2/screens/categories.dart';
import 'package:meals2/screens/filters.dart';
import 'package:meals2/screens/meals.dart';
import 'package:meals2/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/filters_provider.dart';

const kInitialfilters = {
  Filter.glutenFree : false,
  Filter.lactoseFree : false,
  Filter.vagetarian : false,
  Filter.vegan : false,
};

class TabsScreen extends ConsumerStatefulWidget{
  TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    // TODO: implement createState
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen>{
  int _selectedPageIndex = 0;

  void _selectPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if(identifier == 'filter'){
      await
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => FiltersScreen()));

    }
  }


  @override
  Widget build(BuildContext context) {
     var activePageTitle = 'Categories';
     final availableMeals = ref.watch(filteredMealsProvider);

     Widget activePage = CategoriesScreen(
       availableMeals: availableMeals,
     );

     if(_selectedPageIndex == 1){
       final favoriteMeals = ref.watch(favoriteMealsProvider);
        activePage = MealsScreen(
          meals: favoriteMeals ,
        );
        activePageTitle = 'Favorites';
     }

     return Scaffold(
       appBar: AppBar(
         title: Text(activePageTitle),
       ),
       drawer: MainDrawer(onSelectScreen: _setScreen,),
       body: activePage,
       bottomNavigationBar: BottomNavigationBar(
         currentIndex: _selectedPageIndex,
         onTap: _selectPage,
         items: [
           BottomNavigationBarItem(icon: Icon(Icons.set_meal) , label: 'Categories'),
           BottomNavigationBarItem(icon: Icon(Icons.star) , label: 'Favorite'),
         ],
       ),
     );
  }
}