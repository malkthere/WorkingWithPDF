import 'dart:typed_data';

import 'package:filemanagment/sell_A_Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  List<Product> text;
  int total2;
  PdfPreviewPage(this.text,this.total2, {Key? key}) : super(key: key);
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
                    pw.Text(" ", style: pw.TextStyle(fontSize: 6)),
                    pw.Text("customer name :  "+ text[0].costname, style: pw.TextStyle(fontSize: 6)),
                    pw.Divider(thickness: 1),
                    pw.Divider(thickness: 1),


                    pw.Table(
                        children: [
                          for (var i = 0; i < text.length; i++)
                            pw.TableRow(
                                children: [
                                  pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text(text[i].proname,
                                            style: pw.TextStyle(fontSize: 6)),
                                        pw.Divider(thickness: 1)
                                      ]
                                  ),
                                  pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text(text[i].price,
                                            style: pw.TextStyle(fontSize: 6)),
                                        pw.Divider(thickness: 1)
                                      ]
                                  ),
                                  pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text(text[i].quantaty,
                                            style: pw.TextStyle(fontSize: 6)),
                                        pw.Divider(thickness: 1)
                                      ]
                                  ),
                                  pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text(text[i].total.toString(),
                                            style: pw.TextStyle(fontSize: 6)),
                                        pw.Divider(thickness: 1)
                                      ]
                                  )
                                ]
                            )
                        ]
                    ),
                    pw.Table(
                        children: [

                            pw.TableRow(
                                children: [
                                  pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text("",
                                            style: pw.TextStyle(fontSize: 6)),
                                        pw.Divider(thickness: 1)
                                      ]
                                  ),
                                  pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text("",
                                            style: pw.TextStyle(fontSize: 6)),
                                        pw.Divider(thickness: 1)
                                      ]
                                  ),
                                  pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text("",
                                            style: pw.TextStyle(fontSize: 6)),
                                        pw.Divider(thickness: 1)
                                      ]
                                  ),
                                  pw.Column(
                                      crossAxisAlignment: pw.CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment: pw.MainAxisAlignment.center,
                                      children: [
                                        pw.Text(total2.toString()+"-RY",
                                            style: pw.TextStyle(fontSize: 6)),
                                        pw.Divider(thickness: 1)
                                      ]
                                  )
                                ]
                            )
                        ]
                    )


                  ]
              );
            }
        )
    );

    return pdf.save();
  }
}