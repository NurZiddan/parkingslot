import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:parkingslot/pages/bottom_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "Username";
  String email = "email@example.com";
  String profileImageUrl = 'assets/profile_placeholder.png'; // Default profile image
  String authToken = 'your_token_here'; // Replace with the user's actual token

  Future<void> fetchProfile() async {
    final response = await http.get(
      Uri.parse('http://192.168.18.15:5000/profile'), // Replace with your backend URL
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken', // Add authorization token
      },
    );

    if (response.statusCode == 200) {
      final profileData = json.decode(response.body);
      setState(() {
        username = profileData['username'];
        email = profileData['email'];
        profileImageUrl = profileData['photo'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch profile data')),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    final response = await http.post(
      Uri.parse('192.168.18.15:5000/logout'), // Replace with your backend URL
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken', // Add authorization token
      },
    );

    if (response.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged out successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out')),
      );
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        profileImageUrl = pickedFile.path;
      });
    }
  }

  Future<void> updateProfile() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.18.15:5000/edit_profile'), // Replace with your backend URL
    );

    request.fields['username'] = username;

    if (profileImageUrl.startsWith('/')) {
      request.files.add(await http.MultipartFile.fromPath('photo', profileImageUrl));
    }

    request.headers['Authorization'] = 'Bearer $authToken'; // Add authorization token

    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
      fetchProfile(); // Refresh profile data
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              logout(context);
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: profileImageUrl.startsWith('http')
                    ? NetworkImage(profileImageUrl)
                    : FileImage(File(profileImageUrl)) as ImageProvider,
              ),
              TextButton(
                onPressed: pickImage,
                child: const Text("UPLOAD"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: username),
                decoration: InputDecoration(
                  labelText: "Username",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: email,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text("Save Changes"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/change_email');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                child: const Text("Change Email"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/change_password');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text("Change Password"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  logout(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 2),
    );
  }
}
