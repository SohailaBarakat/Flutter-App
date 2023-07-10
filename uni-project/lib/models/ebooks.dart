import 'package:flutter/foundation.dart';

class EBooks {
  List<Book>? data;
  EBooks({this.data});

  factory EBooks.fromJson(Map<String, dynamic> json) {
    EBooks eBooks = EBooks();
    eBooks.data = [];
    for (var b in json['data']) {
      Book temp = Book.fromJson(b);
      eBooks.data!.add(temp);
    }
    return eBooks;
  }
}

class Book with ChangeNotifier {
  int? id;
  String? title;
  String? path;

  Book({this.id, this.title, this.path});
  factory Book.fromJson(Map<String, dynamic> json) {
    Book b = Book();
    b.id = json['id'];
    b.title = json['title'];
    b.path = json['path'];

    return b;
  }
}
