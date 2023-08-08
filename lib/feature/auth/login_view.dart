import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:synapsis_test/feature/halaman_a.dart/halaman_a_view.dart';
import 'package:synapsis_test/widget/textfield_login.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final LocalAuthentication auth;

  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) => setState(() {
          _isAuthenticated = isSupported;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Icon(Icons.account_circle,
                      size: 100, color: Colors.deepPurple),
                ),
                TextFieldLogin(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  controller: _usernameController,
                  hintName: 'username',
                  icon: Icons.account_circle,
                ),
                const SizedBox(height: 20),
                TextFieldLogin(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  controller: _passwordController,
                  hintName: 'password',
                  icon: Icons.lock,
                  isobscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _loginWithCredentials();
                  },
                  child: const Text(
                    'Login with Username & Password',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _authenticate,
                  child: const Text('Authenticate fingerprint'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginWithCredentials() {
    if (_formKey.currentState?.validate() == true) {
      if (_usernameController.text == 'admin' &&
          _passwordController.text == 'admin') {
        _navigateToHalamanA();
      } else {}
    }
  }

  void _navigateToHalamanA() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HalamanA()),
    );
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: true));
      print('Authenticated: $authenticated');
      if (authenticated) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HalamanA()));
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
