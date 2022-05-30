import 'package:flutter/material.dart';
//TODO : what is the reason of making class Private

class GamesCategory extends StatelessWidget {
  final List gameCategoryIcon;
  final List<String> gameCategoryName;
  final Function onCategorySelected;
  final List isClicked;

  GamesCategory(
      {required this.gameCategoryIcon,
      required this.gameCategoryName,
      required this.onCategorySelected,
      required this.isClicked
      }
      );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: gameCategoryIcon.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 110,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 3
      ),
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 400,
          width: 200,
          child: Column(
            children: [
              InkWell(
                onTap: () => onCategorySelected(index, gameCategoryName[index]),
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Card(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    elevation: 5,
                    shadowColor: Colors.blue,
                    color: isClicked[index] == false// TODO how can we use different logic instead of this
                        ? Colors.white
                        : const Color.fromRGBO(37, 113, 204, 1),
                    child: Center(
                      child: Icon(
                        gameCategoryIcon[index],
                        size: 30,
                        color: isClicked[index] == false
                            ? Colors.blue
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                gameCategoryName[index],
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
// TODO: Tool bar
