import 'dart:io';
// import 'package:flutter/cupertino.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class CvGenrateApi {
  static Future<File> generate({
    required String name,
    required String summary,
    required String knowledgeInFlutter,
    required String skills,
    required String projects,
    required String personalDetails,
  }) async {
    final cvPage = Document();
    cvPage.addPage(
      MultiPage(
        build: (context) => [
          buildCV(
            name: name,
            summary: summary,
            knowledgeInFlutter: knowledgeInFlutter,
            skills: skills,
            projects: projects,
            personalDetails: personalDetails,
          )
        ],
      ),
    );
    return saveDocument(name: 'my_CV.pdf', pdf: cvPage);
  }

  static Widget buildCV({
    required String name,
    required String summary,
    required String knowledgeInFlutter,
    required String skills,
    required String projects,
    required String personalDetails,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text(name,
                style: pw.TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        buildDetails("Summary: ", summary),
        SizedBox(height: 0.3 * PdfPageFormat.cm),
        buildDetails("knowledge in Flutter: ", knowledgeInFlutter),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        buildDetails("Skills: ", skills),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        buildDetails("Projects: ", projects),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
        buildDetails("Personal Details: ", personalDetails),
      ],
    );
  }

  static buildDetails(String title, String text) {
    return pw.Row(children: [
      pw.Expanded(
          flex: 1,
          child: pw.Text(title,
              style: pw.TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
      pw.SizedBox(width: 20),
      pw.Expanded(
          flex: 2,
          child: pw.Text(text,
              style: pw.TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))
    ]);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
