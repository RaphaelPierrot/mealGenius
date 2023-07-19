import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/data/data.dart';
import 'package:happly/src/screens/private/Ingredients_screen.dart';
import 'package:happly/src/screens/private/expire_screen.dart';
import 'package:happly/src/screens/private/reicipe_screen.dart';
import 'package:happly/src/screens/private/shoplist_screen.dart';
import 'package:happly/src/widget/dashboard_containers.dart';
import 'package:happly/src/widget/custom_appbar.dart';

import '../../widget/health.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectindex = 0;
  final List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    widgets.addAll([
      Firstscreen(
          onItemtap: (index) => setState(() {
                _selectindex = index;
              })),
      IngredientsManageScreeen(
          onItemtap: (index) => setState(() {
                _selectindex = index;
              })),
      ExpireScreen(
          onItemtap: (index) => setState(() {
                _selectindex = index;
              })),
      ReicipeScreen(
          onItemtap: (index) => setState(() {
                _selectindex = index;
              })),
      ShoplistScreeen(
          onItemtap: (index) => setState(() {
                _selectindex = index;
              })),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: widgets.elementAt(_selectindex),
        ),
      ),
    );
  }
}

class Firstscreen extends StatefulWidget {
  final Function(int) onItemtap;
  const Firstscreen({required this.onItemtap, super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(
        title: "MealGenius",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchBar(
                  leading: const Icon(Icons.search),
                  hintStyle: MaterialStatePropertyAll(
                      GoogleFonts.lato(color: Colors.grey)),
                  hintText: 'What are you searching for ?',
                  backgroundColor: MaterialStatePropertyAll(backgroundColor2),
                ),
                const _titletext(
                  title: 'Meal Management',
                  isSubtitle: true,
                ),
                Dashboard(
                  reicipenumber: '${myReicipe.length}',
                  expirenumber: '${expiredIngredients.length}',
                  ingredientnumber: '${myIngredients.length}',
                  shopnumber: '${myShopList.length}',
                  onchangedstep: widget.onItemtap,
                ),
              ]),
        ),
      ),
    );
  }
}

class _titletext extends StatelessWidget {
  final String title;
  final bool isSubtitle;
  const _titletext({required this.title, this.isSubtitle = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(title,
          style: isSubtitle
              ? GoogleFonts.lato(
                  color: tipo, fontWeight: FontWeight.w900, fontSize: 24)
              : GoogleFonts.lato(
                  fontSize: 20, fontWeight: FontWeight.w400, color: tipo)),
    );
  }
}
