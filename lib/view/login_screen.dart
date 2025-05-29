import 'package:flutter/material.dart';
import 'package:teasy/core/services/auth_service.dart';
import 'package:teasy/view/admin/admin_home.dart';
import 'package:teasy/view/homePage.dart';
import 'package:teasy/view/register_screen.dart';
import 'package:go_router/go_router.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  bool _isPasswordVisible = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  splashColor: Colors.yellow,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'assets/images/logo.jpeg',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildLabelAndTextField(
                      "Email",
                      isPassword: false,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 10),
                    _buildLabelAndTextField(
                      "Password",
                      isPassword: true,
                      isVisible: _isPasswordVisible,
                      controller: _passwordController,
                      toggleVisibility: _togglePasswordVisibility,
                    ),
                    const SizedBox(height: 35),
                    _buildLoginButton(context),
                    const SizedBox(height: 25),
                    _buildDivider(),
                    const SizedBox(height: 10),
                    _buildSocialButtons(),
                    const SizedBox(height: 20),
                    _buildRegisterRedirect(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Widget _buildLabelAndTextField(
    String label, {
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? toggleVisibility,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword ? !isVisible : false,
          style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.yellow[100],
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: toggleVisibility,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.yellow, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.yellow[100]!, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ),
            hintText: 'Enter $label',
            hintStyle: const TextStyle(color: Color(0xFF888888), fontSize: 13),
          ),
          cursorColor: Colors.yellow,
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: () async {
        String email = _emailController.text.trim();
        String password = _passwordController.text.trim();

        // try {
        //   // Check for hardcoded admin credentials
        //   if (email == 'admin1' && password == 'pass') {
        //     // Navigate to admin page
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => AdminHome()),
        //     );
        //   } else {
        //     // Attempt normal user login
        //     await _authService.signInWithEmailPassword(email, password);

        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(builder: (context) => HomePage()),
        //     );
        //   }
        // } catch (e) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text("Login failed: $e")),
        //   );
        // }

try {
  // Check for hardcoded admin credentials
  if (email == 'admin1' && password == 'pass') {
    // Navigate to admin page using go_router
    context.go('/adminHome');
  } else {
    // Attempt normal user login
    await _authService.signInWithEmailPassword(email, password);

    // Navigate to home page using go_router
    context.go('/homePage');
  }
} catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Login failed: $e")),
  );
}


      },
      child: const Text(
        "Login",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Divider(thickness: 1, color: Colors.black)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            "or login with",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB0B0B0),
            ),
          ),
        ),
        Expanded(child: Divider(thickness: 1, color: Colors.black)),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Image.asset("assets/images/google.png", height: 40),
          onPressed: () async {
            try {
              await _authService.signInWithGoogle();
            } catch (e) {
              print("Google sign-in failed: $e");
            }
          },
        ),
        const SizedBox(width: 20),
        IconButton(
          icon: Image.asset("assets/images/apple.png", height: 40),
          onPressed: () async {
            try {
              await _authService.signInWithApple();
            } catch (e) {
              print("Apple sign-in failed: $e");
            }
          },
        ),
      ],
    );
  }

  Widget _buildRegisterRedirect(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFFB0B0B0),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          child: const Text(
            "Sign up",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB0B0B0),
            ),
          ),
        ),
      ],
    );
  }
}
