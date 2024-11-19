import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/profile/edit_profile.dart';
import 'package:tubes/login/login.dart';
import 'package:tubes/profile/change_password.dart';

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

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('full_name') ?? '-';
      email = prefs.getString('email') ?? '-';
      phoneNumber = prefs.getString('phone_number') ?? '-';
      gender = prefs.getString('gender') ?? '-';
      dob = prefs.getString('dob') ?? '-';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF04031E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF04031E),
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                fullName ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildProfileDetails(),
              const SizedBox(height: 30),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfileDetail('Email', email),
          _buildProfileDetail('Phone Number', phoneNumber),
          _buildProfileDetail('Date of Birth', dob),
          _buildProfileDetail('Gender', gender),
        ],
      ),
    );
  }

  Widget _buildProfileDetail(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value ?? '-',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        _buildProfileButton(
          icon: Icons.edit,
          label: 'Edit Profile',
          color: Colors.grey[850],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfile()),
            );
          },
        ),
        const SizedBox(height: 10),
        _buildProfileButton(
          icon: Icons.lock,
          label: 'Change Password',
          color: Colors.grey[850],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ChangePasswordPage()),
            );
          },
        ),
        const SizedBox(height: 10),
        _buildProfileButton(
          icon: Icons.logout,
          label: 'Logout',
          color: Colors.grey[850],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProfileButton({
    required IconData icon,
    required String label,
    required Color? color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
