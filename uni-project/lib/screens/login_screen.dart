import 'package:flutter/material.dart';
import '../widgets/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      print(message);
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: Color.fromARGB(220, 6, 96, 216),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 8,
                  ),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    padding: EdgeInsets.only(bottom: 5),
                    child: LayoutBuilder(
                      builder: (ctx, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: constraints.maxHeight * 0.6,
                              child: Text(
                                'بوابة الخدمات الطلابية',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Vazirmatn'),
                              ),
                            ),
                            Container(
                              height: constraints.maxHeight * 0.4,
                              child: Text(
                                'جامعة بورسعيد',
                                style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Vazirmatn'),
                              ),
                            )
                          ],
                        );
                      },
                    )),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Login(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
