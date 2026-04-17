import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart'; 
import 'package:excel/excel.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart'; 
import 'dart:io';

class Tableau extends StatefulWidget {
  @override
  State<Tableau> createState() => _TableauState();
}

class _TableauState extends State<Tableau> {
  

  // --- Helper pour les boutons d'export ---
  Widget _buildTableActions() {
    
    final TextEditingController dashSearchController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          GestureDetector(
          onTap:()=>_exportToPdf() ,//package pdf
          child:  _exportButton("PDF", Colors.cyan),
          ),
          GestureDetector(
          onTap: ()=>_exportToExcel(),//package excel
          child:  _exportButton("Excel", Colors.cyan),
          ),
          GestureDetector(
          onTap: ()=>_copyToClipboard(),//package services natif  de flutter 
          child:  _exportButton("Copier", Colors.cyan),
          ),
          const Spacer(),
          const Text("Rechercher: "),
          const SizedBox(width: 5),
          SizedBox(
            width: 100, 
            height: 30, 
            child: TextField(
              controller: dashSearchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(horizontal: 5)
              )
            )
          ),
        ],
      ),
    );
  }
  Widget _exportButton(String text, Color color) {
    return 
    Container(
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
  //Tri dans le tableau !!!!!!
  bool _isAscending = true;
  int _currentSortIndex = 0;

  
  final List<Map<String, dynamic>> _data = [
    {'N°': '1','jour':'3' ,'Petit-Déjeuner': '4','Déjeuner': '4' ,'Dîner': 25,'Total':'68'},
    {'N°': '2', 'jour':'5','Petit-Déjeuner': '6', 'Déjeuner': '4','Dîner': 30, 'Total':'68'},
    {'N°': '3', 'jour':'7','Petit-Déjeuner': '9', 'Déjeuner': '4','Dîner': 28, 'Total':'68'},
    {'N°': '4', 'jour':'1','Petit-Déjeuner': '1', 'Déjeuner': '4','Dîner': 35, 'Total':'68'},
  ];//Données de tests

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Barre d'outils d'export
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildTableActions()
              ],
            ),
          ),
          
          // Tableau paginé
          Expanded(
            child: PaginatedDataTable2(
              sortAscending: _isAscending,
              sortColumnIndex: _currentSortIndex,
              sortArrowAlwaysVisible: true,
              headingRowHeight: 60, // Ajustement pour le confort visuel
              sortArrowBuilder: (ascending, sorted) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_drop_up, 
                        color: sorted && ascending ? Colors.black : Colors.black26, 
                        size: 18),
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: Icon(Icons.arrow_drop_down, 
                          color: sorted && !ascending ? Colors.black : Colors.black26, 
                          size: 18),
                    ),
                  ],
                );
              },
              columns: [
                DataColumn2(
                  label: const Text("N°") , 
                  size: ColumnSize.L,
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _currentSortIndex = columnIndex;
                      _isAscending = ascending; 
                      
                      //  liste de données 
                      //  maListe.sort(...)
                    });
                  },
                ),
                DataColumn2(label: Text('Jour'), size: ColumnSize.L),
                DataColumn2(label: Text('Petit-Déjeuner'), size: ColumnSize.S),
                DataColumn2(label: Text('Déjeuner'), size: ColumnSize.S),
                DataColumn2(label: Text('Dîner'), size: ColumnSize.S),
                DataColumn2(label: Text('Total'), size: ColumnSize.S),
              ],
              source: MyDataSource(_data),
              rowsPerPage: 10,//istablet
              columnSpacing: 12,//istablet
              horizontalMargin: 12,//istablet
              minWidth: 600,
            ),
          ),
        ],
      ),
    );
  }

  // Export vers Excel (corrigé)
  Future<void> _exportToExcel() async {
    try {
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Données'];

      // En-têtes
      sheetObject.appendRow([
        TextCellValue('Nom'),
        TextCellValue('Email'),
        TextCellValue('Age'),
      ]);

      // Données
      for (var row in _data) {
        sheetObject.appendRow([
          TextCellValue(row['nom']),
          TextCellValue(row['email']),
          IntCellValue(row['age']),
        ]);
      }

      // Sauvegarder dans le dossier de téléchargements
      var bytes = excel.encode();
      if (bytes != null) {
        final directory = await getApplicationDocumentsDirectory();
        final path = '${directory.path}/tableau.xlsx';
        
        File(path)
          ..createSync(recursive: true)
          ..writeAsBytesSync(bytes);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Excel exporté : $path')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur export Excel: $e')),
        );
      }
    }
  }

  // Export vers PDF 
  Future<void> _exportToPdf() async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.landscape,
          build: (context) {
            return pw.TableHelper.fromTextArray(
              headers: ['Nom', 'Email', 'Age'],
              data: _data.map((row) => [
                row['nom'],
                row['email'],
                row['age'].toString(),
              ]).toList(),
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: 12,
              ),
              cellStyle: pw.TextStyle(fontSize: 10),
              border: pw.TableBorder.all(),
              headerDecoration: pw.BoxDecoration(
                color: PdfColors.grey300,
              ),
            );
          },
        ),
      );

      // Sauvegarder avec dialog de partage
      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: 'tableau_export.pdf',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur export PDF: $e')),
        );
      }
    }
  }

  // Copier dans le presse-papiers (corrigé)
  void _copyToClipboard() {
    try {
      String csvText = 'Nom,Email,Age\n';
      for (var row in _data) {
        csvText += '${row['nom']},${row['email']},${row['age']}\n';
      }
      
      Clipboard.setData(ClipboardData(text: csvText));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${_data.length} lignes copiées !'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur copie: $e')),
        );
      }
    }
  }
}

// DataSource pour data_table_2
class MyDataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;
  
  MyDataSource(this.data);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) return null;
    final row = data[index];
    
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(row['nom'])),
        DataCell(Text(row['email'])),
        DataCell(Text(row['age'].toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
