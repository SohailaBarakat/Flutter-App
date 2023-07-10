import 'package:flutter/material.dart';
//ignore_for_file: prefer_const_constructors
import 'package:provider/provider.dart';
import 'package:uni_project1/models/http_exception.dart';
import '../screens/services_overview_screen.dart';
import '../models/auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  void _showError(String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Directionality(
            textDirection: TextDirection.rtl, child: Text(message)),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(
        context,
        listen: false,
      ).login(
        _authData['email'].toString(),
        _authData['password'].toString(),
      );
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('password')) {
        // errorMessage = 'كلمة المرور غير صحيحة';
        errorMessage = Provider.of<Auth>(context, listen: false).message!;
      } else if (error.toString().contains('email')) {
        // errorMessage = 'البريدالالكتروني غير صحيح';
        errorMessage = Provider.of<Auth>(context, listen: false).message!;
      } else if (error.toString().contains('internet')) {
        errorMessage = 'تحقق من اتصالك بالإنترنت';
      }
      _showError(errorMessage);
    } catch (error) {
      const errorMessage = 'تعذر تسجيل الدخول';
      _showError(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.only(top: 60),
      child: Container(
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Vazirmatn'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'البريد الإلكتروني',
                          labelStyle: TextStyle(fontSize: 17)),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'البريد الالكتروني غير صحيح';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _authData['email'] = value.toString();
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          labelStyle: TextStyle(fontSize: 17)),
                      obscureText: true,
                      onSaved: (value) {
                        _authData['password'] = value.toString();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (_isLoading)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10.0)),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        onPressed: _submit,
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
