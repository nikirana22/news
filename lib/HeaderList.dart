import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String data;

  //TODO 5/10/2022: refactor this
  // int index;
  final Function onClick;


 const Header({required this.data, required this.onClick});
  @override
  Widget build(BuildContext context) {
    return TextButton(

      onPressed: ()=>onClick(data),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        child: Center(
          child: Text(
            data,
            style: TextStyle(color: Colors.white),
          ),
        ),
        // margin: const EdgeInsets.only(left: 50),//TODO How can we make it dynamic
        // width: ,
        width: 100,
      ),
    );
  }
}


class A with ChangeNotifier{
  void a(){
    notifyListeners();
  }

}
