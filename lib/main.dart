import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/Forget_password_bloc/forget_password_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigation_bloc.dart';

import 'package:purohitset_app/Repository/Guruji_Auth_Repo/auth_repository.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/login_bloc/login_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Auth/register_bloc/register_bloc.dart';
import 'package:purohitset_app/Widget/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  final authRepository = AuthRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc(authRepository)),
        BlocProvider(create: (_) => RegisterBloc(authRepository)),
        BlocProvider(create: (_) => BottomNavigationBloc()),
        BlocProvider(create: (_) => ForgetPasswordBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
