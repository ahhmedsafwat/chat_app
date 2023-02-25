import 'package:chatapp/components/btn.dart';
import 'package:chatapp/components/custom_textfield.dart';
import 'package:chatapp/constant.dart';
import 'package:chatapp/helper/show_snackbar.dart';
import 'package:chatapp/screens/blocs/auth_bloc/auth_bloc.dart';
import 'package:chatapp/screens/chat_page.dart';
import 'package:chatapp/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'cubit/chat_cubit/chat_cubit.dart';

class LoginPage extends StatelessWidget {
  static String id = 'LoginPage';

  bool isLoading = false;
  String? email;
  String? password;
  GlobalKey<FormState> formkey = GlobalKey();
  bool visable = true;

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthBlocState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, Chatpage.id, arguments: email);

          isLoading = false;
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMassage);
          isLoading = false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 75,
                  ),
                  Image.asset(
                    kLogo,
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontFamily: 'pacifico',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  Row(
                    children: [
                      Text(
                        'login'.toUpperCase(),
                        style:
                            const TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormFiled(
                    hintText: 'Email',
                    onChange: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormFiled(
                    hintText: 'Password',
                    onChange: (value) {
                      password = value;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    // password visableity
                    passVisabilty: visable,
                    iconButton: IconButton(
                      icon: Icon(
                          visable ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        visable = !visable;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomBtn(
                    title: 'login'.toUpperCase(),
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                            LoginEvent(email: email!, password: password!));
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.pushNamed(context, RegisterPage.id);
                        }),
                        child: Text(
                          "sign up".toUpperCase(),
                          style: const TextStyle(color: Color(0xffc7ede6)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
