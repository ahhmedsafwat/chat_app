import 'package:chatapp/screens/blocs/auth_bloc/auth_bloc.dart';
import 'package:chatapp/screens/chat_page.dart';
import 'package:chatapp/screens/cubit/auth_cubit/auth_cubit.dart';
import 'package:chatapp/screens/cubit/chat_cubit/chat_cubit.dart';
import 'package:chatapp/screens/login_page.dart';
import 'package:chatapp/screens/register_page.dart';
import 'package:chatapp/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
          child: Container(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
          child: Container(),
        )
      ],
      child: MaterialApp(
        routes: {
          LoginPage.id: (context) {
            return LoginPage();
          },
          RegisterPage.id: ((context) {
            return RegisterPage();
          }),
          Chatpage.id: (context) {
            return Chatpage();
          }
        },
        debugShowCheckedModeBanner: false,
        initialRoute: 'LoginPage',
      ),
    );
  }
}
