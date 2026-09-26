import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Bloc/BottomNavigationBar/bottomNavigation_bloc.dart';
import 'package:purohitset_app/Bloc/BottomNavigationBar/bottomNavigationbar_event.dart';
import 'package:purohitset_app/Bloc/BottomNavigationBar/bottomNavigationbar_state.dart';
import 'package:purohitset_app/Views/BottomNavigationBar/booking_history_screen.dart';
import 'package:purohitset_app/Views/BottomNavigationBar/chatting_screen.dart';
import 'package:purohitset_app/Views/BottomNavigationBar/profile_screen.dart';
import 'package:purohitset_app/Views/BottomNavigationBar/reels_screen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return PopScope(
          canPop: state.currentIndex == 0,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            if (state.currentIndex != 0) {
              context.read<BottomNavigationBloc>().add(
                const BottomNavigationTabChanged(0),
              );
            }
          },
          child: SafeArea(
            top: false,
            left: false,
            right: false,
            bottom: true,
            child: Scaffold(
              backgroundColor: const Color(0xFFFFF5EA),

              appBar: state.currentIndex == 0
                  ? PreferredSize(
                      preferredSize: const Size(double.infinity, 55),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD3A1).withValues(alpha: 0.8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 3,
                            right: 8,
                            top: 10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 85,
                                width: 85,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'Assets/Images/purohit-setu-logo.webp',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Color(0xFFEB4A0A),
                                      size: 24,
                                    ),

                                    const SizedBox(width: 2),

                                    const Expanded(
                                      child: Text(
                                        "Pune, Maharashtra, India",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Card(
                                elevation: 1,

                                color: const Color(
                                  0xFFE0AC69,
                                ).withValues(alpha: 0.5),
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFFE0AC69,
                                    ).withValues(alpha: 0.5),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Icon(Icons.notifications_none_outlined),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : null,
              body: IndexedStack(
                index: state.currentIndex,
                children: const [
                  HomeTab(),
                  BookingHistoryScreen(),
                  ReelsScreen(),
                  ChattingScreen(),
                  ProfileScreen(),
                ],
              ),

              bottomNavigationBar: CircleNavBar(
                activeIndex: state.currentIndex,

                activeIcons: const [
                  _NavItem(
                    icon: Icons.home_rounded,
                    label: "Home",
                    isActive: true,
                  ),
                  _NavItem(
                    icon: Icons.book_online_sharp,
                    label: "Booking",
                    isActive: true,
                  ),
                  _NavItem(
                    icon: Icons.mobile_screen_share_outlined,
                    label: "Reels",
                    isActive: true,
                  ),
                  _NavItem(
                    icon: Icons.chat_bubble_rounded,
                    label: "Chat",
                    isActive: true,
                  ),
                  _NavItem(
                    icon: Icons.person_rounded,
                    label: "Profile",
                    isActive: true,
                  ),
                ],

                inactiveIcons: const [
                  _NavItem(icon: Icons.home_rounded, label: "Home"),
                  _NavItem(
                    icon: Icons.book_online_sharp,
                    label: "Booking",
                  ),
                  _NavItem(
                    icon: Icons.mobile_screen_share_outlined,
                    label: "Reels",
                  ),
                  _NavItem(
                    icon: Icons.chat_bubble_outline_outlined,
                    label: "Chat",
                  ),
                  _NavItem(icon: Icons.person_rounded, label: "Profile"),
                ],

                color: Colors.black,
                circleColor: Colors.white,
                height: 70,
                circleWidth: 60,

                cornerRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),

                shadowColor: Colors.black26,
                circleShadowColor: const Color(0xFFE5A900),
                elevation: 10,

                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFFFD3A1).withValues(alpha: 0.8),
                    const Color(0xFFFFD3A1).withValues(alpha: 0.8),
                  ],
                ),

                circleGradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFB35C2D),
                    Color(0xFFEB4A0A),
                    Color(0xFFC73700),
                  ],
                ),

                onTap: (index) {
                  context.read<BottomNavigationBloc>().add(
                    BottomNavigationTabChanged(index),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
// class Homescreen extends StatelessWidget {
//   const Homescreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
//       builder: (context, state) {
//         return SafeArea(
//           child: Scaffold(
//             backgroundColor: const Color.fromARGB(
//               255,
//               255,
//               239,
//               221,
//             ).withValues(alpha: 0.2),

//             appBar: PreferredSize(
//               preferredSize: const Size(double.infinity, 70),
// child: Container(
//   decoration: BoxDecoration(
//     color: const Color(0xFFFFD3A1).withValues(alpha: 0.8),
//     boxShadow: const [
//       BoxShadow(
//         color: Colors.black26,
//         blurRadius: 8,
//         spreadRadius: 1,
//         offset: Offset(0, 3),
//       ),
//     ],
//   ),
//   child: Padding(
//     padding: const EdgeInsets.only(left: 3, right: 8),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//           height: 80,
//           width: 80,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(
//                 'Assets/Images/purohit-setu-logo.webp',
//               ),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),

//         Expanded(
//           child: Row(
//             children: [
//               const Icon(
//                 Icons.location_on,
//                 color: Color(0xFFEB4A0A),
//                 size: 24,
//               ),

//               const SizedBox(width: 5),

//               const Expanded(
//                 child: Text(
//                   "Pune, Maharashtra, India",
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),

//         Container(
//           decoration: BoxDecoration(
//             color: const Color(0xFFE0AC69).withValues(alpha: 0.5),
//             shape: BoxShape.circle,
//             border: Border.all(width: 0.5, color: Colors.white),
//           ),
//           child: IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.notifications_none_sharp),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
// ),

//             body: _buildScreen(state.currentIndex),

//             bottomNavigationBar: CircleNavBar(
//               activeIndex: state.currentIndex,

//               activeIcons: const [
//                 _NavItem(
//                   icon: Icons.home_rounded,
//                   label: "Home",
//                   isActive: true,
//                 ),
//                 _NavItem(
//                   icon: Icons.info_rounded,
//                   label: "About",
//                   isActive: true,
//                 ),
//                 _NavItem(
//                   icon: Icons.calendar_month_rounded,
//                   label: "Booking",
//                   isActive: true,
//                 ),
//                 _NavItem(
//                   icon: Icons.chat_bubble_rounded,
//                   label: "Chat",
//                   isActive: true,
//                 ),
//                 _NavItem(
//                   icon: Icons.person_rounded,
//                   label: "Profile",
//                   isActive: true,
//                 ),
//               ],

//               inactiveIcons: const [
//                 _NavItem(icon: Icons.home_rounded, label: "Home"),
//                 _NavItem(icon: Icons.info_rounded, label: "About"),
//                 _NavItem(icon: Icons.calendar_month_rounded, label: "Booking"),
//                 _NavItem(
//                   icon: Icons.chat_bubble_outline_outlined,
//                   label: "Chat",
//                 ),
//                 _NavItem(icon: Icons.person_rounded, label: "Profile"),
//               ],

//               color: Colors.black,

//               circleColor: Colors.white,

//               height: 70,

//               // circleWidth MUST be <= height
//               circleWidth: 60,

//               cornerRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(8),
//                 topRight: Radius.circular(8),
//                 bottomLeft: Radius.circular(8),
//                 bottomRight: Radius.circular(8),
//               ),

//               shadowColor: Colors.black26,
//               circleShadowColor: const Color(0xFFE5A900),

//               elevation: 10,

//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color(0xFFFFD3A1).withValues(alpha: 0.8),
//                   const Color(0xFFFFD3A1).withValues(alpha: 0.8),
//                 ],
//               ),

//               circleGradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [
//                   Color.fromARGB(255, 179, 92, 45),
//                   Color(0xFFEB4A0A),
//                   Color(0xFFC73700),
//                 ],
//               ),

//               onTap: (index) {
//                 context.read<BottomNavigationBloc>().add(
//                   BottomNavigationTabChanged(index),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildScreen(int index) {
//     switch (index) {
//       case 0:
//         return const Homescreen();

//       case 1:
//         return const ReelsScreen();

//       case 2:
//         return const BookingHistoryScreen();

//       case 3:
//         return const ChattingScreen();

//       case 4:
//         return const ProfileScreen();

//       default:
//         return const Homescreen();
//     }
//   }
// }

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 25,
          color: isActive ? const Color.fromARGB(255, 0, 0, 0) : Colors.black54,
        ),

        const SizedBox(height: 2),

        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? Colors.black87 : Colors.black87,
          ),
        ),
      ],
    );
  }
}
