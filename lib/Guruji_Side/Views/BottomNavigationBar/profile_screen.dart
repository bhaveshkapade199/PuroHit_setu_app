import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Constant/app_translations.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_state.dart';
import 'package:purohitset_app/Guruji_Side/Model/Auth/guruji_profile_model.dart';
import 'package:purohitset_app/Guruji_Side/Views/Profile/update_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color primaryGold = Color(0xFFCD9933);
  static const Color darkBrown = Color(0xFF4A2418);
  static const Color creamColor = Color(0xFFFFFAF0);

  void _showProfileIncompleteDialog(
    BuildContext context,
    int percentage,
    Guruji guruji,
  ) {
    if (percentage >= 100) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!context.mounted) return;

      showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: creamColor,
            icon: const Icon(
              Icons.account_circle_outlined,
              size: 55,
              color: primaryGold,
            ),
            title: const Text(
              'Complete Your Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkBrown,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Your profile is $percentage% complete.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please complete your profile to provide all your details.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: percentage.clamp(0, 100) / 100,
                  minHeight: 7,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: Colors.black12,
                  valueColor: const AlwaysStoppedAnimation<Color>(primaryGold),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGold,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(150, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UpdateProfileScreen(
                        guruji: guruji,
                        onUpdated: () {
                          context.read<GurujiProfileBloc>().add(
                            const GetGurujiDetailEvent(),
                          );
                        },
                      ),
                    ),
                  );
                },
                child: const Text('Complete Profile'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Later', style: TextStyle(color: darkBrown)),
              ),
            ],
          );
        },
      );
    });
  }

  void _navigateToUpdateProfile(BuildContext context, Guruji guruji) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UpdateProfileScreen(
          guruji: guruji,
          onUpdated: () {
            context.read<GurujiProfileBloc>().add(
              const GetGurujiDetailEvent(),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamColor,
      body: BlocBuilder<GurujiProfileBloc, GurujiProfileState>(
        builder: (context, state) {
          if (state is GurujiProfileInitialState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<GurujiProfileBloc>().add(
                const GetGurujiDetailEvent(),
              );
            });

            return const Center(
              child: CircularProgressIndicator(color: primaryGold),
            );
          }

          if (state is GurujiProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: primaryGold),
            );
          }

          if (state is GurujiProfileErrorState) {
            debugPrint("PROFILE BLOC ERROR: ${state.message}");

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 45,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Failed to load profile",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGold,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        context.read<GurujiProfileBloc>().add(
                          const GetGurujiDetailEvent(),
                        );
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is GurujiProfileSuccessState) {
            final guruji = state.profile.data.guruji;

            final int percentage =
                state.profile.data.profileCompletion.percentage;

            final double progress = percentage.clamp(0, 100) / 100;

            String formatDob(DateTime? dob) {
              if (dob == null) return '';

              final day = dob.day.toString().padLeft(2, '0');
              final month = dob.month.toString().padLeft(2, '0');

              return '$day/$month/${dob.year}';
            }

            return RefreshIndicator(
              color: primaryGold,
              onRefresh: () async {
                context.read<GurujiProfileBloc>().add(
                  const GetGurujiDetailEvent(),
                );
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 230,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 180,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "Assets/Images/temple_image.webp",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            color: Colors.black54,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 30,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 32),
                                Text(
                                  AppTranslations.tr('profile_screen'),
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 253, 173, 0),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    tooltip: "Edit Profile",
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () =>
                                        _navigateToUpdateProfile(context, guruji),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: -10,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 140,
                                height: 140,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 105,
                                      height: 105,
                                      child: CircularProgressIndicator(
                                        value: 1,
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 105,
                                      height: 105,
                                      child: CircularProgressIndicator(
                                        value: progress,
                                        strokeWidth: 5,
                                        strokeCap: StrokeCap.round,
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                              Colors.amber,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                          color: primaryGold,
                                          width: 3,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(
                                              alpha: 0.15,
                                            ),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: ClipOval(
                                        child: _buildProfileImage(
                                          guruji.profilePhotoUrl,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: -1,
                                      child: GestureDetector(
                                        onTap: () =>
                                            _showProfileIncompleteDialog(
                                          context,
                                          percentage,
                                          guruji,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            "$percentage%",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: RichText(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: "Pt. ",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: _getFirstAndLastName(
                                          guruji.fullName,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                            255,
                                            228,
                                            194,
                                            3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Profile Completion Bar & Edit Profile Action Button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _navigateToUpdateProfile(context, guruji),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: primaryGold.withValues(alpha: 0.4),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.edit_note_rounded,
                                    color: primaryGold,
                                    size: 22,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Edit Profile Details",
                                    style: TextStyle(
                                      color: darkBrown,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                profileField(
                                  icon: Icons.phone_outlined,
                                  title: AppTranslations.tr('phone_number'),
                                  value: guruji.phone,
                                ),
                                profileField(
                                  icon: Icons.phone_android_outlined,
                                  title: AppTranslations.tr('whatsapp_number'),
                                  value: guruji.whatsappNumber,
                                ),
                                profileField(
                                  icon: Icons.email_outlined,
                                  title: AppTranslations.tr('email'),
                                  value: guruji.email,
                                ),
                                profileField(
                                  icon: Icons.wc_outlined,
                                  title: AppTranslations.tr('gender'),
                                  value: guruji.gender,
                                ),
                                profileField(
                                  icon: Icons.calendar_month_outlined,
                                  title: AppTranslations.tr('dob'),
                                  value: formatDob(guruji.dateOfBirth),
                                ),
                                profileField(
                                  icon: Icons.temple_hindu_outlined,
                                  title: AppTranslations.tr('religion'),
                                  value: guruji.religion,
                                ),
                                profileField(
                                  icon: Icons.auto_awesome_outlined,
                                  title: AppTranslations.tr('sampraday'),
                                  value: guruji.sampraday,
                                ),
                                profileField(
                                  icon: Icons.menu_book_outlined,
                                  title: AppTranslations.tr('veda_shakha'),
                                  value: guruji.vedaShakha,
                                ),
                                profileField(
                                  icon: Icons.school_outlined,
                                  title: AppTranslations.tr('qualification'),
                                  value: guruji.qualification?.toString(),
                                ),
                                profileField(
                                  icon: Icons.work_history_outlined,
                                  title: AppTranslations.tr('experience'),
                                  value: guruji.experienceYears.toString(),
                                ),

                                const SizedBox(height: 20),
                              ],
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

          return const Center(
            child: Text(
              "Something went wrong",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          );
        },
      ),
    );
  }

  String _getFirstAndLastName(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) {
      return AppTranslations.tr('not_available');
    }

    final names = fullName.trim().split(RegExp(r'\s+'));
    if (names.length == 1) {
      return names[0];
    }
    return "${names.first} ${names.last}";
  }

  Widget profileField({
    required IconData icon,
    required String title,
    String? value,
  }) {
    final String displayValue = value == null || value.isEmpty
        ? AppTranslations.tr('not_available')
        : value;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryGold.withValues(alpha: 0.10),
              ),
              child: Icon(icon, color: primaryGold, size: 23),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    displayValue,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF20252B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: 90,
        height: 90,
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: Icon(Icons.person, size: 45, color: Colors.grey.shade500),
      );
    }

    final String fullUrl = imageUrl.startsWith('http')
        ? imageUrl
        : 'https://purohitsetu.com$imageUrl';

    return Image.network(
      fullUrl,
      width: 90,
      height: 90,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      loadingBuilder:
          (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) {
              return SizedBox(
                width: 90,
                height: 90,
                child: Center(child: child),
              );
            }

            return Container(
              width: 90,
              height: 90,
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
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
            return Container(
              width: 90,
              height: 90,
              color: Colors.grey.shade200,
              alignment: Alignment.center,
              child: Icon(Icons.person, size: 45, color: Colors.grey.shade500),
            );
          },
    );
  }
}
