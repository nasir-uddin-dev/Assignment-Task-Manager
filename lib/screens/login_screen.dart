import 'package:assignment_task_manager/screens/verify_email_screen.dart';
import 'package:assignment_task_manager/screens/main_nav_bar_holder_screen.dart';
import 'package:assignment_task_manager/screens/sign_up_screen.dart';
import 'package:assignment_task_manager/services/api_caller.dart';
import 'package:assignment_task_manager/utils/urls.dart';
import 'package:assignment_task_manager/widgets/background_screen.dart';
import 'package:assignment_task_manager/widgets/centered_progress_indicator.dart';
import 'package:assignment_task_manager/widgets/snack_bar_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final _emailTEController = TextEditingController();
  final _passwordTEController = TextEditingController();

  bool _loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundScreen(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Get Started With",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter a email',
                    labelText: 'Email',
                  ),
                  validator: (String? value) {
                    String inputText = value ?? ' ';
                    if (EmailValidator.validate(inputText) == false) {
                      return 'Enter a valid email';
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordTEController,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password),
                    suffixIcon: Icon(Icons.remove_red_eye_rounded),
                    hintText: 'Enter a password',
                    labelText: 'Password',
                  ),
                  validator: (String? value) {
                    if ((value?.length ?? 0) <= 6) {
                      return 'Enter a password more than 6 letters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Center(
                  child: Visibility(
                    visible: _loginInProgress == false,
                    replacement: CenteredProgressIndicator(),
                    child: FilledButton(
                      onPressed: _onTapLoginButton,
                      child: Icon(Icons.arrow_forward_ios, size: 24),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: _onTapForgottenPasswordButton,
                    child: Text(
                      'Forgotten Password',
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have an account?'),
                    TextButton(
                      onPressed: _onTapSignUpButton,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapLoginButton() {
    _login();
  }

  void _onTapForgottenPasswordButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => VerifyEmailScreen()),
    );
  }

  void _onTapSignUpButton() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
  }

  Future<void> _login() async {
    _loginInProgress = true;
    setState(() {});

    ///Make APi Data
    Map<String, dynamic> requestBody = {
      "email": _emailTEController.text.trim(),
      "password": _passwordTEController.text,
    };

    ///Calling Api
    final ApiResponse response = await ApiCaller.postRequest(
      url: Urls.loginUrl,
      body: requestBody,
    );

    if (response.isSuccess) {
      _clearTextFields();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MainNavBarHolderScreen()),
      );
    } else {
      _loginInProgress = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage!);
    }
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
