import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrugLibraryScreen extends StatefulWidget {
  const DrugLibraryScreen({super.key});

  @override
  State<DrugLibraryScreen> createState() => _DrugLibraryScreenState();
}

class _DrugLibraryScreenState extends State<DrugLibraryScreen> {
  List<dynamic> drugClasses = [];
  List<dynamic> filteredDrugs = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadDrugs();
  }

  Future<void> _loadDrugs() async {
    final String response = await rootBundle.loadString('assets/drugs.json');
    final data = json.decode(response);
    setState(() {
      drugClasses = data['drug_classes'];
      filteredDrugs = drugClasses.expand((cls) => cls['drugs']).toList();
    });
  }

  void _filterDrugs(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredDrugs = drugClasses.expand((cls) => cls['drugs']).toList();
      } else {
        filteredDrugs = drugClasses
            .expand((cls) => cls['drugs'])
            .where((drug) => drug['name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💊 Drug Library')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search drugs...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterDrugs,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDrugs.length,
              itemBuilder: (context, index) {
                final drug = filteredDrugs[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(drug['name']),
                    subtitle: Text(drug['class']),
                    onTap: () => _showDrugDetail(drug),
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '⚠️ For Educational Purposes Only — Not Medical Advice',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  void _showDrugDetail(Map<String, dynamic> drug) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(drug['name']),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Class: ${drug['class']}'),
              const SizedBox(height: 8),
              Text('Mechanism: ${drug['mechanism']}'),
              const SizedBox(height: 8),
              Text('Key Exam Fact: ${drug['key_exam_fact'] ?? 'N/A'}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}