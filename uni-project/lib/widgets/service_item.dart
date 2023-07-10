import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/service_details_response.dart';
import '../screens/service_details_screen.dart';
import '../models/all_services.dart';
import '../models/service_details_response.dart';
import '../screens/link.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceItem extends StatefulWidget {
  const ServiceItem({Key? key}) : super(key: key);

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  Future openBrowerUrl({
    required String url,
    bool inApp = false,
  }) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: inApp,
        forceWebView: inApp,
        enableJavaScript: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<Service>(context, listen: false);
    String s = service.icon!;
    int i = int.parse(s);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () async {
          if (service.link == null) {
            Navigator.of(context)
                .pushNamed(ServicDetailScreen.routeName, arguments: service.id);
          } else {
            final link = service.link;
            final url = '$link';
            openBrowerUrl(url: url, inApp: true);
          }
        },
        child: LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.7,
                width: constraints.maxWidth * 0.7,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 5,
                  color: Color.fromARGB(255, 205, 223, 246),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: LayoutBuilder(
                      builder: (ctx, constraints) {
                        return Center(
                          child: Container(
                            child: Icon(
                              IconData(
                                i,
                                fontFamily: 'MaterialIcons',
                              ),
                              color: Theme.of(context).primaryColor,
                              size: constraints.maxHeight * 0.5,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.1,
              ),
              Container(
                height: constraints.maxHeight * 0.13,
                width: constraints.maxWidth * 0.8,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    service.name!,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
        // child: Column(
        //   children: [
        //     Container(
        //       height: MediaQuery.of(context).size.height * 0.15,
        //       width: MediaQuery.of(context).size.width * 0.3,
        //       child: Card(
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(20)),
        //         elevation: 5,
        //         color: Color.fromARGB(255, 205, 223, 246),
        //         child: Container(
        //           padding: EdgeInsets.all(15),
        //           decoration:
        //               BoxDecoration(borderRadius: BorderRadius.circular(15)),
        //           child: LayoutBuilder(
        //             builder: (ctx, constraints) {
        //               return Center(
        //                 child: Container(
        //                   child: Icon(
        //                     IconData(
        //                       i,
        //                       fontFamily: 'MaterialIcons',
        //                     ),
        //                     color: Theme.of(context).primaryColor,
        //                     size: constraints.maxHeight * 0.5,
        //                   ),
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //       ),
        //     ),
        //     SizedBox(
        //       height: 13,
        //     ),
        //     Container(
        //       child: Text(
        //         service.name!,
        //         style: TextStyle(
        //           fontSize: 18,
        //           color: Colors.black,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
