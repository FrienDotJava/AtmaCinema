import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    myColor = Colors.white12;
    mediaSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("images/bg5.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
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
            Positioned(bottom: 0, child: _buildBottom()),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        color: Colors.black.withOpacity(0.75),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildInputRegister(),
        ),
      ),
    );
  }

  Widget _buildInputRegister() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Input Your Data",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-SemiBold',
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 30),
            _buildGreyText("Full Name"),
            _buildInputField(nameController),
            const SizedBox(height: 20),
            _buildGreyText("Password"),
            _buildPasswordField(passwordController),
            const SizedBox(height: 20),
            _buildGreyText("Phone Number"),
            _buildInputField(phoneController, isPhone: true),
            const SizedBox(height: 20),
            _buildGreyText("Date of Birth"),
            _buildDobField(dobController),
            const SizedBox(height: 20),
            _buildGreyText("Gender"),
            const SizedBox(height: 10),
            _buildGenderField(),
            const SizedBox(height: 50),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {bool isEmail = false, bool isPhone = false}) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: Colors.white,
      ),
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : isPhone
              ? TextInputType.phone
              : TextInputType.text,
      decoration: InputDecoration(
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
      onPressed: () {
        debugPrint("Username : ${usernameController.text}");
        debugPrint("Nama : ${nameController.text}");
        debugPrint("Password : ${passwordController.text}");
        debugPrint("Nomor Telepon : ${phoneController.text}");
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
}
