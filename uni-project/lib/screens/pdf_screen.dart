import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth.dart';

import '../models/service_details_response.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfScreen extends StatelessWidget {
  const PdfScreen({Key? key}) : super(key: key);
  static const routename = '/pdf';

  @override
  Widget build(BuildContext context) {
    final attachementName = ModalRoute.of(context)!.settings.arguments;

    final userData = Provider.of<Auth>(context, listen: false);
    final serviceData = Provider.of<ServiceDetails>(context, listen: false)
        .details
        .firstWhere((serv) =>
            serv.department!.id ==
                userData.studentData!.studentDepartment!.departmentId &&
            serv.year!.id == userData.studentData!.studentYear!.yearId);

    final loadedPdf = serviceData.attachments!
        .firstWhere((element) => element.name == attachementName);

    return SafeArea(
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
          toolbarHeight: 70,
          title: Container(
            margin: EdgeInsets.only(
              right: 15,
            ),
            child: Align(
                alignment: Alignment.centerRight, child: Text(loadedPdf.name!)),
          ),
        ),
        body: SfPdfViewer.network(
          loadedPdf.path!,
        ),
      ),
    );
  }
}
