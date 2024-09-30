import 'package:flutter/material.dart';

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            _buildGreyText("Username"),
            _buildInputField(usernameController),
            const SizedBox(height: 20),
            _buildGreyText("Nama"),
            _buildInputField(nameController),
            const SizedBox(height: 20),
            _buildGreyText("Password"),
            _buildPasswordField(passwordController),
            const SizedBox(height: 20),
            _buildGreyText("Nomor Telepon"),
            _buildInputField(phoneController, isPhone: true),
            const SizedBox(height: 70),
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
        backgroundColor: Colors.blue,
        elevation: 20,
        shadowColor: Colors.black,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text(
        "REGISTER",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
