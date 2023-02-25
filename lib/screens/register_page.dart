import 'package:chatapp/components/btn.dart';
import 'package:chatapp/components/custom_textfield.dart';
import 'package:chatapp/constant.dart';
import 'package:chatapp/screens/chat_page.dart';
import 'package:chatapp/screens/cubit/auth_cubit/auth_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snackbar.dart';

class RegisterPage extends StatelessWidget {
  static String id = 'RegisterPage';
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();
  bool visable = true;

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.pushNamed(context, Chatpage.id, arguments: email);
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errorMassage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
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
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'pacifico',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        Text(
                          'Register'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormFiled(
                      hintText: "Email",
                      onChange: (data) {
                        email = data;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // CustomTextFiled(hintText: 'User Name'),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    CustomTextFormFiled(
                      hintText: "Password",
                      onChange: (data) {
                        password = data;
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
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context)
                              .registerUser(email: email!, password: password!);
                        }
                      },
                      title: "register".toUpperCase(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'I Have an account ',
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'login'.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xffc7ede6),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
