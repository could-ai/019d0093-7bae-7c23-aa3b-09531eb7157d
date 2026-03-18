import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  List<dynamic> drugs = [];
  Map<String, dynamic>? drug1;
  Map<String, dynamic>? drug2;

  @override
  void initState() {
    super.initState();
    _loadDrugs();
  }

  Future<void> _loadDrugs() async {
    final String response = await rootBundle.loadString('assets/drugs.json');
    final data = json.decode(response);
    setState(() {
      drugs = data['drug_classes'].expand((cls) => cls['drugs']).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⚖️ Compare Drugs')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<Map<String, dynamic>>(
                    hint: const Text('Select Drug 1'),
                    value: drug1,
                    items: drugs.map((drug) {
                      return DropdownMenuItem(
                        value: drug,
                        child: Text(drug['name']),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => drug1 = value),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<Map<String, dynamic>>(
                    hint: const Text('Select Drug 2'),
                    value: drug2,
                    items: drugs.map((drug) {
                      return DropdownMenuItem(
                        value: drug,
                        child: Text(drug['name']),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => drug2 = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (drug1 != null && drug2 != null)
              Expanded(
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Aspect')),
                      DataColumn(label: Text('Drug 1')),
                      DataColumn(label: Text('Drug 2')),
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text('Class')),
                        DataCell(Text(drug1!['class'] ?? 'N/A')),
                        DataCell(Text(drug2!['class'] ?? 'N/A')),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Mechanism')),
                        DataCell(Text(drug1!['mechanism'] ?? 'N/A')),
                        DataCell(Text(drug2!['mechanism'] ?? 'N/A')),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Key Fact')),
                        DataCell(Text(drug1!['key_exam_fact'] ?? 'N/A')),
                        DataCell(Text(drug2!['key_exam_fact'] ?? 'N/A')),
                      ]),
                    ],
                  ),
                ),
              ),
            const Spacer(),
            const Text(
              '⚠️ For Educational Purposes Only — Not Medical Advice',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}