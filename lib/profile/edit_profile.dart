import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/entity/User.dart';

import '../client/UserClient.dart';

enum Gender { man, female }

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isPasswordVisible = false;
  late Size mediaSize;
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  Gender? _selectedGender;
  String? profilePicturePath;

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          title: const Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _buildProfilePicture(context),
                  const SizedBox(height: 30),
                  _buildInputField("First Name", nameController),
                  const SizedBox(height: 20),
                  _buildInputField("Last Name", lastNameController),
                  const SizedBox(height: 20),
                  _buildInputField("Phone Number", phoneController,
                      isPhone: true),
                  const SizedBox(height: 20),
                  _buildDobField(dobController),
                  const SizedBox(height: 20),
                  _buildGenderField(),
                  const SizedBox(height: 30),
                  _buildRegisterButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          backgroundImage: profilePicturePath != null
              ? FileImage(File(profilePicturePath!))
              : null,
          child: profilePicturePath == null
              ? const Icon(Icons.person, size: 50, color: Colors.black)
              : null,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                _showProfilePictureOptions(context);
              },
              icon: const Icon(Icons.edit, size: 15, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  void _showProfilePictureOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Take a Picture'),
                onTap: () async {
                  Navigator.pop(context);
                  final imagePath = await Navigator.pushNamed(context, '/camera');
                  if (imagePath != null && mounted) {
                    setState(() {
                      profilePicturePath = imagePath as String;
                    });
                  }
                },
              ),
              ListTile(
                title: const Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  await _openGallery();
                },
              ),
              ListTile(
                title: const Text('Remove Profile Picture'),
                onTap: () {
                  Navigator.pop(context);
                  _removeProfilePicture();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null && mounted) {
      setState(() {
        profilePicturePath = image.path;
      });
    }
  }

  void _removeProfilePicture() {
    setState(() {
      profilePicturePath = null;
    });
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {bool isPhone = false}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDobField(TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Date of Birth",
        labelStyle: const TextStyle(color: Colors.white),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today, color: Colors.grey),
          onPressed: () {
            _selectDate(context, controller);
          },
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Gender",
            style: TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 10),
        Row(
          children: [
            Row(
              children: [
                Radio<Gender>(
                  value: Gender.man,
                  groupValue: _selectedGender,
                  onChanged: (Gender? value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  activeColor: Colors.white,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const Text("Male", style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                Radio<Gender>(
                  value: Gender.female,
                  groupValue: _selectedGender,
                  onChanged: (Gender? value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  activeColor: Colors.white,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const Text("Female", style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_isValidInput()) {
          bool success = await _updateUserProfile();
          if (success) {
            _showSuccessDialog();
          } else {
            _showErrorDialog("Failed to update profile. Please try again.");
          }
        } else {
          _showErrorDialog("Please fill out all fields correctly.");
        }
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.white,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "SAVE CHANGES",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('first_name', nameController.text);
    await prefs.setString('last_name', lastNameController.text);
    await prefs.setString('phone_number', phoneController.text);
    await prefs.setString('dob', dobController.text);
    await prefs.setString(
        'gender', _selectedGender == Gender.man ? 'Male' : 'Female');
    await prefs.setString('profile_picture', profilePicturePath ?? "");
  }

  bool _isValidInput() {
    return nameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        _selectedGender != null;
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Changes"),
          content: const Text("Are you sure you want to save the changes?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                await _saveUserData();
                Navigator.pop(context);
                _showSuccessDialog();
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Profile updated successfully!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<bool> _updateUserProfile() async {
    String first_name = nameController.text;
    String last_name = lastNameController.text;
    String no_telp = phoneController.text;
    String tanggal_lahir = dobController.text;
    String gender = _selectedGender == Gender.man ? 'Male' : 'Female';

    File? profilePicture;
    if (profilePicturePath != null) {
      profilePicture = File(profilePicturePath!);
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    bool success = await UserClient.updateProfile(token!, first_name, last_name, no_telp, gender, tanggal_lahir);

    if (mounted) {
      if (success) {
        _showSuccessDialog();

        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.pop(context);
            Navigator.pop(context);
          }
        });
      } else {
        _showErrorDialog("Failed to update profile. Please try again.");
      }
    }

    return success;
  }


}
