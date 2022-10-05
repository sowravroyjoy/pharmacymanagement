import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pharmacymanagement/widgets/pdf_api.dart';

import '../models/api_sale.dart';

class PdfSales {
  static Future<File> generate(ApiSale invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildFooter(),
        buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
     // footer: (context) => buildFooter(),
    ));

    return PdfApi.saveDocument(
        "sale" +
            DateFormat('dd-MMM-yyyy-jms').format(DateTime.now()) +
            ".pdf",
        pdf);
  }

  static Widget buildTitle(ApiSale invoice) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Date : ' + DateFormat('dd-MMM-yyyy').format(DateTime.now()),
            style: TextStyle(
              fontSize: 10,
            )),
        SizedBox(height: 2 * PdfPageFormat.cm),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Buyer Name : ' + invoice.buyerName.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Buyer Contact : ' + invoice.buyerContact.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ]),
        SizedBox(height: 0.8 * PdfPageFormat.cm),
      ]);

  static Widget buildInvoice(ApiSale invoice) {
    final headers = ['Name', 'Quantity', 'Price'];

    final data = invoice.items.map((item) {
      return [
        item.name,
        item.quantity,
        item.price,
      ];
    }).toList();
    return Table.fromTextArray(
      headers: headers,
      data: data,

      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(ApiSale invoice) {
    return Container(
        alignment: Alignment.centerRight,
        child: Row(children: [
          Spacer(flex: 6),
          Expanded(
              flex: 4,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                        title: 'Total', value: invoice.total, unite: true),
                  ]))
        ]));
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
        width: width,
        child: Row(children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ]));
  }

  static Widget buildFooter() =>
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

        buildFooterText(
            title: '',
            value: 'Camera Square', isBold: true),
        SizedBox(height: 1 * PdfPageFormat.mm),
        buildFooterText(title: 'Contact :', value: '+8801784646554', isBold: false),
        SizedBox(height: 1 * PdfPageFormat.mm),
        buildFooterText(title: 'Address :', value: '!st floor, Element Shopping Mall, Sylhet', isBold: false),
        // SizedBox(height: 1 * PdfPageFormat.mm),
        // buildFooterText(title: 'Email :', value: 'sawonseu@gmail.com', isBold: false),
        SizedBox(height: 1 * PdfPageFormat.mm),
        buildFooterText(title: 'Developed By :', value: 'MeetTech Lab ', isBold: false),
        buildFooterText(title: 'Contact :', value: '+8801755-460159 ', isBold: false),
        SizedBox(height: 2 * PdfPageFormat.mm),
        Divider(),
      ]);

  static buildFooterText({required String title, required String value , required bool isBold}) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(title, style: style),
          SizedBox(width: 2 * PdfPageFormat.mm),
          isBold ?Text(value, style:  style): Text(value),
        ]);
  }
}
