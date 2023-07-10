import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_project1/models/medical_clinics_response.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import './services_overview_screen.dart';

class MedicalClinics extends StatefulWidget {
  const MedicalClinics({Key? key}) : super(key: key);
  static const routeName = '/medical-clinics';

  @override
  State<MedicalClinics> createState() => _MedicalClinicsState();
}

class _MedicalClinicsState extends State<MedicalClinics> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, dynamic> _inputData = {
    'medical_department_id': 0,
    'phone': '',
    'message': '',
  };

  var _isLoading = false;
  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    await Provider.of<Clinics>(context, listen: false).sendReservation(
        _inputData['medical_department_id'].toString(),
        _inputData['phone'].toString(),
        _inputData['message'].toString());

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

    // inspect(_inputData);
  }

  @override
  Widget build(BuildContext context) {
    final clinicData = Provider.of<Clinics>(context, listen: false);
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
                  "العيادات الطبية",
                  textAlign: TextAlign.right,
                ),
              ),
            )),
        body: FutureBuilder(
          future: Provider.of<Clinics>(context, listen: false)
              .fetchAndSetClinicData(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                // Do error handling stuff
                return Center(
                  child: Text('An error occurred!'),
                );
              } else {
                return Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(20),
                      height: 600,
                      child: Card(
                        elevation: 5,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                child: const Text(
                                  'حجز العيادة',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: DropdownButtonFormField2(
                                    decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        )),
                                    isExpanded: true,
                                    hint: const Text(
                                      'القسم الطبي ',
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
                                    buttonPadding: const EdgeInsets.only(
                                        left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    items: clinicData.data
                                        .map((e) => DropdownMenuItem(
                                              value: e.id,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  e.name!,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'مطلوب اختيار القسم الطبي';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {},
                                    onSaved: (value) {
                                      _inputData['medical_department_id'] =
                                          value.toString();
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintTextDirection: TextDirection.rtl,
                                      hintText: 'الهاتف',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'رقم الهاتف مطلوب';
                                    } else if (value.length != 11) {
                                      return 'برجاء ادخال رقم الهاتف صحيح';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onSaved: (value) {
                                    _inputData['phone'] = value.toString();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  maxLines: 5,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                      hintTextDirection: TextDirection.rtl,
                                      hintText: 'الملاحظات',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'مطلوب كتابة الاعراض';
                                    } else if (value.length <= 10) {
                                      return 'يجب ان يكون محتوى الرسالة اكبر من 10 احرف';
                                    }
                                  },
                                  onSaved: (value) {
                                    _inputData['message'] = value.toString();
                                  },
                                ),
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
                                      'ارسال الطلب',
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
                  ),
                );
                ;
              }
            }
          },
        ),
      ),
    );
  }
}
