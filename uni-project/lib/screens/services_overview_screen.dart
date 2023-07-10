import 'package:flutter/material.dart';
import '../models/auth.dart';
import '../models/all_services_response.dart';
import '../widgets/services_grid.dart';
import 'package:provider/provider.dart';
import '../widgets/ebooks.dart';

//ignore_for_file: prefer_const_constructors

class ServicesOverviewScreen extends StatefulWidget {
  const ServicesOverviewScreen({Key? key}) : super(key: key);
  static const routeName = '/services-screen';

  @override
  State<ServicesOverviewScreen> createState() => _ServicesOverviewScreenState();
}

class _ServicesOverviewScreenState extends State<ServicesOverviewScreen>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: "الرئيسية"),
    Tab(text: "الكتب الدراسية"),
  ];
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Services>(context).fetchAndSetServices().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "نعم",
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      onPressed: () {
        Navigator.pop(context);
        Provider.of<Auth>(context, listen: false).logout();
      },
    );
    Widget cancelButton = FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'لا',
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          "هل تريد تسجيل الخروج؟",
        ),
      ),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget build(BuildContext context) {
    final userData = Provider.of<Auth>(context, listen: false);
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
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
              title: Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            alignment: Alignment.center,
                            child: IconButton(
                                icon: Icon(Icons.logout_sharp),
                                color: Colors.white60,
                                onPressed: () {
                                  showAlertDialog(context);
                                }
                                // },
                                )),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        child: Column(
                          children: [
                            Text(
                              userData.studentData!.name!,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            Text(
                              '${userData.studentData!.studentDepartment!.departmentName!} - ${userData.studentData!.studentYear!.yearName!}',
                              style: TextStyle(
                                color: Colors.white30,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
              toolbarHeight: 90,
              elevation: 8,
              bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 5,
                labelColor: Colors.white,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                unselectedLabelColor: Colors.white54,
                tabs: [
                  Tab(
                    child: Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.home_outlined,
                            size: 20,
                          ),
                          Text(
                            'الرئيسية',
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.book_outlined,
                          size: 20,
                        ),
                        Text('الكتب الدراسية', style: TextStyle(fontSize: 15))
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: TabBarView(children: [
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6, vertical: 15),
                      child: ServicesGrid()),
              EBook(),
            ]),
          ),
        ));
  }
}
