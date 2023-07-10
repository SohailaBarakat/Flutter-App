import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Pdf extends StatefulWidget {
  const Pdf({Key? key}) : super(key: key);
  static const routeName = '/pdf-screen';

  @override
  State<Pdf> createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('hi'),
      ),
      body: Container(
        child: TextButton(
          child: Text('hi'),
          onPressed: () async {
            const url = 'http://195.246.39.39/misnatega/';
            openBrowerUrl(url: url, inApp: true);
          },
        ),
      ),
    );
  }
}
