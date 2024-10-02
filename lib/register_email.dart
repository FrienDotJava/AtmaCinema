import 'package:flutter/material.dart';
import 'package:tubes/register_data.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordVisible = false;
  late Color myColor;
  late Size mediaSize;
  TextEditingController emailController = TextEditingController();
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
        // color: Color(0xFF000435),
        color: Colors.black.withOpacity(0.75),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _buildInputRegister(),
        ),
      ),
    );
  }

  Widget _buildInputRegister() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Register Account",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-Semibold',
                fontSize: 32,
              ),
            ),
            Text(
              "Enjoy Movie With Us",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins-Regular',
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 35),
            _emailInput(emailController),
            const SizedBox(height: 25),
            _buildContinueButton(),
            const SizedBox(height: 350),
          ],
        ),
      ),
    );
  }

  Widget _emailInput(TextEditingController controller) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        style: TextStyle(
          color: Colors.white,
        ),
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: "Input Your Email Address",
          labelStyle: const TextStyle(
              color: Colors.grey, fontFamily: 'Poppins-Regular'),
          suffixIcon: const Icon(Icons.email, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: const BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: () {
        debugPrint("Email : ${emailController.text}");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterData()),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        backgroundColor: Colors.white,
        elevation: 20,
        shadowColor: Colors.white30,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text(
        "CONTINUE",
        style: TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins-Semibold',
          fontSize: 16,
        ),
      ),
    );
  }
}
