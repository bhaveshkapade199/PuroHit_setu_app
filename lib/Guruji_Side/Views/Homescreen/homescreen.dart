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
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/My_Booking/booking_history_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/chatting_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/profile_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/wallet_screen.dart';
import 'package:purohitset_app/Guruji_Side/Views/Profile/update_profile_screen.dart';
import 'package:purohitset_app/Widget/common_background.dart';
import 'package:purohitset_app/Widget/rps_custom_painter.dart';

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

            // final appBarHeight = isLandscape ? 56.0 : 40.0;

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
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'Assets/Images/app_bar_image.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Close button
                            Positioned(
                              bottom: 90,
                              right: -8,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            // Guruji profile information
                            Padding(
                              padding: const EdgeInsets.only(top: 8, right: 28),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Profile image
                                  Container(
                                    width: 76,
                                    height: 76,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color(0xFFFFD873),
                                        width: 3,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(3),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'Assets/Images/purohit-setu-logo.webp',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 14),

                                  // Name, greeting and rating
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Namaste greeting
                                        const Row(
                                          children: [
                                            Text(
                                              '🙏',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                'Namaste, Guruji!',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Color(0xFFFFD873),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 6),

                                        // Guruji name: replace with API profile name
                                        const Text(
                                          'Pt. Guruji Name',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 7),

                                        // Rating
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withValues(
                                              alpha: 0.18,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Color(0xFFFFD873),
                                                size: 16,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                '4.8 Rating',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                          final profileState = context
                              .read<GurujiProfileBloc>()
                              .state;
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
                          icon: Icons.wallet,
                          label: AppTranslations.tr('Wallet'),
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

                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF740D07), // Deep red
                          Color(0xFF500905), // Dark maroon
                          Color(0xFF2B0806), // Red-black
                          Color(0xFF140605), // Almost black
                        ],
                        stops: [0.0, 0.4, 0.75, 1.0],
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
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  static const Color primaryGold = Color(0xFFCD9933);
  static const Color darkBrown = Color(0xFF4A2418);
  static const Color creamColor = Color(0xFFFFFAF0);
  static const Color maroon = Color(0xFF66110B);
  static const Color gold = Color(0xFFCD9933);
  static const Color cream = Color(0xFFFFFAF0);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          // Header background
          SizedBox(
            height: 140,
            width: double.infinity,
            child: CustomPaint(
              painter: RPSCustomPainter(
                fillColor: const Color(0xffcd9933).withValues(alpha: 0.5),
                strokeColor: const Color(0xffffd873),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipPath(
                      clipper: RPSCustomClipper(),
                      child: Image.asset(
                        'Assets/Images/app_bar_image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 24,
                      left: 8,
                      right: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'Assets/Images/purohit-setu-logo.webp',
                              height: 65,
                              width: 65,
                              fit: BoxFit.contain,
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Purohit Setu',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'सेवा • समर्पण • संस्कार 🙏',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Builder(
                              builder: (context) {
                                return IconButton(
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  icon: const Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                  tooltip: 'Open Menu',
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(
                                    minWidth: 40,
                                    minHeight: 40,
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 8),
                            const Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 26,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Fixed profile + independently scrollable content
          Positioned.fill(
            top: 95,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),

                  // FIXED PROFILE SECTION
                  Row(
                    children: [
                      _buildProfileImage('Assets/Images/puja-path.png'),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Namaste Guruji 🙏'),
                            SizedBox(height: 3),
                            Text(
                              'Pt Bhavesh Sharad Kapade',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Serve with devotion and spread Positivity',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.online_prediction,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Divider(height: 12),
                  ),

                  // ONLY THIS SECTION SCROLLS
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeader(
                            title: "Today's Overview",
                            onPressed: () {
                              context.read<BottomNavigationBloc>().add(
                                const BottomNavigationTabChanged(1),
                              );
                            },
                          ),
                          // HORIZONTAL OVERVIEW CARDS
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                final titles = [
                                  'Revenue',
                                  'Bookings',
                                  'Completed',
                                  'Pending',
                                ];

                                final values = ['₹1,200', '12', '8', '4'];

                                final icons = [
                                  Icons.currency_rupee,
                                  Icons.book_online,
                                  Icons.check_circle,
                                  Icons.pending_actions,
                                ];

                                return SizedBox(
                                  width: 130,
                                  child: Card(
                                    elevation: 3,
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          icons[index],
                                          color: maroon,
                                          size: 28,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(titles[index]),
                                        const SizedBox(height: 8),
                                        Text(
                                          values[index],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 5),
                          SectionHeader(
                            title: 'New Booking Request',
                            onPressed: () {
                              context.read<BottomNavigationBloc>().add(
                                const BottomNavigationTabChanged(1),
                              );
                            },
                          ),

                          // BOOKING CARD
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: cream,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFEED9BB),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // LEFT SIDE: Booking Information
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 22,
                                            backgroundColor: Color(0xFFFFE4A8),
                                            child: Icon(
                                              Icons.person,
                                              color: maroon,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Amit Joshi',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: maroon,
                                                  ),
                                                ),
                                                Text(
                                                  'New Booking',
                                                  style: TextStyle(
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 14),

                                      const Text(
                                        'Satyanarayan Puja',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_month,
                                            color: maroon,
                                            size: 18,
                                          ),
                                          SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              '15 Oct 2025 • 10:00 AM',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),

                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: maroon,
                                            size: 18,
                                          ),
                                          SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              'Pune, Maharashtra',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),

                                      const Text(
                                        'Expected Dakshina: ₹2,001',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: maroon,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 12),

                                // RIGHT SIDE: Accept and Reject Buttons
                                SizedBox(
                                  width: 85,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Booking accepted',
                                                ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: maroon,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                          ),
                                          child: const Text('Accept'),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width: double.infinity,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Booking rejected',
                                                ),
                                              ),
                                            );
                                          },
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: maroon,
                                            side: const BorderSide(
                                              color: maroon,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                          ),
                                          child: const Text('Reject'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12),
                          SectionHeader(
                            title: 'Quick Action',
                            // onPressed: () {
                            //   context.read<BottomNavigationBloc>().add(
                            //     const BottomNavigationTabChanged(1),
                            //   );
                            // },
                            showButton: false,
                          ),
                          SizedBox(height: 12),
                          buildQuickActions(),
                          SizedBox(height: 12),
                          SectionHeader(
                            title: 'Recent Message',
                            onPressed: () {
                              context.read<BottomNavigationBloc>().add(
                                const BottomNavigationTabChanged(1),
                              );
                            },
                          ),
                          buildRecentMessages(),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Quick Action

  Widget buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            title: 'My Booking',
            icon: Icons.calendar_month_rounded,
            color: const Color(0xFFFFE8C2),
            iconColor: const Color(0xFF9B5B16),
            onTap: () {},
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildActionCard(
            title: 'Chat',
            icon: Icons.chat_bubble_rounded,
            color: const Color(0xFFDDECE0),
            iconColor: const Color(0xFF287447),
            onTap: () {},
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildActionCard(
            title: 'My Service',
            icon: Icons.temple_hindu_rounded,
            color: const Color(0xFFF3DEDF),
            iconColor: const Color(0xFF9B3438),
            onTap: () {},
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildActionCard(
            title: 'Availability',
            icon: Icons.event_available_rounded,
            color: const Color(0xFFE3E5FA),
            iconColor: const Color(0xFF4B50A2),
            onTap: () {},
          ),
        ),
      ],
    );
  }

  //Recent Message

  Widget buildRecentMessages() {
    return Column(
      children: [
        _buildMessageCard(
          name: 'Rahul Patil',
          message: 'Namaskar Guruji, I want to book a puja.',
          time: '10:30 AM',
          unreadCount: 2,
          avatarColor: const Color(0xFFE9D6BC),
          avatarIconColor: const Color(0xFF80543C),
          onTap: () {
            // Open Rahul's chat screen
          },
        ),
        const SizedBox(height: 12),
        _buildMessageCard(
          name: 'Sneha Sharma',
          message: 'What is the fee for Satyanarayan puja?',
          time: 'Yesterday',
          unreadCount: 0,
          avatarColor: const Color(0xFFDDE6F2),
          avatarIconColor: const Color(0xFF435E88),
          onTap: () {
            // Open Sneha's chat screen
          },
        ),
      ],
    );
  }

  Widget _buildMessageCard({
    required String name,
    required String message,
    required String time,
    required int unreadCount,
    required Color avatarColor,
    required Color avatarIconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFAF0),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEED9BB)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: avatarColor,
              child: Icon(
                Icons.person_rounded,
                size: 30,
                color: avatarIconColor,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF4A2418),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF806B5C),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9A8575),
                    ),
                  ),
                ],
              ),
            ),

            if (unreadCount > 0) ...[
              const SizedBox(width: 8),
              CircleAvatar(
                radius: 11,
                backgroundColor: const Color(0xFF287447),
                child: Text(
                  '$unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: iconColor.withValues(alpha: 0.18)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: iconColor),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(String? imageUrl) {
    const double imageSize = 90;
    const double borderWidth = 2.5;

    Widget placeholder() {
      return Container(
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: Icon(Icons.person, size: 45, color: Colors.grey.shade500),
      );
    }

    final Widget profileImage;

    if (imageUrl == null || imageUrl.isEmpty) {
      profileImage = placeholder();
    } else {
      final String fullUrl = imageUrl.startsWith('http')
          ? imageUrl
          : 'Assets/Images/puja-path.png';

      profileImage = Image.network(
        fullUrl,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return Container(
            color: Colors.grey.shade100,
            alignment: Alignment.center,
            child: const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: primaryGold,
                strokeWidth: 2,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => placeholder(),
      );
    }

    return Container(
      height: 77,
      width: 77,

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: primaryGold, width: borderWidth),
      ),
      child: ClipOval(
        child: SizedBox(
          width: imageSize,
          height: imageSize,
          child: profileImage,
        ),
      ),
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
        Icon(
          icon,
          size: 22,
          color: isActive ? Colors.black : Colors.white,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
