//ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uni_project1/screens/medical_clinics_screen.dart';
import './models/all_services.dart';
import './screens/pdf_screen.dart';

import './screens/service_details_screen.dart';
import './screens/login_screen.dart';
import './screens/services_overview_screen.dart';

import 'models/all_services_response.dart';
import './models/auth.dart';
import './models/user_data.dart';
import './models/service_details_response.dart';
import './models/service_details.dart';
import './models/ebooks_response.dart';
import './screens/splash_screen.dart';
import './screens/medical_clinics_screen.dart';
import './models/medical_clinics_response.dart';
import './screens/literacy_screen.dart';
import './screens/link.dart';

import './screens/book_pdf_screen.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:firebase_core/firebase_core.dart';
import './models/literacy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => UserDepartment(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => ServiceData(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Data(),
          ),
          ChangeNotifierProxyProvider<Auth, Services>(
            create: (_) => Services([], ''),
            update: (ctx, auth, previousServices) => Services(
                previousServices!.items == null ? [] : previousServices.items,
                auth.token == null ? '' : auth.token),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Service(),
          ),
          ChangeNotifierProxyProvider<Auth, ServiceDetails>(
            create: (ctx) => ServiceDetails([], ''),
            update: (ctx, auth, previousDetails) => ServiceDetails(
              previousDetails!.details == null ? [] : previousDetails.details,
              auth.token == null ? '' : auth.token,
            ),
          ),
          ChangeNotifierProxyProvider<Auth, Clinics>(
            create: (ctx) => Clinics([], '', ''),
            update: (ctx, auth, previousData) => Clinics(
                previousData!.data == null ? [] : previousData.data,
                auth.token == null ? '' : auth.token,
                previousData.messagee == null ? '' : previousData.messagee),
          ),
          ChangeNotifierProxyProvider<Auth, Books>(
              create: (ctx) => Books([], ''),
              update: (ctx, auth, previousDetails) => Books(
                    previousDetails!.items == null ? [] : previousDetails.items,
                    auth.token == null ? '' : auth.token,
                  )),
          ChangeNotifierProxyProvider<Auth, LiteracyForm>(
            create: (ctx) => LiteracyForm('', ''),
            update: (ctx, auth, previousData) => LiteracyForm(
                auth.token == null ? '' : auth.token,
                previousData!.message == null ? '' : previousData.message),
          )
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter App',
            home: auth.isAuth
                ? const ServicesOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : LoginScreen()),
            theme: ThemeData(
              // scaffoldBackgroundColor: Colors.white,
              scaffoldBackgroundColor: const Color.fromARGB(255, 246, 247, 249),
              fontFamily: 'Tajawal',

              primaryColor: Color.fromARGB(255, 6, 96, 216),
              colorScheme: ColorScheme.light(
                  primary: Color.fromARGB(255, 0, 82, 163),
                  secondary: Color.fromARGB(255, 30, 128, 248)),

              appBarTheme: AppBarTheme(
                backgroundColor: Color.fromARGB(190, 26, 115, 232),
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ElMessiri',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            routes: {
              ServicesOverviewScreen.routeName: (ctx) =>
                  ServicesOverviewScreen(),
              ServicDetailScreen.routeName: (ctx) => ServicDetailScreen(),
              PdfScreen.routename: (ctx) => PdfScreen(),
              MedicalClinics.routeName: (ctx) => MedicalClinics(),
              Pdf.routeName: (ctx) => Pdf(),
              BookPdf.routename: (ctx) => BookPdf(),
              Literacy.routeName: (ctx) => Literacy(),
            },
          ),
        ));
  }
}
