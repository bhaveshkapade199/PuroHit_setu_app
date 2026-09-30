import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigation_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigationbar_event.dart';
// import 'package:purohitset_app/Views/Homescreen/homescreen.dart';

class BookingHistoryScreen extends StatelessWidget {
  const BookingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => HomeTab()),
            // );
            context.read<BottomNavigationBloc>().add(
              const BottomNavigationTabChanged(0),
            );
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Booking History"),
      ),
    );
  }
}
