import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Constant/app_translations.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_state.dart';
import 'package:purohitset_app/Guruji_Side/Model/Auth/guruji_profile_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const Color primaryGold = Color(0xFFCD9933);
  static const Color darkBrown = Color(0xFF4A2418);
  static const Color creamColor = Color(0xFFFFFAF0);

  void _showEditProfileModal(BuildContext context, Guruji guruji) {
    final firstNameController =
        TextEditingController(text: guruji.firstName ?? '');
    final lastNameController =
        TextEditingController(text: guruji.lastName ?? '');
    final phoneController = TextEditingController(text: guruji.phone ?? '');
    final whatsappController =
        TextEditingController(text: guruji.whatsappNumber ?? '');
    final emailController = TextEditingController(text: guruji.email ?? '');
    final genderController = TextEditingController(text: guruji.gender ?? '');
    final dobController =
        TextEditingController(text: guruji.dateOfBirth ?? '');
    final religionController =
        TextEditingController(text: guruji.religion ?? '');
    final sampradayController =
        TextEditingController(text: guruji.sampraday ?? '');
    final vedaShakhaController =
        TextEditingController(text: guruji.vedaShakha ?? '');
    final qualificationController =
        TextEditingController(text: guruji.qualification ?? '');
    final experienceController = TextEditingController(
      text: guruji.experienceYears?.toString() ?? '',
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (modalContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(modalContext).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: SizedBox(
            height: MediaQuery.of(modalContext).size.height * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppTranslations.tr('edit_profile'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(modalContext),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView(
                    children: [
                      _buildTextField(
                        controller: firstNameController,
                        label: AppTranslations.tr('first_name'),
                        icon: Icons.person_outline,
                      ),
                      _buildTextField(
                        controller: lastNameController,
                        label: AppTranslations.tr('last_name'),
                        icon: Icons.person_outline,
                      ),
                      _buildTextField(
                        controller: phoneController,
                        label: AppTranslations.tr('phone_number'),
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      _buildTextField(
                        controller: whatsappController,
                        label: AppTranslations.tr('whatsapp_number'),
                        icon: Icons.phone_android_outlined,
                        keyboardType: TextInputType.phone,
                      ),
                      _buildTextField(
                        controller: emailController,
                        label: AppTranslations.tr('email'),
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      _buildTextField(
                        controller: genderController,
                        label: AppTranslations.tr('gender'),
                        icon: Icons.wc_outlined,
                      ),
                      _buildTextField(
                        controller: dobController,
                        label: AppTranslations.tr('dob'),
                        icon: Icons.calendar_month_outlined,
                      ),
                      _buildTextField(
                        controller: religionController,
                        label: AppTranslations.tr('religion'),
                        icon: Icons.temple_hindu_outlined,
                      ),
                      _buildTextField(
                        controller: sampradayController,
                        label: AppTranslations.tr('sampraday'),
                        icon: Icons.auto_awesome_outlined,
                      ),
                      _buildTextField(
                        controller: vedaShakhaController,
                        label: AppTranslations.tr('veda_shakha'),
                        icon: Icons.menu_book_outlined,
                      ),
                      _buildTextField(
                        controller: qualificationController,
                        label: AppTranslations.tr('qualification'),
                        icon: Icons.school_outlined,
                      ),
                      _buildTextField(
                        controller: experienceController,
                        label: AppTranslations.tr('experience'),
                        icon: Icons.work_history_outlined,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 48),
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => Navigator.pop(modalContext),
                          child: Text(
                            AppTranslations.tr('cancel'),
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEB4A0A),
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            guruji.firstName = firstNameController.text.trim();
                            guruji.lastName = lastNameController.text.trim();
                            guruji.fullName =
                                "${firstNameController.text.trim()} ${lastNameController.text.trim()}";
                            guruji.phone = phoneController.text.trim();
                            guruji.whatsappNumber =
                                whatsappController.text.trim();
                            guruji.email = emailController.text.trim();
                            guruji.gender = genderController.text.trim();
                            guruji.dateOfBirth = dobController.text.trim();
                            guruji.religion = religionController.text.trim();
                            guruji.sampraday = sampradayController.text.trim();
                            guruji.vedaShakha = vedaShakhaController.text.trim();
                            guruji.qualification =
                                qualificationController.text.trim();
                            guruji.experienceYears =
                                int.tryParse(experienceController.text.trim()) ??
                                    guruji.experienceYears;

                            Navigator.pop(modalContext);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppTranslations.tr('profile_updated'),
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );

                            context.read<GurujiProfileBloc>().add(
                              const GetGurujiDetailEvent(),
                            );
                          },
                          child: Text(
                            AppTranslations.tr('save'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: primaryGold),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: primaryGold, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () =>
                                        _showEditProfileModal(context, guruji),
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
                                  value: guruji.dateOfBirth,
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
                                  value: guruji.qualification,
                                ),
                                profileField(
                                  icon: Icons.work_history_outlined,
                                  title: AppTranslations.tr('experience'),
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
    final String displayValue =
        value == null || value.isEmpty ? AppTranslations.tr('not_available') : value;

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
      loadingBuilder: (
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
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
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
