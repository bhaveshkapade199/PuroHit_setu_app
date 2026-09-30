import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigation_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigationbar_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigationbar_state.dart';
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/booking_history_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/chatting_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/profile_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/reels_screen.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  // Scaffold key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        final size = MediaQuery.sizeOf(context);
        final isLandscape =
            MediaQuery.orientationOf(context) == Orientation.landscape;
        final appBarHeight = isLandscape ? 56.0 : 64.0;

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
            top: true,
            left: true,
            right: true,
            bottom: true,
            child: Scaffold(
              // Attach key to Scaffold
              key: scaffoldKey,

              backgroundColor: const Color(0xFFFFF5EA),

              // ------------------------------------------------
              // APP BAR
              // ------------------------------------------------
              appBar: state.currentIndex == 0
                  ? PreferredSize(
                      preferredSize: Size(double.infinity, appBarHeight),
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // ------------------------------------------------
                              // DRAWER MENU BUTTON
                              // ------------------------------------------------
                              Image.asset(
                                'Assets/Images/purohit-setu-logo.webp',
                                height: isLandscape ? 44 : 50,
                                width: isLandscape ? 44 : 50,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 8),

                              // ------------------------------------------------
                              // LOCATION
                              // ------------------------------------------------
                              const Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Color(0xFFEB4A0A),
                                      size: 22,
                                    ),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        "Pune, Maharashtra",
                                        maxLines: 1,
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

                              // ------------------------------------------------
                              // NOTIFICATION
                              // ------------------------------------------------
                              Container(
                                padding: const EdgeInsets.all(7),
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
                                child: const Icon(
                                  Icons.notifications_none_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  scaffoldKey.currentState?.openDrawer();
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                  size: 26,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : null,

              drawer: Drawer(
                width: (size.width * 0.75).clamp(260.0, 320.0),

                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      margin: EdgeInsets.zero,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 235, 156, 10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Image.asset(
                                  'Assets/Images/purohit-setu-logo.webp',
                                  fit: BoxFit.contain,
                                ),
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                "Purohitsetu",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              size: 28,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.home_rounded,
                            color: Color(0xFFEB4A0A),
                          ),
                          title: const Text(
                            "Home",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            Navigator.pop(context);

                            context.read<BottomNavigationBloc>().add(
                              const BottomNavigationTabChanged(0),
                            );
                          },
                        ),

                        // ------------------------------------------------
                        // PROFILE
                        // ------------------------------------------------
                        ListTile(
                          leading: const Icon(
                            Icons.person_rounded,
                            color: Color(0xFFEB4A0A),
                          ),
                          title: const Text(
                            "Profile",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            Navigator.pop(context);

                            context.read<BottomNavigationBloc>().add(
                              const BottomNavigationTabChanged(4),
                            );
                          },
                        ),

                        // ------------------------------------------------
                        // SETTINGS
                        // ------------------------------------------------
                        ListTile(
                          leading: const Icon(
                            Icons.settings_rounded,
                            color: Color(0xFFEB4A0A),
                          ),
                          title: const Text(
                            "Settings",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            Navigator.pop(context);

                            // Navigate to Settings screen here
                          },
                        ),

                        // ------------------------------------------------
                        // ABOUT
                        // ------------------------------------------------
                        ListTile(
                          leading: const Icon(
                            Icons.info_outline_rounded,
                            color: Color(0xFFEB4A0A),
                          ),
                          title: const Text(
                            "About Us",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            Navigator.pop(context);

                            // Navigate to About screen here
                          },
                        ),

                        // ------------------------------------------------
                        // HELP
                        // ------------------------------------------------
                        ListTile(
                          leading: const Icon(
                            Icons.help_outline_rounded,
                            color: Color(0xFFEB4A0A),
                          ),
                          title: const Text(
                            "Help & Support",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            Navigator.pop(context);

                            // Navigate to Help screen here
                          },
                        ),
                        const Divider(),

                        ListTile(
                          leading: const Icon(
                            Icons.logout_rounded,
                            color: Colors.red,
                          ),
                          title: const Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);

                            // Logout functionality
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ------------------------------------------------
              // BODY
              // ------------------------------------------------
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

              // ------------------------------------------------
              // BOTTOM NAVIGATION
              // ------------------------------------------------
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

                  _NavItem(icon: Icons.book_online_sharp, label: "Booking"),

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

                height: isLandscape ? 54 : 65,

                circleWidth: isLandscape ? 50 : 60,

                cornerRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),

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

// ================================================================
// HOME TAB
// ================================================================

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(children: []),
    );
  }
}

// ================================================================
// BOTTOM NAVIGATION ITEM
// ================================================================

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
        Icon(icon, size: 25, color: isActive ? Colors.black : Colors.black54),

        const SizedBox(height: 2),

        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
