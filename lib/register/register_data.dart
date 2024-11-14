import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/login/login.dart';
import 'package:tubes/register/register_otp.dart';

enum Gender { man, female }

class RegisterData extends StatefulWidget {
  const RegisterData({super.key});

  @override
  State<RegisterData> createState() => _RegisterDataState();
}

class _RegisterDataState extends State<RegisterData> {
  bool isPasswordVisible = false;
  late Color myColor;
  late Size mediaSize;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  Gender? _selectedGender;
  String? email;

  @override
  Widget build(BuildContext context) {
    myColor = Colors.black;
    mediaSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(color: myColor),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 5.0),
              child: _buildTop(),
            ),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterOTPPage()),
            );
          },
        ),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "ATMA ",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins-Bold',
                  fontSize: 28,
                ),
              ),
              TextSpan(
                text: "Cinema",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins-Regular',
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottom() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: SizedBox(
        width: mediaSize.width,
        child: Card(
          color: const Color(0xFF0A2038),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: _buildInputRegister(),
          ),
        ),
      ),
    );
  }

  Widget _buildInputRegister() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "User Information",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-SemiBold',
                fontSize: 32,
              ),
            ),
            const Text(
              "Please input your information",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-Light',
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            _buildGreyText("First Name"),
            _buildFirstNameField(firstNameController),
            const SizedBox(height: 20),
            _buildGreyText("Last Name"),
            _buildLastNameField(lastNameController),
            const SizedBox(height: 20),
            _buildGreyText("Password"),
            _buildPasswordField(passwordController),
            const SizedBox(height: 20),
            _buildGreyText("Phone Number"),
            _buildPhoneField(phoneController, isPhone: true),
            const SizedBox(height: 20),
            _buildGreyText("Date of Birth"),
            _buildDobField(dobController),
            const SizedBox(height: 20),
            _buildGreyText("Gender"),
            const SizedBox(height: 10),
            _buildGenderField(),
            const SizedBox(height: 30),
            _buildRegisterButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        color: Colors.grey,
        fontFamily: 'Poppins-Regular',
      ),
    );
  }

  Widget _buildFirstNameField(TextEditingController controller,
      {bool isEmail = false, bool isPhone = false}) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins-Regular',
      ),
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : isPhone
              ? TextInputType.phone
              : TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Enter first name',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: 'Poppins-Light',
        ),
        suffixIcon: isEmail
            ? const Icon(Icons.email)
            : isPhone
                ? const Icon(Icons.phone)
                : const Icon(Icons.person),
      ),
    );
  }

  Widget _buildLastNameField(TextEditingController controller,
      {bool isEmail = false, bool isPhone = false}) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins-Regular',
      ),
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : isPhone
              ? TextInputType.phone
              : TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Enter last name',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: 'Poppins-Light',
        ),
        suffixIcon: isEmail
            ? const Icon(Icons.email)
            : isPhone
                ? const Icon(Icons.phone)
                : const Icon(Icons.person),
      ),
    );
  }

  Widget _buildPhoneField(TextEditingController controller,
      {bool isEmail = false, bool isPhone = false}) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Poppins-Regular',
      ),
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : isPhone
              ? TextInputType.phone
              : TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Enter phone number',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: 'Poppins-Light',
        ),
        suffixIcon: isEmail
            ? const Icon(Icons.email)
            : isPhone
                ? const Icon(Icons.phone)
                : const Icon(Icons.person),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.white,
      ),
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        hintText: 'Enter password',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: 'Poppins-Light',
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
      ),
    );
  }

  Widget _buildDobField(TextEditingController controller) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.white,
      ),
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Select your date of birth',
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontFamily: 'Poppins-Light',
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: () {
            _selectDate(context, controller);
          },
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
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      setState(() {
        controller.text = formattedDate;
      });
    }
  }

  Widget _buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
                ),
                Text(
                  "Man",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins-Light',
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
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
                ),
                Text(
                  "Female",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins-Light',
                  ),
                ),
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
        await _saveUserData();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.white,
        elevation: 20,
        shadowColor: Colors.black,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "REGISTER",
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins-Semibold',
          fontSize: 16,
        ),
      ),
    );
  }

  Future<void> _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('first_name', firstNameController.text);
    await prefs.setString('last_name', lastNameController.text);
    await prefs.setString('phone_number', phoneController.text);
    await prefs.getString('email');
    await prefs.setString('dob', dobController.text);
    await prefs.setString(
        'gender', _selectedGender == Gender.man ? 'Man' : 'Female');
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }
}
