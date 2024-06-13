import 'package:flutter/material.dart';
import 'package:vocabulary_app/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordController = TextEditingController();
  final String _correctPassword = '12345678';

  void _login(BuildContext context) {
    String enteredPassword = _passwordController.text.trim();
    if (enteredPassword == _correctPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Incorrect Password'),
          content: const Text('Please enter the correct password to continue.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(
                    color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  labelText: 'Enter Password To acess this app Lutfen 🤪',
                  labelStyle: const TextStyle(
                    color: Colors.red, // Set label color to red
                    fontWeight: FontWeight.bold, // Make label text bold
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _login(context),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
