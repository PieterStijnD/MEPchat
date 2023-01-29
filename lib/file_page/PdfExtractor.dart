import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<List<String>> readFileLineByLine(PlatformFile fileParam) async {
  List<String> sentences = [];

  //Load an existing PDF document.
  final PdfDocument document =
      PdfDocument(inputBytes: File(fileParam.path!).readAsBytesSync());

  //Extract the text from all the pages.
  String text = PdfTextExtractor(document).extractText();

  LineSplitter ls = new LineSplitter();
  sentences = ls.convert(text);

  document.dispose();
  return sentences;
}
