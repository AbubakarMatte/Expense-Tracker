import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String initialName;
  final String initialPhone;
  final String initialEmail;
  final String initialImage;

  ProfilePage({
    required this.initialName,
    required this.initialPhone,
    required this.initialEmail,
    required this.initialImage,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late String _profileImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _emailController = TextEditingController(text: widget.initialEmail);
    _profileImage = widget.initialImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(_profileImage),
              ),
              TextButton(
                onPressed: () {
                  _showProfileImageDialog(context);
                },
                child: Text('Change Profile Picture'),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Mobile'),
                keyboardType: TextInputType.phone,
                maxLength: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  } else if (value.length != 10 || !RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveProfileDetails(
                      _nameController.text,
                      _phoneController.text,
                      _emailController.text,
                      _profileImage,
                    );
                    Navigator.of(context).pop({
                      'name': _nameController.text,
                      'phone': _phoneController.text,
                      'email': _emailController.text,
                      'profileImage': _profileImage,
                    });
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProfileImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Profile Picture'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _profileImage = 'assets/profile1.jpg';
                    });
                    Navigator.of(context).pop();
                  },
                  child: Image.asset('assets/profile1.jpg', width: 100, height: 100),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _profileImage = 'assets/profile2.jpg';
                    });
                    Navigator.of(context).pop();
                  },
                  child: Image.asset('assets/profile2.jpg', width: 100, height: 100),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _profileImage = 'assets/profile3.jpg';
                    });
                    Navigator.of(context).pop();
                  },
                  child: Image.asset('assets/profile3.jpg', width: 100, height: 100),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _saveProfileDetails(String name, String phone, String email, String image) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profileName', name);
    await prefs.setString('profilePhone', phone);
    await prefs.setString('profileEmail', email);
    await prefs.setString('profileImage', image);
  }
}
