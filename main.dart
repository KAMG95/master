import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedDomain = 'protonmail.com';

  Future<void> _createEmail() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    final String domain = _selectedDomain;

    final String url = 'https://protonmail.com/api/users';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      'Name': '',
      'Password': password,
      'Username': username,
      'Domain': domain,
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      print('Email created successfully!');
    } else {
      print('Error creating email!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProtonMail Email Creator',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ProtonMail Email Creator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Username'),
              TextField(
                controller: _usernameController,
              ),
              SizedBox(height: 16.0),
              Text('Password'),
              TextField(
                controller: _passwordController,
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              Text('Domain'),
              DropdownButton<String>(
                value: _selectedDomain,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _selectedDomain = value;
                    });
                  }
                },
                items: <String>['protonmail.com', 'protonmail.ch', 'pm.me']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _createEmail,
                child: Text('Create Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
