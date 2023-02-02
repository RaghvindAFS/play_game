// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game.dart';
import '../widgets/createRoute.dart';
import '../widgets/customTextField.dart';
import '../functions/functions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late List<String> data;
  final _username = TextEditingController();
  final _password = TextEditingController();
  int error = 0;
  double w = 20;
  bool alert = false;

  errorCount() {
    switch (error) {
      case 1:
        {
          setState(() {
            w = 50;
          });
          break;
        }
      case 2:
        {
          setState(() {
            w = 70;
          });
          break;
        }
      case 3:
        {
          setState(() {
            w = 100;
          });
          break;
        }
      default:
        {
          setState(() {
            w = 20;
          });
        }
    }
  }

  Future<bool> loginfunction() async {
    final SharedPreferences prefs = await _prefs;
    data = prefs.getStringList('data') ?? [];
    if (data.isNotEmpty) {
      if (data[1] == _username.text) {
        if (data[3] == _password.text) {
          print('Login Sucessful');
          return true;
        } else {
          showError(context, 'Password is not correct.');
          
          return false;
        }
      } else {
        showError(context, 'Username is not correct.');
        
        return false;
      }
    }
    return false;
  }

  // int _counter = 10;
  Timer? _countdownTimer;
  Duration myDuration = Duration(seconds: 10);

  void _startTimer() {
    print('start');
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      const reduceSecondsBy = 1;
      setState(() {
        // print(seconds);
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        print(seconds);
        if (seconds < 0) {
          _countdownTimer!.cancel();
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
    });
    // _countdownTimer!.cancel();
  }

  _resetTimer() {
    setState(() {
      _countdownTimer!.cancel();
      myDuration = Duration(seconds: 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Welcome to Login Page',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Colors.blueAccent),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomTextFormField(
                    controller: _username,
                    label: 'User Name',
                    hint: 'Email Address',
                    error: 'Please enter Email Address.',
                    keyboard: TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                    controller: _password,
                    label: 'Password',
                    hint: 'Password',
                    error: 'Please enter your password.',
                    keyboard: TextInputType.text),
                SizedBox(
                  height: w,
                ),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (await loginfunction()) {
                            Navigator.of(context)
                                .pushReplacement(CustomPageRoute(const GamePage()));
                          } else {
                            error = error + 1;
                            errorCount();

                            if (error == 3) {
                              _startTimer();
                              Future.delayed(Duration(seconds: 10), () {
                                error = 0;
                                _countdownTimer!.cancel();

                                Navigator.of(context).pushReplacement(
                                    CustomPageRoute(const LoginPage()));
                              });
                            }
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   const SnackBar(
                            //       content: Text('Please enter valid details.')),
                            // );
                            errorCount();
                          }
                        } else {
                          error = error + 1;
                          errorCount();

                          if (error == 3) {
                            _startTimer();
                            Future.delayed(Duration(seconds: 10), () {
                              error = 0;
                              _countdownTimer!.cancel();

                              Navigator.of(context).pushReplacement(
                                  CustomPageRoute(const LoginPage()));
                            });
                          }
                        }
                        ;
                      },
                      child: const Text('Login')),
                ),
                const SizedBox(
                  height: 20,
                ),
                error == 3
                    ? Text(
                        'Login Page will be reload in $seconds seconds.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 30),
                      )
                    :const SizedBox(),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
