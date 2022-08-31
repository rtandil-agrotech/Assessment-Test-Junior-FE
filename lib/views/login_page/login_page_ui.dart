// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modul_fe/bloc/login/user_login/user_login_bloc.dart';
import 'package:flutter_modul_fe/models/login_model/login_post_model.dart';
import 'package:flutter_modul_fe/theme/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginPageUi extends StatefulWidget {
  const LoginPageUi({Key? key}) : super(key: key);

  @override
  LoginPageUiState createState() => LoginPageUiState();
}

class LoginPageUiState extends State<LoginPageUi> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserLoginBloc, UserLoginState>(
      listener: (context, state) {
        if (state is UserLoginDone) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      },
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 26, bottom: 37),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: UsedColors.blueTitle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 30, right: 38),
              child: Row(
                children: [
                  Icon(Icons.alternate_email_outlined),
                  SizedBox(width: 17),
                  Flexible(
                    child: FormBuilderTextField(
                      name: "email",
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Email",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Kolom tidak boleh kosong"),
                        FormBuilderValidators.email(
                            errorText: "Email tidak valid"),
                      ]),
                      valueTransformer: (String? value) {
                        if (value != null) {
                          return value.trim();
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 30, right: 38),
              child: Row(
                children: [
                  Icon(Icons.lock_outlined),
                  SizedBox(width: 17),
                  Flexible(
                    child: FormBuilderTextField(
                      name: "password",
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Password",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: "Kolom tidak boleh kosong"),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<UserLoginBloc, UserLoginState>(
              builder: (context, state) {
                if (state is UserLoginFailed) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Center(
                      child: Text(
                        "Login Failed : ${state.errorMessage}",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            BlocBuilder<UserLoginBloc, UserLoginState>(
                builder: (context, state) {
              if (state is UserLoginLoading) {
                return Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(219, 41),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: null,
                    child: SpinKitThreeBounce(
                      color: UsedColors.customGrey,
                      size: 30,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: UsedColors.blueButton,
                      fixedSize: Size(219, 41),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.saveAndValidate()) {
                        BlocProvider.of<UserLoginBloc>(context).add(
                          DoAuthenticateUser(
                            data: LoginPostModel(
                              email: _formKey.currentState!.value['email'],
                              password:
                                  _formKey.currentState!.value['password'],
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            }),
            SizedBox(height: 59),
          ],
        ),
      ),
    );
  }
}
