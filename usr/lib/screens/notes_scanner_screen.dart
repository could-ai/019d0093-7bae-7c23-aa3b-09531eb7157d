import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NotesScannerScreen extends StatefulWidget {
  const NotesScannerScreen({super.key});

  @override
  State<NotesScannerScreen> createState() => _NotesScannerScreenState();
}

class _NotesScannerScreenState extends State<NotesScannerScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String _scanResult = '';

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      _scanNotes(); // TODO: Replace with real AI scanning via Supabase Edge Function
    }
  }

  void _scanNotes() {
    // Mock scanning result
    setState(() {
      _scanResult = 'Mock scan result: Detected Omeprazole in notes. Mechanism: Irreversibly inhibits H+/K+ ATPase. Key fact: First PPI developed! 💡 This information is for educational purposes only. Always consult a qualified healthcare professional for medical decisions.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('📷 Scan Notes')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_library),
              label: const Text('Pick Image from Gallery'),
            ),
            const SizedBox(height: 16),
            if (_image != null) Image.file(_image!, height: 200),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_scanResult, style: const TextStyle(fontSize: 16)),
              ),
            ),
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