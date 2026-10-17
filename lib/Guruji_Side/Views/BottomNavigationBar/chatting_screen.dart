import 'package:flutter/material.dart';

import 'package:purohitset_app/Widget/custom_appbar.dart';

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios),
      //     onPressed: () {
      //       context.read<BottomNavigationBloc>().add(
      //         const BottomNavigationTabChanged(0),
      //       );
      //     },
      //   ),
      //   title: const Text("Chatting Screen"),
      //   centerTitle: true,
      // ),
      appBar: CustomAppBar(
        title: "Chatting Screen",
        centerTitle: true,
        showLogo: false,
      ),
    );
  }
}
