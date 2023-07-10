import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:provider/provider.dart';
import '../screens/pdf_screen.dart';

import '../models/auth.dart';

import '../models/service_details_response.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'dart:io';

import 'dart:ui';
import 'package:dio/dio.dart';

class ServiceDetailsBody extends StatefulWidget {
  const ServiceDetailsBody({Key? key}) : super(key: key);

  @override
  State<ServiceDetailsBody> createState() => _ServiceDetailsBodyState();
}

class _ServiceDetailsBodyState extends State<ServiceDetailsBody> {
  late String _fileFullPath;
  late String progress;

  bool _isL = false;

  late Dio dio;
  @override
  void initState() {
    dio = Dio();
    super.initState();
  }

  Future _downloadAndSaveFileToStorage2(
    String urlPath,
  ) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final name = urlPath.split('/').last;

      ProgressDialog pd = ProgressDialog(context: context);

      try {
        pd.show(
            max: 100,
            msg: 'Preparing Download...',
            progressType: ProgressType.valuable,
            backgroundColor: Color(0xff212121),
            progressValueColor: Color(0xff3550B4),
            progressBgColor: Colors.white70,
            msgColor: Colors.white,
            valueColor: Colors.white);

        final Directory _documentDir =
            Directory('/storage/emulated/0/download/$name');
        await dio.download(urlPath, _documentDir.path,
            onReceiveProgress: (rec, total) {
          setState(() {
            _isL = true;
            int progress = (((rec / total) * 100).toInt());
            print(progress);
            pd.update(value: progress, msg: 'File Downloading');
          });
        });
        pd.close();
        _fileFullPath = _documentDir.path;
      } catch (e) {
        pd.close();
        print(e);
      }

      setState(() {
        _isL = false;
      });
    } else {
      print('permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Auth>(context, listen: false);
    final serviceData = Provider.of<ServiceDetails>(context, listen: false)
        .details
        .firstWhereOrNull(
          (serv) =>
              serv.department!.id ==
                  userData.studentData!.studentDepartment!.departmentId &&
              serv.year!.id == userData.studentData!.studentYear!.yearId,
        );

    return serviceData == null
        ? const Center(
            child: Text(
              'No Content here yet',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500),
            ),
          )
        : Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(PdfScreen.routename,
                        arguments: serviceData.attachments![index].name);
                  },
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      elevation: 5,
                      child: ListTile(
                          title: Text(
                            serviceData.attachments![index].name!,
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.download),
                            onPressed: () => _downloadAndSaveFileToStorage2(
                                serviceData.attachments![index].path!),
                          )),
                    ),
                  ),
                );
              },
              itemCount: serviceData.attachments!.length,
            ));
  }
}
