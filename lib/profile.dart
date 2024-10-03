import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? fullName;
  String? email;
  String? phoneNumber;
  String? gender;
  String? dob;
  String? password;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('full_name');
      email = prefs.getString('email');
      phoneNumber = prefs.getString('phone_number');
      gender = prefs.getString('gender');
      dob = prefs.getString('dob');
      password = prefs.getString('password');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mediaSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage("images/bg5.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Stack(
          children: [
            Container(
              width: mediaSize.width,
              height: mediaSize.height,
              color: Colors.black.withOpacity(0.5),
            ),
            Positioned(
              bottom: 0,
              child: _buildProfileCard(mediaSize),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(Size mediaSize) {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        color: Colors.black.withOpacity(0.75),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildProfileDetails(),
        ),
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: const AssetImage('images/profile_placeholder.png'),
        ),
        const SizedBox(height: 20),
        _buildGreyText('Full Name'),
        _buildWhiteText(fullName),
        const SizedBox(height: 10),
        _buildGreyText('Email'),
        _buildWhiteText(email),
        const SizedBox(height: 10),
        _buildGreyText('Phone Number'),
        _buildWhiteText(phoneNumber),
        const SizedBox(height: 10),
        _buildGreyText('Gender'),
        _buildWhiteText(gender),
        const SizedBox(height: 10),
        _buildGreyText('Date of Birth'),
        _buildWhiteText(dob),
        const SizedBox(height: 10),
        _buildGreyText('Password'),
        _buildWhiteText(password, color: Colors.red),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildWhiteText(String? text, {Color color = Colors.white}) {
    return Text(
      text ?? '-',
      style: TextStyle(color: color, fontSize: 18),
    );
  }
}
