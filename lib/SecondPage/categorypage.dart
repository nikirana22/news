import 'package:flutter/material.dart';
import './gamecategory.dart';

//TODO: when we go to next page then how appbar automatically shows back arrow button  <-
class CategoryPage extends StatefulWidget {
  static const String data = '/cpage';

  static const List _gameIcons = [
    Icons.sports_martial_arts,
    Icons.sports_golf,
    Icons.sports_cricket,
    Icons.sports_esports_sharp,
    Icons.account_box_outlined,
    Icons.sports_tennis,
    Icons.shopping_basket_sharp,
    Icons.sports_hockey,
    Icons.sports_volleyball,
    Icons.sports_kabaddi,
    Icons.sports_football,
    Icons.sports_baseball
  ];
  static const List<String> _gameNames = [
    'Archery',
    'Badminton',
    'Circket',
    'Bowling',
    'Boxing',
    'Tennis',
    'Skateboarding',
    'Hockey',
    'Volleyball',
    'Kabaddi',
    'football',
    'baseball'
  ];
  final List _addGameList = [];
  final List<bool> _isLiked = List.generate(12, (index) => false);

  CategoryPage({Key? key}) : super(key: key);


  @override
  State<CategoryPage> createState() => _CategoryPageState();
}
// TODO how can we change the color of <- icon in appbar
class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//TODO:  who can we change the color of taskbar
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white60,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Icon(Icons.menu,color: Colors.black,),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Add your Favorite support',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child:
                  Text('Chose your Favorite 5 supports in your home screen')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding:const  EdgeInsets.only(top: 20),
              height: 490,
              // color: Colors.yellow,
              child: GamesCategory(
                gameCategoryName: CategoryPage._gameNames,
                gameCategoryIcon: CategoryPage._gameIcons,
                onCategorySelected: onSelectedGameCategory,
                isClicked: widget._isLiked,
              ),
            ),
          ),
          Container(
            height: 60,
            margin: const EdgeInsets.only(top: 15.9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromRGBO(37, 113, 204, 1),
            ),
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.pop<List>(
                  context,
                  widget._addGameList,
                );
              },
              child: const Text('Continue',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  void onSelectedGameCategory(int index, String itemname) {
    setState(() {
      widget._isLiked[index] = !widget._isLiked[index];
      addItem(itemname);
    });
  }

  void addItem(String name) {
    widget._addGameList.add(name);
  }
}
