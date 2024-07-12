// help_page.dart
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Expense Tracker Help',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                '1. How to add a transaction?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'To add a transaction, tap on the "+" icon, fill in the details, and select an appropriate icon for the transaction.',
              ),
              SizedBox(height: 10),
              Text(
                '2. How to edit profile details?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'To edit profile details, tap on the profile picture or name at the top of the home page, update the details, and save.',
              ),
              // Add more help queries and solutions here as needed
            ],
          ),
        ),
      ),
    );
  }
}
