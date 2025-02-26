import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Google Sign-In Button
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            // Simulate Google login logic
            print("Google login button clicked");
          },
          icon: Image.asset("assets/google.png", height: 24),
          label: const Text("Continue with Google"),
        ),
        const SizedBox(height: 10),

        // Facebook Sign-In Button
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () {
            // Simulate Facebook login logic
            print("Facebook login button clicked");
          },
          icon: Image.asset("assets/facebook.png", height: 24),
          label: const Text("Continue with Facebook"),
        ),
        const SizedBox(height: 10),

        // Apple Sign-In Button (Only for iOS)
        if (Theme.of(context).platform == TargetPlatform.iOS)
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              // Simulate Apple login logic
              print("Apple login button clicked");
            },
            icon: Image.asset("assets/apple.png", height: 24),
            label: const Text("Continue with Apple"),
          ),
      ],
    );
  }
}
