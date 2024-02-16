import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  String? text;
  PdfPreviewPage(this.text, {Key? key}) : super(key: key);
//String xxx= this.xyz;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => makePdf(),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document(title: "maz", author: "maz-maz");
    final ByteData bytes = await rootBundle.load('assets/phone.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(
        pw.Page(
            margin: const pw.EdgeInsets.all(10),
            pageFormat: PdfPageFormat.a4,
            build: (context) {
              return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Header(text: "Sales Bill", level: 1),
                          pw.Image(pw.MemoryImage(byteList), fit: pw.BoxFit.fitHeight, height: 100, width: 100)
                        ]
                    ),
                    pw.Divider(borderStyle: pw.BorderStyle.dashed),
                    pw.Paragraph(text: text),
                    pw.Paragraph(text: "xyz"),
                  ]
              );
            }
        )
    );

    return pdf.save();
  }
}