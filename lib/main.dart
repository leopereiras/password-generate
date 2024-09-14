import 'dart:typed_data';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:password_generate/password_generate.dart';

///
///
///

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PasswordGeneratorScreen(),
    );
  }
}

class PasswordGeneratorScreen extends StatefulWidget {
  const PasswordGeneratorScreen({super.key});

  @override
  _PasswordGeneratorScreenState createState() =>
      _PasswordGeneratorScreenState();
}

class _PasswordGeneratorScreenState extends State<PasswordGeneratorScreen> {
  String generatedPassword = '';
  final List<String> lastFivePasswords = [];

  void _generatePassword() {
    setState(() {
      // TODO(): Create any text field to set the password length and
      // boolean fields to set options
      generatedPassword = generatePassword(
        length: 12,
        hasLowerCase: true,
        hasNumbers: true,
        hasSpecials: true,
        hasUpperCase: true,
      );
      lastFivePasswords.add(generatedPassword);
      if (lastFivePasswords.length > 5) {
        lastFivePasswords.removeAt(0);
      }
    });
  }

// Save file
  Future<void> saveFile() async {
    const String fileName = 'suggested_name.txt';

    final FileSaveLocation? result =
        await getSaveLocation(suggestedName: fileName);

    if (result == null) {
      return;
    }

    final Uint8List fileData =
        Uint8List.fromList(lastFivePasswords.toString().codeUnits);
    const String mimeType = 'text/plain';

    final XFile textFile =
        XFile.fromData(fileData, mimeType: mimeType, name: fileName);

    await textFile.saveTo(result.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Generator'),
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Generated Password:',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    generatedPassword.isNotEmpty
                        ? generatedPassword
                        : 'Aperte o botão para gerar um password aleatório.',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _generatePassword,
                    child: const Text('Generate new password!'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: Column(
              children: [
                const Text(
                  'Last 5 generated passwords:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                for (var password in lastFivePasswords)
                  Text(
                    password,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            child: Column(children: [
              ElevatedButton(
                  onPressed: () {
                    saveFile();
                  },
                  child: const Icon(Icons.download)),
              const Text('Export last 5 passwords'),
            ]),
          ),
        ],
      ),
    );
  }
}
