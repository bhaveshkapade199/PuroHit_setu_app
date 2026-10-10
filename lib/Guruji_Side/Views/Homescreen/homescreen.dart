import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Constant/app_translations.dart';
import 'package:purohitset_app/Constant/get_storage.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigation_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigationbar_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigationbar_state.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_state.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/Language/language_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Views/Auth/change_password_screen.dart';

import 'package:purohitset_app/Guruji_Side/Views/Auth/login_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/booking_history_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/chatting_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/profile_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/reels_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/Profile/update_profile_screen.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  // Scaffold key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final currentLang = AppTranslations.currentLanguage;
        return AlertDialog(
          title: Text(
            AppTranslations.tr('select_language'),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(AppTranslations.tr('english')),
                trailing: currentLang == 'en'
                    ? const Icon(Icons.check_circle, color: Color(0xFFEB4A0A))
                    : null,
                onTap: () {
                  context.read<LanguageBloc>().add(ChangeLanguageEvent('en'));
                  Navigator.pop(dialogContext);
                },
              ),
              ListTile(
                title: Text(AppTranslations.tr('hindi')),
                trailing: currentLang == 'hi'
                    ? const Icon(Icons.check_circle, color: Color(0xFFEB4A0A))
                    : null,
                onTap: () {
                  context.read<LanguageBloc>().add(ChangeLanguageEvent('hi'));
                  Navigator.pop(dialogContext);
                },
              ),
              ListTile(
                title: Text(AppTranslations.tr('marathi')),
                trailing: currentLang == 'mr'
                    ? const Icon(Icons.check_circle, color: Color(0xFFEB4A0A))
                    : null,
                onTap: () {
                  context.read<LanguageBloc>().add(ChangeLanguageEvent('mr'));
                  Navigator.pop(dialogContext);
                },
              ),
              ListTile(
                title: Text(AppTranslations.tr('gujarati')),
                trailing: currentLang == 'gu'
                    ? const Icon(Icons.check_circle, color: Color(0xFFEB4A0A))
                    : null,
                onTap: () {
                  context.read<LanguageBloc>().add(ChangeLanguageEvent('gu'));
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, langState) {
        return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
          builder: (context, state) {
            final size = MediaQuery.sizeOf(context);

            final isLandscape =
                MediaQuery.orientationOf(context) == Orientation.landscape;

            final appBarHeight = isLandscape ? 56.0 : 40.0;

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
              child: Scaffold(
                key: scaffoldKey,

                backgroundColor: const Color(0xFFFFF5EA),

                // ------------------------------------------------
                // APP BAR
                // ------------------------------------------------
                appBar: state.currentIndex == 0
                    ? PreferredSize(
                        preferredSize: Size(
                          double.infinity,
                          appBarHeight + MediaQuery.of(context).padding.top,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFFFD3A1,
                            ).withValues(alpha: 0.8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: SafeArea(
                            bottom: false,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // LOGO
                                  Image.asset(
                                    'Assets/Images/purohit-setu-logo.webp',
                                    height: isLandscape ? 44 : 70,
                                    width: isLandscape ? 44 : 70,
                                    fit: BoxFit.contain,
                                  ),

                                  const SizedBox(width: 8),

                                  // LOCATION
                                  Expanded(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: Color(0xFFEB4A0A),
                                          size: 22,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            AppTranslations.tr('location'),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // NOTIFICATION
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

                                  // MENU
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
                        ),
                      )
                    : null,

                // ------------------------------------------------
                // DRAWER
                // ------------------------------------------------
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

                                Text(
                                  AppTranslations.tr('app_name'),
                                  style: const TextStyle(
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
                              icon: const Icon(
                                Icons.close,
                                size: 28,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // HOME
                      ListTile(
                        leading: const Icon(
                          Icons.home_rounded,
                          color: Color(0xFFEB4A0A),
                        ),
                        title: Text(
                          AppTranslations.tr('home'),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          context.read<BottomNavigationBloc>().add(
                            const BottomNavigationTabChanged(0),
                          );
                        },
                      ),

                      // PROFILE
                      ListTile(
                        leading: const Icon(
                          Icons.person_rounded,
                          color: Color(0xFFEB4A0A),
                        ),
                        title: Text(
                          AppTranslations.tr('profile'),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          context.read<BottomNavigationBloc>().add(
                            const BottomNavigationTabChanged(4),
                          );
                        },
                      ),

                      // UPDATE PROFILE
                      ListTile(
                        leading: const Icon(
                          Icons.edit_note_rounded,
                          color: Color(0xFFEB4A0A),
                        ),
                        title: const Text(
                          'Update Profile',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          final profileState =
                              context.read<GurujiProfileBloc>().state;
                          if (profileState is GurujiProfileSuccessState) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UpdateProfileScreen(
                                  guruji: profileState.profile.data.guruji,
                                  onUpdated: () {
                                    context.read<GurujiProfileBloc>().add(
                                      const GetGurujiDetailEvent(),
                                    );
                                  },
                                ),
                              ),
                            );
                          } else {
                            context.read<BottomNavigationBloc>().add(
                              const BottomNavigationTabChanged(4),
                            );
                          }
                        },
                      ),

                      // SETTINGS
                      ListTile(
                        leading: const Icon(
                          Icons.settings_rounded,
                          color: Color(0xFFEB4A0A),
                        ),
                        title: Text(
                          AppTranslations.tr('settings'),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),

                      // ABOUT US
                      ListTile(
                        leading: const Icon(
                          Icons.info_outline_rounded,
                          color: Color(0xFFEB4A0A),
                        ),
                        title: Text(
                          AppTranslations.tr('about_us'),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),

                      // HELP & SUPPORT
                      ListTile(
                        leading: const Icon(
                          Icons.help_outline_rounded,
                          color: Color(0xFFEB4A0A),
                        ),
                        title: Text(
                          AppTranslations.tr('help_support'),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),

                      const Divider(),

                      // Change the Password
                      ListTile(
                        leading: const Icon(
                          Icons.password,
                          color: Colors.black87,
                        ),
                        title: Text(
                          AppTranslations.tr('Change Password'),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen(),
                            ),
                          );
                        },
                      ),

                      // LOGOUT
                      ListTile(
                        leading: const Icon(
                          Icons.logout_rounded,
                          color: Colors.red,
                        ),
                        title: Text(
                          AppTranslations.tr('logout'),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          final storage = StorageService();
                          storage.removeToken();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
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
                // FLOATING ACTION BUTTON (CHANGE LANGUAGE)
                // ------------------------------------------------
                // floatingActionButton: FloatingActionButton(
                //   onPressed: () => _showLanguageDialog(context),

                // ),
                floatingActionButton: FloatingActionButton.small(
                  onPressed: () => _showLanguageDialog(context),
                  backgroundColor: const Color.fromARGB(255, 235, 156, 10),
                  tooltip: AppTranslations.tr('change_language'),
                  child: SizedBox(
                    height: 30,
                    child: Center(child: Icon(Icons.language)),
                  ),
                ),

                // ------------------------------------------------
                // BOTTOM NAVIGATION
                // ------------------------------------------------
                bottomNavigationBar: SafeArea(
                  top: false,
                  bottom: true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: CircleNavBar(
                      activeIndex: state.currentIndex,
                      activeIcons: [
                        _NavItem(
                          icon: Icons.home_rounded,
                          label: AppTranslations.tr('home'),
                          isActive: true,
                        ),
                        _NavItem(
                          icon: Icons.book_online_sharp,
                          label: AppTranslations.tr('booking'),
                          isActive: true,
                        ),
                        _NavItem(
                          icon: Icons.mobile_screen_share_outlined,
                          label: AppTranslations.tr('reels'),
                          isActive: true,
                        ),
                        _NavItem(
                          icon: Icons.chat_bubble_rounded,
                          label: AppTranslations.tr('chat'),
                          isActive: true,
                        ),
                        _NavItem(
                          icon: Icons.person_rounded,
                          label: AppTranslations.tr('profile'),
                          isActive: true,
                        ),
                      ],
                      inactiveIcons: [
                        _NavItem(
                          icon: Icons.home_rounded,
                          label: AppTranslations.tr('home'),
                        ),
                        _NavItem(
                          icon: Icons.book_online_sharp,
                          label: AppTranslations.tr('booking'),
                        ),
                        _NavItem(
                          icon: Icons.mobile_screen_share_outlined,
                          label: AppTranslations.tr('reels'),
                        ),
                        _NavItem(
                          icon: Icons.chat_bubble_outline_outlined,
                          label: AppTranslations.tr('chat'),
                        ),
                        _NavItem(
                          icon: Icons.person_rounded,
                          label: AppTranslations.tr('profile'),
                        ),
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
              ),
            );
          },
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
