import 'dart:io';

import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/ebooks_response.dart';
import 'package:provider/provider.dart';
import '../screens/book_pdf_screen.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class EBook extends StatefulWidget {
  const EBook({Key? key}) : super(key: key);

  @override
  State<EBook> createState() => _EBookState();
}

class _EBookState extends State<EBook> {
  var _isInit = true;
  var _isLoading = false;
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Books>(context).fetchAndSetBooks().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  //  ******** download file *********

  late String _fileFullPath;
  late String progress;

  bool _isL = false;

  late Dio dio;
  @override
  void initState() {
    dio = Dio();
    super.initState();
  }

  Future _downloadAndSaveFileToStorage(
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
    final book = Provider.of<Books>(context, listen: false);
    return book == null
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
                    Navigator.of(context).pushNamed(BookPdf.routename,
                        arguments: book.items[index].id);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    elevation: 5,
                    child: ListTile(
                      leading: IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () {
                            _downloadAndSaveFileToStorage(
                              book.items[index].path!,
                            );
                          }),
                      title: Text(
                        book.items[index].title!,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
              itemCount: book.items.length,
            ));
  }
}
