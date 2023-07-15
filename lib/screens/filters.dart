import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals2/screens/tabs.dart';
import 'package:meals2/widgets/main_drawer.dart';

enum Filter{
  glutenFree,
  lactoseFree,
  vagetarian,
  vegan
}

class FiltersScreen extends StatefulWidget{
  FiltersScreen({super.key, required this.currentFilters});
  final Map<Filter , bool > currentFilters;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FiltersScreen();
  }
}

class _FiltersScreen extends State<FiltersScreen>{
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vagetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      drawer: MainDrawer(onSelectScreen: (identifier){
        Navigator.of(context).pop();
        if(identifier == 'meals'){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => TabsScreen()));
        }
      }),
      body: WillPopScope(
        onWillPop:() async {
          Navigator.of(context).pop({
            Filter.glutenFree : _glutenFreeFilterSet,
            Filter.lactoseFree : _lactoseFreeFilterSet,
            Filter.vagetarian : _vegetarianFilterSet,
            Filter.vegan : _veganFilterSet,
          });
          return false;
        } ,
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (isChecked){
                setState(() {
                  _glutenFreeFilterSet = isChecked;
                });
              },
              title: Text('Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              subtitle: Text('Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34 , right: 22),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked){
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              title: Text('lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              subtitle: Text('Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34 , right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFilterSet,
              onChanged: (isChecked){
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
              title: Text('vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              subtitle: Text('Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34 , right: 22),
            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (isChecked){
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
              title: Text('vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              subtitle: Text('Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34 , right: 22),
            )
          ],
        ),
      )
    );
  }
}