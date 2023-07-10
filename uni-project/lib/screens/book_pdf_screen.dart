import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_project1/models/ebooks_response.dart';
import '../models/ebooks_response.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookPdf extends StatelessWidget {
  const BookPdf({Key? key}) : super(key: key);
  static const routename = '/book-pdf';

  @override
  Widget build(BuildContext context) {
    final bookId = ModalRoute.of(context)!.settings.arguments;
    final bookData = Provider.of<Books>(context, listen: false)
        .items
        .firstWhere((book) => book.id == bookId);
    return Scaffold(
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
              alignment: Alignment.centerRight, child: Text(bookData.title!)),
        ),
      ),
      body: SfPdfViewer.network(
        bookData.path!,
      ),
    );
  }
}
