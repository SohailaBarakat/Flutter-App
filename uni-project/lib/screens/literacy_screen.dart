import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_project1/models/medical_clinics_response.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../models/literacy.dart';

class Literacy extends StatefulWidget {
  const Literacy({Key? key}) : super(key: key);
  static const routeName = '/Literacy';

  @override
  State<Literacy> createState() => _LiteracyState();
}

class _LiteracyState extends State<Literacy> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> _inputData = {
    'name': '',
    'address': '',
    'illiterate_id': '',
    'classroom': '',
    'classroom_type': '',
  };

  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems1 = [
      DropdownMenuItem(
          child: Align(alignment: Alignment.centerRight, child: Text("منزل")),
          value: "home"),
      DropdownMenuItem(
          child: Align(alignment: Alignment.centerRight, child: Text("مسجد")),
          value: "mosque"),
      DropdownMenuItem(
          child: Align(alignment: Alignment.centerRight, child: Text("جمعية")),
          value: "association"),
      DropdownMenuItem(
          child: Align(alignment: Alignment.centerRight, child: Text("كلية")),
          value: "collage"),
    ];
    return menuItems1;
  }

  List<DropdownMenuItem<String>> get dropdownItems2 {
    List<DropdownMenuItem<String>> menuItems2 = [
      DropdownMenuItem(
          child: Align(alignment: Alignment.centerRight, child: Text("تنشيطي")),
          value: "energizing"),
      DropdownMenuItem(
          child: Align(alignment: Alignment.centerRight, child: Text("حر")),
          value: "free"),
      DropdownMenuItem(
          child: Align(
              alignment: Alignment.centerRight, child: Text("امتحان فوري")),
          value: "immediate_exam"),
    ];
    return menuItems2;
  }

  var _isLoading = false;
  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) {
      //Invalid
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    await Provider.of<LiteracyForm>(context, listen: false).sendRequest(
        _inputData['name'].toString(),
        _inputData['address'].toString(),
        _inputData['illiterate_id'].toString(),
        _inputData['classroom'].toString(),
        _inputData['classroom_type'].toString());
    setState(() {
      _isLoading = false;
    });

    Alert(
        context: context,
        title: "لقد تم ارسال طلبك بنجاح",
        image: Image.asset("assets/images/success.png"),
        buttons: [
          DialogButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'تم',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              })
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    String selectedValue1 = 'home';
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            toolbarHeight: 70,
            title: Container(
              margin: const EdgeInsets.only(
                right: 15,
              ),
              child: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "محو الامية",
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ),
          body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(20),
                  child: Card(
                    elevation: 5,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: const Text(
                                'يلزم على طلاب كليات الاداب - التربية - التربية النوعية- التربية الرياضية - الطفولة المبكرة - الحقوق - كلية تكنولوجيا الادارة و نظم المعلومات - التجارة(قسم تدريس المواد التجارية) استكمال اجراءات محو الامية و ذلك بتسجيل خمس متعلمين بحد ادنى',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Vazirmatn'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintTextDirection: TextDirection.rtl,
                                  hintText: 'اسم المتدرب',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'اسم المتدرب مطلوب';
                                } else if (value.length <= 3 ||
                                    value.length > 50) {
                                  return 'يجب ان يكون اسم المتدرب اكبر من ثلاث احرف';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                _inputData['name'] = value.toString();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintTextDirection: TextDirection.rtl,
                                  hintText: 'العنوان - محل الاقامة',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'العنوان مطلوب';
                                } else if (value.length <= 5 ||
                                    value.length > 150) {
                                  return 'يجب ان يكون العنوان اكبر من خمسة احرف';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                _inputData['address'] = value.toString();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintTextDirection: TextDirection.rtl,
                                  hintText: 'الرقم القومي',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'الرقم القومي مطلوب';
                                } else if (value.length != 14) {
                                  return 'يجب أن يحتوي الحقل الرقم القومي على 14 رقمًا/أرقام';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                _inputData['illiterate_id'] = value.toString();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                                isExpanded: true,
                                hint: const Text(
                                  'برجاء اختيار مكان الفصل ',
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.right,
                                ),
                                icon: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: dropdownItems1,
                                validator: (value) {
                                  if (value == null) {
                                    return 'برجاء اختيار مكان الفصل';
                                  }
                                  return null;
                                },
                                // value: selectedValue1,
                                onChanged: (String? newValue) {
                                  selectedValue1 = newValue!;
                                },
                                onSaved: (value) {
                                  _inputData['classroom'] = value.toString();
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: DropdownButtonFormField2(
                                decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                                isExpanded: true,
                                hint: const Text(
                                  'برجاء اختيار نوع الفصل ',
                                  style: TextStyle(fontSize: 14),
                                  textAlign: TextAlign.right,
                                ),
                                icon: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                ),
                                iconSize: 30,
                                buttonHeight: 60,
                                buttonPadding:
                                    const EdgeInsets.only(left: 20, right: 10),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                items: dropdownItems2,
                                validator: (value) {
                                  if (value == null) {
                                    return 'برجاء اختيار نوع الفصل';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                                onSaved: (value) {
                                  _inputData['classroom_type'] =
                                      value.toString();
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (_isLoading)
                            const CircularProgressIndicator()
                          else
                            Container(
                              alignment: Alignment.centerLeft,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 30.0, vertical: 8.0)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.white,
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Theme.of(context).primaryColor,
                                  ),
                                ),
                                onPressed: _send,
                                child: const Text(
                                  'اضافة',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))),
    );
  }
}
