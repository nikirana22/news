import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news/main.dart';
import 'package:news/widgets/First.dart';
import 'package:news/widgets/SecondCont.dart';
// import 'package:news/container/First.dart';
// import 'package:news/container/SecondCont.dart';

class Details extends StatelessWidget {
  static const String routeName = '/details';

  // Widget buildDescriptionContainer()
  @override
  Widget build(BuildContext context) {


    Map data = ModalRoute.of(context)?.settings.arguments as Map;

    //TODO 5/14/2022: Handle Orientation change
    //TODO 5/14/2022: Expanded vs Flexible
    //TODO 5/14/2022: Creating separate Widgets vs builder methods
    //TODO 5/14/2022: LayoutBuilder
    //TODO 5/14/2022: Animations in Flutter
    //TODO 5/14/2022: Top 10 libraries in Flutter
    //TODO 5/14/2022: Getting User Input


    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  data['urlToImage'].toString(),
                  height:Second.checkScreenMode==Orientation.landscape? 200:300,
                  fit: BoxFit.fill,
                ),
              ),
              margin: EdgeInsets.all(10),
            ),
            Text(
              data['author'].toString(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            SecondCont(
                const Text(
                  'Title',
                  style: TextStyle(fontSize: 30, color: Colors.greenAccent),
                ),
                Text(
                  data['title'].toString(),
                  style: Theme.of(context).textTheme.headline2,
                )),
            FirstCont(
              const  Text(
                'Description',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                data['description'].toString(),
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            SecondCont(
              const Text(
                'Content',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                data['content'].toString(),
                style: Theme.of(context).textTheme.headline1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
