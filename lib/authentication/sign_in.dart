import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stock/constants/constants.dart';
import 'package:stock/services/auth_service.dart';
import 'package:stock/widgets/text_field.dart';

class SignIn extends StatefulWidget {
  final Function toggleScreen;
  SignIn({required this.toggleScreen});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  String? error;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthService>(context);
    error = loginProvider.errorMessage;
    return Scaffold(
      backgroundColor: kThemeColor,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Sign In to view stocks',
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFieldWidget(
                obscureText: false,
                hintText: 'Input email .....',
                title: 'Email Address',
                controller: _emailController,
                validator: (val) =>
                    val!.isNotEmpty ? null : "Please enter an email address!",
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFieldWidget(
                obscureText: true,
                hintText: 'Input password .....',
                title: 'Password',
                controller: _passwordController,
                validator: (val) =>
                    val!.length < 6 ? "Enter more than 6 char" : null,
                keyboardType: TextInputType.text,
              ),
            ),
            InkResponse(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  print("Email: ${_emailController.text}");
                  print("Password: ${_passwordController.text}");
                  await loginProvider.signIn(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                }
              },
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: loginProvider.isLoading
                      ? Container(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.grey.shade900,
                            ),
                            strokeWidth: 3,
                          ),
                        )
                      : Text(
                          'Sign In',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () => widget.toggleScreen(),
              child: RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sign up',
                      style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if (loginProvider.errorMessage != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  0,
                  20,
                  0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amberAccent,
                  ),
                  child: ListTile(
                    title: Text(
                      error!,
                      style: GoogleFonts.raleway(
                        color: kThemeColor,
                      ),
                    ),
                    leading: Icon(
                      Icons.error,
                      color: kThemeColor,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: kThemeColor,
                      ),
                      onPressed: () => loginProvider.setMessage(null),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void toggle() {
    bool visibility = false;
    visibility = !visibility;
  }
}
