// ignore_for_file: unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/createRoute.dart';
import '../widgets/customTextField.dart';
import '../functions/functions.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late bool success;
  late List<String> _data;

  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _cnfpass = TextEditingController();

  Future<bool> saveData() async {
    final SharedPreferences prefs = await _prefs;
    _data = [
      '${_name.text}',
      '${_email.text}',
      '${_phone.text}',
      '${_pass.text}'
    ];
    await prefs.setStringList('data', _data).then((value) {
      success = value;
    });
    print(success);
    print(prefs.get('data') ?? 'Not available');
    if (success) {
      return true;
    } else {
      return false;
    }
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Welcome to SignUp Page',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Colors.blueAccent),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTextFormField(
                  controller: _name,
                  error: 'Please enter your name.',
                  hint: 'Raghav Yadav',
                  label: 'Name',
                  keyboard: TextInputType.name,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  controller: _email,
                  error: 'Please enter your email address.',
                  hint: 'abc@xyz.com',
                  label: 'Email address',
                  keyboard: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    controller: _phone,
                    label: 'Phone Number',
                    hint: '99xxxxxx00',
                    error: 'Please enter your phone number.',
                    keyboard: TextInputType.phone),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    controller: _pass,
                    label: 'Password',
                    hint: '',
                    error: 'Please enter your password',
                    keyboard: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    controller: _cnfpass,
                    label: 'Confirm Password',
                    hint: '',
                    error: 'Please confirm password.',
                    keyboard: TextInputType.text),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_cnfpass.text == _pass.text) {
                            if (await saveData()) {
                              Navigator.of(context)
                                  .push(CustomPageRoute(const LoginPage()));
                            }
                          } else {
                            showError(context,'Password not matched with confirm password.');
                          }
                        } else {
                          showError(context,'Data is not correct.');
                          
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 20),
                      )),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  
}
