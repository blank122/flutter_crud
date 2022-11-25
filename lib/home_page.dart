import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:week_5_task_1/text_style.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  var spacer = const SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Main Dashboard',
          style: mainArticleStyle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.circlePlus,
                color: Colors.grey[200],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            spacer,
            Text(
              'Signed in as : ${user?.email!}',
              style: GoogleFonts.dmSans(
                fontSize: 16,
              ),
            ),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.blue,
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
