import 'package:car/utils/colors.dart';
import 'package:car/view/menu/acc_deletion.dart';
import 'package:car/view/menu/acc_information.dart';
import 'package:car/view/menu/acc_security.dart';
import 'package:car/view/menu/feedback.dart';
import 'package:car/view/menu/help.dart';
import 'package:car/view/menu/policies.dart';
import 'package:car/widgets/settingtile.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: kWhite,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Are You sure you want to logout?",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500, color: kBlack),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kYellow)),
                    onPressed: () {},
                    child: Text(
                      "Yes",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: kWhite),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kRed)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: kWhite),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Menu",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.yellow, // Yellow Background
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8), // Adjust padding for size
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
          onPressed: () {},
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(8),
          children: [
            //custom widgets

            Setting(
              title: 'Account Information',
              initialSubtitle: '',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountInformationPage())),
            ),
            Setting(
              title: 'Account Security',
              initialSubtitle: '',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountSecurityPage())),
            ),
            Setting(
              title: 'Policies',
              initialSubtitle: '',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PoliciesPage())),
            ),
            Setting(
              title: 'Help',
              initialSubtitle: '',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HelpPage())),
            ),
            Setting(
              title: 'Feedback',
              initialSubtitle: '',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FeedbackPage())),
            ),
            Setting(
              title: 'Request Account Deletion',
              initialSubtitle: '',
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AccountDeletionPage())),
            ),
            SizedBox(
              height: 25,
            ),
            Center(
              child: OutlinedButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
