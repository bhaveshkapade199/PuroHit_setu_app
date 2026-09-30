import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigation_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigationbar_event.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.read<BottomNavigationBloc>().add(
              const BottomNavigationTabChanged(0),
            );
          },
        ),
        title: const Text("Profile Screen"),
        centerTitle: true,
      ),
    );
  }
}
