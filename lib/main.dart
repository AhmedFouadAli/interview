import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewquestion/cande.dart';
import 'package:interviewquestion/cubit/statecande_cubit.dart';
import 'package:interviewquestion/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatelessWidget {
  HomeWidget({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final userName = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interview")),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: userName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' user name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'password',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      var resultIndex = StoreData.allData.firstWhere(
                          (element) => element["userName"] == userName.text,
                          orElse: () => null);
                      var resultChecking =
                          resultIndex["password"] == password.text;
                      if (resultChecking) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => StatecandeCubit(),
                                    child: Candy(),
                                  )),
                        );
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Some data is wrong'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      var resultIndex = StoreData.allData.firstWhere(
                          (element) => element["userName"] == userName.text,
                          orElse: () => null);
                      if (resultIndex == null) {
                        StoreData.addData(userName.text, password.text);
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                    create: (context) => StatecandeCubit(),
                                    child: Candy(),
                                  )),
                        );
                      } else {
                        final snackBar = SnackBar(
                          content: Text(
                              'Sorry the user name is exist ${userName.text}'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text('Sign up', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
