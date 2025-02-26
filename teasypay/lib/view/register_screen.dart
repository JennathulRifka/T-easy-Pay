import 'package:flutter/material.dart';
import 'package:teasy/core/services/auth_service.dart';
import 'package:teasy/view/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();

  // For password visibility toggle
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Controllers for the text fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController =
      TextEditingController(); // Separate controller for email
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to free resources
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Function to handle registration
  Future<void> _registerUser() async {
    try {
      // Validation (check if passwords match)
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Passwords do not match")));
        return;
      }

      // Call AuthService to register user with email and password
      await _authService.createUserWithEmailPassword(
        _emailController.text, // Use email for registration
        _passwordController.text,
      );

      // Navigate to login screen after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      // Handle errors (e.g., show error message)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registration failed: $e")));
    }
  }

  // Function for Google Sign-In
  Future<void> _signInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
      // After successful Google sign-in, navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Google sign-in failed: $e")));
    }
  }

  // Function for Apple Sign-In (iOS only)
  Future<void> _signInWithApple() async {
    try {
      await _authService.signInWithApple();
      // After successful Apple sign-in, navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Apple sign-in failed: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 70,
          ), // Reduced overall padding for the form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow, // Background color of the icon button
                  shape: BoxShape.circle, // Make it circular
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
              const SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildLabelAndTextField(
                      "Username",
                      controller: _usernameController,
                      isPassword: false,
                    ),
                    const SizedBox(height: 10),
                    _buildLabelAndTextField(
                      "Email",
                      controller: _emailController,
                      isPassword: false,
                    ), // Separate email field
                    const SizedBox(height: 10),
                    _buildLabelAndTextField(
                      "Phone number",
                      controller: _phoneController,
                      isPassword: false,
                    ),
                    const SizedBox(height: 10),
                    _buildLabelAndTextField(
                      "Password",
                      isPassword: true,
                      isVisible: _isPasswordVisible,
                      controller: _passwordController,
                      toggleVisibility: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    _buildLabelAndTextField(
                      "Confirm password",
                      isPassword: true,
                      isVisible: _isConfirmPasswordVisible,
                      controller: _confirmPasswordController,
                      toggleVisibility: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    const SizedBox(height: 35),
                    _buildRegisterButton(),
                    const SizedBox(height: 25),
                    _buildDivider(),
                    const SizedBox(height: 10),
                    _buildSocialButtons(),
                    const SizedBox(height: 20),
                    _buildLoginRedirect(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
            color: Color(0xFF333333), // Dark gray color for the label
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller, // Use the controller passed as argument
          obscureText:
              isPassword
                  ? !isVisible
                  : false, // Only obscure text for password fields
          style: const TextStyle(
            fontSize: 16, // Increased font size for better readability
            color: Color(0xFF333333), // Dark gray color for the input text
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor:
                Colors.yellow[100], // Light yellow background for input field
            suffixIcon:
                isPassword
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
              borderSide: BorderSide.none, // No border when not focused
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.yellow,
                width: 2,
              ), // Yellow border when focused
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.yellow[100]!,
                width: 1,
              ), // Light yellow border when enabled
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 12,
            ), // Reduced padding for input field
            hintText: 'Enter $label', // Hint text for the input field
            hintStyle: const TextStyle(
              color: Color(0xFF888888), // Light gray color for hint text
              fontSize: 13, // Adjust the font size here
            ),
          ),
          cursorColor: Colors.yellow, // Yellow cursor color
        ),
      ],
    );
  }

Widget _buildRegisterButton() {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.yellow,
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10), // Smaller padding
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),
    onPressed: _registerUser, // Call the registration function
    child: const Text(
      "Create an account",
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
          "or Log in with",
          style: TextStyle(
            fontSize: 16, // Increase font size
            fontWeight: FontWeight.bold, // Make text bold
            color: Color(0xFFB0B0B0) // Change text color (use any color you like)
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
        // IconButton(
        //   icon: Image.asset("assets/facebook.png", height: 40),
        //   onPressed: _signInWithFacebook,  // Trigger Facebook sign-in
        // ),

        
        const SizedBox(width: 20),
        IconButton(
          icon: Image.asset("assets/images/google.png", height: 40),
          onPressed: _signInWithGoogle, // Trigger Google sign-in
        ),
        
        const SizedBox(width: 20),
        IconButton(
          icon: Image.asset("assets/images/google.png", height: 40),
          onPressed: _signInWithGoogle, // Trigger Google sign-in
        ),

        const SizedBox(width: 20),
        IconButton(
          icon: Image.asset("assets/images/apple.png", height: 40),
          onPressed: _signInWithApple, // Trigger Apple sign-in (iOS only)
        ),
      ],
    );
  }

Widget _buildLoginRedirect(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Already have an account? ",
        style: TextStyle(
          fontSize: 16, // Adjust the font size
          fontWeight: FontWeight.normal, // Adjust the font weight
          color: Color(0xFFB0B0B0), // Light gray color
        ),
      ),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: Text(
          "Log in",
          style: TextStyle(
           // fontSize: 16, // Increase font size
           // fontWeight: FontWeight.bold, // Make text bold
            color: Color(0xFFB0B0B0) // Change text color (use any color you like)
          ),
        ),
      ),
    ],
  );
}
}
