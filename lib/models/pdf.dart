import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:violet_wound/models/pacientes.dart';

import 'feridas.dart';

class Pdf {
  static Future<Uint8List> generate(Pacientes p, Wound w) async {
    final image =
        (await rootBundle.load("assets/logo_copy.png")).buffer.asUint8List();
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
      build: (context) => [
        pw.Center(
            child: pw.Image(pw.MemoryImage(image),
                width: 120, height: 120, fit: pw.BoxFit.cover)),
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        buildTitle(p),
        buildBody(p, w),
        buildLaudo(w),
      ],
      footer: (context) => buildFooter(),
    ));
    return pdf.save();
  }

  static pw.Widget buildTitle(Pacientes p) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          buildHeader("IDENTIFICAÇÃO DO PACIENTE:"),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Row(children: [
                pw.Text('Data: ',
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text(
                    DateFormat('dd/MM/yyyy - HH:mm \'h\'')
                        .format(DateTime.now().toLocal()),
                    style: const pw.TextStyle(fontSize: 14)),
              ]),
              pw.Row(children: [
                pw.Text('Paciente: ',
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text(p.nome, style: const pw.TextStyle(fontSize: 14)),
              ]),
            ],
          ),
          pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Row(children: [
                pw.Text('CPF: ',
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text(p.cpf, style: const pw.TextStyle(fontSize: 14)),
              ]),
              pw.Row(children: [
                pw.Text('Data de nascimento: ',
                    style: pw.TextStyle(
                        fontSize: 14, fontWeight: pw.FontWeight.bold)),
                pw.Text(p.data, style: const pw.TextStyle(fontSize: 14)),
              ]),
            ],
          ),
          pw.SizedBox(height: 0.8 * PdfPageFormat.cm),          
        ],
      );
  static pw.Widget buildBody(Pacientes p, Wound w) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        buildHeader("SINAIS VITAIS DO PACIENTE:"),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Row(children: [
              pw.Text('Peso: ',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Text('${p.peso.toString()} kg',
                  style: const pw.TextStyle(fontSize: 14)),
            ]),
            pw.Row(children: [
              pw.Text('Altura: ',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Text('${p.altura.toString()} m',
                  style: const pw.TextStyle(fontSize: 14)),
            ]),
            pw.Row(children: [
              pw.Text('HGT: ',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Text('${p.hgt.toString()} mg/dl',
                  style: const pw.TextStyle(fontSize: 14)),
            ]),
          ],
        ),
        pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Row(children: [
              pw.Text('Pressão Arterial: ',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Text('${p.pressao.toString()} mmhg',
                  style: const pw.TextStyle(fontSize: 14)),
            ]),
            pw.Row(children: [
              pw.Text('Frequência Cardíaca: ',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Text('${p.cardio.toString()} bpm',
                  style: const pw.TextStyle(fontSize: 14)),
            ]),
          ],
        ),
        pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
        buildHeader("DADOS DA FERIDA:"),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Row(children: [
              pw.Text('Local: ',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Text(w.local, style: const pw.TextStyle(fontSize: 14)),
            ]),
            pw.Row(children: [
              pw.Text('Tempo: ',
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.Text(w.tempo, style: const pw.TextStyle(fontSize: 14)),
            ]),
          ],
        ),
        pw.Row(children: [
          pw.Text('Tipologia: ',
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.Text(w.tipologia, style: const pw.TextStyle(fontSize: 14)),
        ]),
        pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
      ],
    );
  }

  static pw.Widget buildLaudo(Wound ferida) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          buildHeader("RESULTADO:"),
          pw.Row(children: [
            pw.Text('PSEUDOMONAS AERUGINOSA: ',
                style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold)),
            pw.Text('(${ferida.pseudomonas})',
                style: pw.TextStyle(
                    fontSize: 14, color: PdfColor.fromHex("#FF0000"))),
          ]),
          pw.Row(children: [
            pw.Text('CARGA BACTERIANA: ',
                style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold)),
            pw.Text('(${ferida.carga})',
                style: pw.TextStyle(
                    fontSize: 14, color: PdfColor.fromHex("#FF0000"))),
          ]),
        ],
      );
  static pw.Widget buildFooter() => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Divider(),
          pw.SizedBox(height: 3 * PdfPageFormat.mm),
          pw.Text(
              "Este documento poderá ser utilizado como apoio diagnóstico, não sendo descartada a avaliação clínica da lesão",
              style: const pw.TextStyle(fontSize: 8)),
        ],
      );

  static pw.Widget buildHeader(String texto) {
    return pw.Column(
      children: [
          pw.Divider(thickness: 2.0),
          pw.Container(color: PdfColor.fromHex("7030A0"),height: 15, child: pw.Center(child: pw.Text(texto, style:  pw.TextStyle(color: PdfColor.fromHex("#FFFFFF"))))),
          pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
      ],
    );
  }
}
