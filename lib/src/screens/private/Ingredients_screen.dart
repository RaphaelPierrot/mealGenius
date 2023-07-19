import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/data/data.dart';
import 'package:happly/src/models/content.dart';
import 'package:happly/src/widget/custom_appbar.dart';
import 'package:happly/src/widget/ingredient_widget.dart';

class IngredientsManageScreeen extends StatefulWidget {
  final Function(int) onItemtap;
  const IngredientsManageScreeen({required this.onItemtap, super.key});

  @override
  State<IngredientsManageScreeen> createState() =>
      _IngredientsManageScreeenState();
}

class _IngredientsManageScreeenState extends State<IngredientsManageScreeen> {
  int _selectindex = 0;

  List<Widget> widgetlist = [
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.fruit)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.vegetable)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.meal)
          .toList(),
    ),
    IngredientsWidget(
      ingredientItems: myIngredients
          .where((element) => element.type == IngredientType.feculent)
          .toList(),
    ),
  ];
  List<Color> colorbar = [
    tipo,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];
  void _onItemTapped(
    int index,
  ) {
    setState(() {
      _selectindex = index;
      if (index == 0) {
        colorbar = [
          tipo,
          Colors.grey,
          Colors.grey,
          Colors.grey,
        ];
      } else if (index == 1) {
        colorbar = [
          Colors.grey,
          tipo,
          Colors.grey,
          Colors.grey,
        ];
      } else if (index == 2) {
        colorbar = [
          Colors.grey,
          Colors.grey,
          tipo,
          Colors.grey,
        ];
      } else if (index == 3) {
        colorbar = [
          Colors.grey,
          Colors.grey,
          Colors.grey,
          tipo,
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Ingredients',
        leading: IconButton(
            onPressed: () => widget.onItemtap(0),
            icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionBar(
                    colors: colorbar,
                    onItemtap: _onItemTapped,
                    title: 'Fruits',
                    index: 0,
                  ),
                  ActionBar(
                    colors: colorbar,
                    onItemtap: _onItemTapped,
                    title: 'Vegetables',
                    index: 1,
                  ),
                  ActionBar(
                    colors: colorbar,
                    onItemtap: _onItemTapped,
                    title: 'Meal',
                    index: 2,
                  ),
                  ActionBar(
                    colors: colorbar,
                    onItemtap: _onItemTapped,
                    title: 'Feculent',
                    index: 3,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              widgetlist[_selectindex],
            ],
          ),
        ),
      ),
    );
  }
}

class ActionBar extends StatefulWidget {
  final Function(int) onItemtap;
  final List<Color> colors;
  final String title;
  final int index;
  Widget? leading;
  ActionBar(
      {this.leading,
      required this.index,
      required this.title,
      required this.colors,
      required this.onItemtap,
      super.key});

  @override
  State<ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => widget.onItemtap(widget.index),
        child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              bottom: 20,
              top: 10,
            ),
            child: widget.leading != null
                ? Container(
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: backgroundColor2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.leading!,
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(widget.title,
                              style: GoogleFonts.lato(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: widget.colors[widget.index])),
                        )
                      ],
                    ))
                : Text(widget.title,
                    style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: widget.colors[widget.index]))));
  }
}