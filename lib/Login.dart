import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Function loginButton;
  Login(this.loginButton);

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();



  @override
  Widget build(BuildContext context) {
    print('this is email value ------>>>>>>>>>>>>>   ${email.value.text}');
    return SingleChildScrollView(
      child: Container(
        height: 750,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromRGBO(55, 67, 76, 1),
          Color.fromRGBO(75, 164, 160, 1)
        ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        child: Stack(
          children: [
            const Positioned(
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              top: 200,
              left: 40,
            ),
            Positioned(
              top: 260,
              child: Container(
                padding: EdgeInsets.only(top: 40, left: 40),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(159, 204, 201, 1),
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(80))),
                height: 490,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.only(left: 30, top: 50),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(213, 234, 228, 1),
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(80))),
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'username',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(37, 74, 66, 1)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: email,
                        decoration:
                            InputDecoration(hintText: 'Enter user ID or Email'),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('username',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromRGBO(37, 74, 66, 1))),
                      const SizedBox(
                        height: 5,
                      ),
                       TextField(
                        controller: password,
                        decoration: const InputDecoration(hintText: 'Enter Password'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 160, top: 20),
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                              color: Color.fromRGBO(37, 74, 66, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 80),
                        child: TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomLeft: Radius.circular(20)))),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(37, 74, 66, 1))),
                          onPressed:()=> loginButton(email.value.text,password.value.text),
                          child: const Text(
                            'Login in ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                     const  SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.green,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Form(child: child)
                          TextButton(
                            style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Color.fromRGBO(159, 204, 201, 1)) ,
                                shape: MaterialStateProperty.all(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20))),)),
                              onPressed: () {},
                              child: Icon(Icons.android,  color: Colors.black),),
                          TextButton(onPressed: () {}, child: Icon(Icons.apple, color: Color.fromRGBO(37, 74, 66, 1)))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
