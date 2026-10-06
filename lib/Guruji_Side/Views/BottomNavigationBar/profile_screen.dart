import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color primaryGold = Color(0xFFCD9933);
  static const Color darkBrown = Color(0xFF4A2418);
  static const Color creamColor = Color(0xFFFFFAF0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamColor,
      body: BlocBuilder<GurujiProfileBloc, GurujiProfileState>(
        builder: (context, state) {
          // =====================================================
          // INITIAL STATE
          // =====================================================
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

          // =====================================================
          // LOADING STATE
          // =====================================================
          if (state is GurujiProfileLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: primaryGold),
            );
          }

          // =====================================================
          // SUCCESS STATE
          // =====================================================
          if (state is GurujiProfileSuccessState) {
            final guruji = state.profile.data?.guruji;

            if (guruji == null) {
              return const Center(child: Text("Profile data not found"));
            }

            final int percentage =
                state.profile.data?.profileCompletion?.percentage ?? 0;

            final double progress = percentage.clamp(0, 100) / 100;

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
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 30,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    shape: BoxShape.circle,
                                  ),

                                  child: IconButton(
                                    padding: EdgeInsets.zero,

                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: darkBrown,
                                    ),

                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Text(
                                  "Profile Screen",
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 253, 173, 0),
                                    shape: BoxShape.circle,
                                  ),

                                  child: IconButton(
                                    padding: EdgeInsets.zero,

                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),

                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
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
                                    SizedBox(
                                      width: 105,
                                      height: 105,
                                      child: CircularProgressIndicator(
                                        value: 1,
                                        strokeWidth: 2,
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
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
                                            color: Colors.black.withOpacity(
                                              0.15,
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
                                  title: "Phone Number",
                                  value: guruji.phone,
                                ),

                                profileField(
                                  icon: Icons.phone_android_outlined,
                                  title: "WhatsApp Number",
                                  value: guruji.whatsappNumber,
                                ),

                                profileField(
                                  icon: Icons.email_outlined,
                                  title: "Email",
                                  value: guruji.email,
                                ),

                                profileField(
                                  icon: Icons.wc_outlined,
                                  title: "Gender",
                                  value: guruji.gender,
                                ),

                                profileField(
                                  icon: Icons.calendar_month_outlined,
                                  title: "Date of Birth",
                                  value: guruji.dateOfBirth,
                                ),

                                profileField(
                                  icon: Icons.temple_hindu_outlined,
                                  title: "Religion",
                                  value: guruji.religion,
                                ),

                                profileField(
                                  icon: Icons.auto_awesome_outlined,
                                  title: "Sampraday",
                                  value: guruji.sampraday,
                                ),

                                profileField(
                                  icon: Icons.menu_book_outlined,
                                  title: "Veda Shakha",
                                  value: guruji.vedaShakha,
                                ),

                                profileField(
                                  icon: Icons.school_outlined,
                                  title: "Qualification",
                                  value: guruji.qualification,
                                ),

                                profileField(
                                  icon: Icons.work_history_outlined,
                                  title: "Experience",
                                  value: guruji.experienceYears?.toString(),
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

          // =====================================================
          // ERROR / OTHER STATE
          // =====================================================
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

  // ===============================================================
  // FIRST NAME + LAST NAME
  // ===============================================================
  String _getFirstAndLastName(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) {
      return "Name not available";
    }

    final names = fullName.trim().split(RegExp(r'\s+'));

    if (names.length == 1) {
      return names[0];
    }

    return "${names.first} ${names.last}";
  }

  // ===============================================================
  // PROFILE FIELD
  // ===============================================================
  Widget profileField({
    required IconData icon,
    required String title,
    String? value,
  }) {
    final String displayValue = value == null || value.isEmpty
        ? "Not Available"
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
            // =========================================================
            // ICON
            // =========================================================
            Container(
              width: 48,
              height: 48,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: primaryGold.withOpacity(0.10),
              ),

              child: Icon(icon, color: primaryGold, size: 23),
            ),

            const SizedBox(width: 14),

            // =========================================================
            // TITLE + VALUE
            // =========================================================
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

  // ===============================================================
  // PROFILE IMAGE
  // ===============================================================
  Widget _buildProfileImage(String? imageUrl) {
    // ===============================================================
    // NO IMAGE
    // ===============================================================
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        width: 90,
        height: 90,

        color: Colors.grey.shade200,

        alignment: Alignment.center,

        child: Icon(Icons.person, size: 45, color: Colors.grey.shade500),
      );
    }

    // ===============================================================
    // IMAGE URL
    // ===============================================================
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
            // =============================================================
            // IMAGE LOADED
            // =============================================================
            if (loadingProgress == null) {
              return SizedBox(
                width: 90,
                height: 90,

                child: Center(child: child),
              );
            }

            // =============================================================
            // IMAGE LOADING
            // =============================================================
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

      // ===============================================================
      // IMAGE ERROR
      // ===============================================================
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
