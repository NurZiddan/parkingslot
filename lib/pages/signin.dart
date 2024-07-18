import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:parkingslot/api/service.dart';
import 'package:parkingslot/pages/camerascreen.dart';
import 'package:parkingslot/pages/signup.dart';
import 'package:parkingslot/pages/forgot_password.dart'; // Import the Forgot Password Screen

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final response = await http.post(
      Uri.parse(AppServices.getLoginEndpoint()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      // If login is successful, show success dialog
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Success'),
          content: Text('Login successful'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraScreen()),
                );
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // If login fails, show error message from server
      final Map<String, dynamic> responseData = json.decode(response.body);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text(responseData['message']),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.white10],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildLogo(),
                _buildSigninForm(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      child: Image.asset(
        'assets/images/logo.png',
        width: 250,
        height: 250,
      ),
    );
  }

  Widget _buildSigninForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'WELCOME BACK!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Please enter your details.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 24),
          _buildTextField('Email', 'Enter your email', controller: _emailController),
          SizedBox(height: 16),
          _buildTextField('Password', 'Enter Password', isPassword: true, controller: _passwordController),
          SizedBox(height: 16),
          _buildForgotPasswordButton(context),
          SizedBox(height: 24),
          _buildSigninButton(context),
          SizedBox(height: 16),
          _buildGoogleSigninButton(),
          SizedBox(height: 16),
          _buildSignUpText(context),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String placeholder, {bool isPassword = false, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: placeholder,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            suffixIcon: isPassword
                ? Icon(Icons.visibility_off, color: Colors.grey.shade600)
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()), // Navigate to Forgot Password Screen
            );
          },
          child: Text(
            'Forgot password',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Color(0xFF829991),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSigninButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        loginUser(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF829991),
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'Sign in',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildGoogleSigninButton() {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Image.asset('assets/images/google.png', width: 24, height: 24),
      label: Text(
        'Sign in with Google',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildSignUpText(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Signup()),
        );
      },
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.black,
          ),
          children: [
            TextSpan(text: 'Don\'t have an account? '),
            TextSpan(
              text: 'Sign up',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
