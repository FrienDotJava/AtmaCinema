import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGreyText("Email"),
              _buildInputField(emailController, isEmail: true),
              const SizedBox(height: 20),
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
              _buildInputField(phoneController,
                  isPhone: true), // Nomor telepon menggunakan keyboard angka
              const SizedBox(height: 40),
              _buildRegisterButton(),
            ],
          ),
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
              ? TextInputType
                  .phone // Gunakan keyboard angka untuk input nomor telepon
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
        debugPrint("Email : ${emailController.text}");
        debugPrint("Username : ${usernameController.text}");
        debugPrint("Nama : ${nameController.text}");
        debugPrint("Password : ${passwordController.text}");
        debugPrint("Nomor Telepon : ${phoneController.text}");
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
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
