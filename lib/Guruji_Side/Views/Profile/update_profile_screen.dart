import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Show_Guruji_Profile/guruji_profile_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Update_Guruji_profile/update_guruji_profile_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Update_Guruji_profile/update_guruji_profile_event.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/GurujiProfile/Update_Guruji_profile/update_guruji_profile_state.dart';
import 'package:purohitset_app/Guruji_Side/Model/Auth/guruji_profile_model.dart';

class UpdateProfileScreen extends StatefulWidget {
  final Guruji guruji;
  final VoidCallback? onUpdated;

  const UpdateProfileScreen({
    super.key,
    required this.guruji,
    this.onUpdated,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  static const Color primaryGold = Color(0xFFCD9933);
  static const Color darkBrown = Color(0xFF4A2418);
  static const Color accentMaroon = Color(0xFF66110B);
  static const Color creamColor = Color(0xFFFFFBF5);

  final _formKey = GlobalKey<FormState>();

  // Personal Info
  late final TextEditingController firstName;
  late final TextEditingController middleName;
  late final TextEditingController lastName;
  late String selectedGender;
  late final TextEditingController dob;
  late final TextEditingController bio;

  // Contact Info
  late final TextEditingController phone;
  late final TextEditingController alternatePhone;
  late final TextEditingController whatsapp;
  late final TextEditingController email;

  // Spiritual / Vedic
  late final TextEditingController religion;
  late final TextEditingController sampraday;
  late final TextEditingController vedaShakha;
  late final TextEditingController qualification;
  late final TextEditingController experience;
  late String selectedLanguage;

  // Current Address
  final currentAddress1 = TextEditingController();
  final currentAddress2 = TextEditingController();
  final currentVillage = TextEditingController();
  final currentTaluka = TextEditingController();
  final currentDistrict = TextEditingController();
  final currentState = TextEditingController();
  final currentCountry = TextEditingController(text: 'India');
  final currentPincode = TextEditingController();

  // Permanent Address
  final permanentAddress1 = TextEditingController();
  final permanentAddress2 = TextEditingController();
  final permanentVillage = TextEditingController();
  final permanentTaluka = TextEditingController();
  final permanentDistrict = TextEditingController();
  final permanentState = TextEditingController();
  final permanentCountry = TextEditingController(text: 'India');
  final permanentPincode = TextEditingController();

  // Bank
  final accountHolder = TextEditingController();
  final bankName = TextEditingController();
  final accountNumber = TextEditingController();
  final ifsc = TextEditingController();
  final upiId = TextEditingController();

  bool permanentSameAsCurrent = false;

  @override
  void initState() {
    super.initState();
    final g = widget.guruji;

    firstName = TextEditingController(text: g.firstName);
    middleName = TextEditingController(text: g.middleName);
    lastName = TextEditingController(text: g.lastName);

    final gGender = g.gender.trim().toLowerCase();
    if (gGender == 'female' || gGender == 'other') {
      selectedGender = gGender;
    } else {
      selectedGender = 'male';
    }

    dob = TextEditingController(text: _formatDate(g.dateOfBirth));
    bio = TextEditingController(text: g.bio?.toString() ?? '');

    phone = TextEditingController(text: g.phone);
    alternatePhone = TextEditingController(
      text: g.alternatePhone?.toString() ?? '',
    );
    whatsapp = TextEditingController(text: g.whatsappNumber);
    email = TextEditingController(text: g.email);

    religion = TextEditingController(text: g.religion);
    sampraday = TextEditingController(text: g.sampraday);
    vedaShakha = TextEditingController(text: g.vedaShakha);
    qualification = TextEditingController(
      text: g.qualification?.toString() ?? '',
    );
    experience = TextEditingController(
      text: g.experienceYears > 0 ? g.experienceYears.toString() : '0',
    );

    final lang = g.languagePreference.trim().toLowerCase();
    const supportedLangs = ['mr', 'hi', 'en', 'gu', 'sa'];
    selectedLanguage = supportedLangs.contains(lang) ? lang : 'mr';
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    DateTime initial = DateTime(1990, 1, 1);
    if (dob.text.isNotEmpty) {
      final parsed = DateTime.tryParse(dob.text);
      if (parsed != null) initial = parsed;
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1930),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryGold,
              onPrimary: Colors.white,
              onSurface: darkBrown,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        dob.text = _formatDate(picked);
      });
    }
  }

  void _copyCurrentToPermanent() {
    permanentAddress1.text = currentAddress1.text;
    permanentAddress2.text = currentAddress2.text;
    permanentVillage.text = currentVillage.text;
    permanentTaluka.text = currentTaluka.text;
    permanentDistrict.text = currentDistrict.text;
    permanentState.text = currentState.text;
    permanentCountry.text = currentCountry.text;
    permanentPincode.text = currentPincode.text;
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? true)) return;

    final years = int.tryParse(experience.text.trim()) ?? 0;

    if (permanentSameAsCurrent) {
      _copyCurrentToPermanent();
    }

    final first = firstName.text.trim();
    final middle = middleName.text.trim();
    final last = lastName.text.trim();

    final profileMap = <String, dynamic>{
      'first_name': first,
      'middle_name': middle.isEmpty ? null : middle,
      'last_name': last,
      'full_name': [first, middle, last]
          .where((value) => value.isNotEmpty)
          .join(' '),
      'gender': selectedGender,
      'date_of_birth': dob.text.trim(),
      'dob': dob.text.trim(),
      'phone': phone.text.trim(),
      'mobile': phone.text.trim(),
      if (alternatePhone.text.trim().isNotEmpty)
        'alternate_phone': alternatePhone.text.trim(),
      'whatsapp_number': whatsapp.text.trim(),
      'whatsapp': whatsapp.text.trim(),
      'email': email.text.trim(),
      'profile_photo': widget.guruji.profilePhotoUrl,
      'bio': bio.text.trim(),
      'religion': religion.text.trim(),
      'sampraday': sampraday.text.trim(),
      'sampradaya': sampraday.text.trim(),
      'veda_shakha': vedaShakha.text.trim(),
      if (qualification.text.trim().isNotEmpty)
        'qualification': qualification.text.trim(),
      'experience_years': years,
      'language_preference': selectedLanguage,
    };

    final payload = <String, dynamic>{
      'profile': profileMap,
    };

    // Only attach addresses if address_line1 is supplied
    final hasCurrentAddress = currentAddress1.text.trim().isNotEmpty;
    final hasPermAddress = permanentAddress1.text.trim().isNotEmpty;

    if (hasCurrentAddress || hasPermAddress) {
      final addresses = <Map<String, dynamic>>[];
      if (hasCurrentAddress) {
        addresses.add({
          'address_type': 'current',
          'address_line1': currentAddress1.text.trim(),
          if (currentAddress2.text.trim().isNotEmpty)
            'address_line2': currentAddress2.text.trim(),
          if (currentVillage.text.trim().isNotEmpty)
            'village': currentVillage.text.trim(),
          if (currentTaluka.text.trim().isNotEmpty)
            'taluka': currentTaluka.text.trim(),
          if (currentDistrict.text.trim().isNotEmpty)
            'district': currentDistrict.text.trim(),
          if (currentState.text.trim().isNotEmpty)
            'state': currentState.text.trim(),
          'country': currentCountry.text.trim(),
          'pincode': currentPincode.text.trim(),
        });
      }
      if (hasPermAddress) {
        addresses.add({
          'address_type': 'permanent',
          'address_line1': permanentAddress1.text.trim(),
          if (permanentAddress2.text.trim().isNotEmpty)
            'address_line2': permanentAddress2.text.trim(),
          if (permanentVillage.text.trim().isNotEmpty)
            'village': permanentVillage.text.trim(),
          if (permanentTaluka.text.trim().isNotEmpty)
            'taluka': permanentTaluka.text.trim(),
          if (permanentDistrict.text.trim().isNotEmpty)
            'district': permanentDistrict.text.trim(),
          if (permanentState.text.trim().isNotEmpty)
            'state': permanentState.text.trim(),
          'country': permanentCountry.text.trim(),
          'pincode': permanentPincode.text.trim(),
        });
      }
      payload['addresses'] = addresses;
    }

    // Only attach bank account if account number is provided
    if (accountNumber.text.trim().isNotEmpty) {
      payload['bank_accounts'] = [
        {
          'account_holder_name': accountHolder.text.trim(),
          'bank_name': bankName.text.trim(),
          'account_number': accountNumber.text.trim(),
          'ifsc_code': ifsc.text.trim().toUpperCase(),
          if (upiId.text.trim().isNotEmpty) 'upi_id': upiId.text.trim(),
          'is_primary': true,
        },
      ];
    }

    context.read<GurujiProfileUpdateBloc>().add(
      UpdateGurujiProfileEvent(profileData: payload),
    );
  }

  @override
  void dispose() {
    firstName.dispose();
    middleName.dispose();
    lastName.dispose();
    dob.dispose();
    bio.dispose();
    phone.dispose();
    alternatePhone.dispose();
    whatsapp.dispose();
    email.dispose();
    religion.dispose();
    sampraday.dispose();
    vedaShakha.dispose();
    qualification.dispose();
    experience.dispose();
    currentAddress1.dispose();
    currentAddress2.dispose();
    currentVillage.dispose();
    currentTaluka.dispose();
    currentDistrict.dispose();
    currentState.dispose();
    currentCountry.dispose();
    currentPincode.dispose();
    permanentAddress1.dispose();
    permanentAddress2.dispose();
    permanentVillage.dispose();
    permanentTaluka.dispose();
    permanentDistrict.dispose();
    permanentState.dispose();
    permanentCountry.dispose();
    permanentPincode.dispose();
    accountHolder.dispose();
    bankName.dispose();
    accountNumber.dispose();
    ifsc.dispose();
    upiId.dispose();
    super.dispose();
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: primaryGold.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: primaryGold.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: primaryGold, size: 20),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkBrown,
                  ),
                ),
              ],
            ),
            const Divider(height: 22, color: Color(0xFFF1E6D2)),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    TextInputType keyboardType = TextInputType.text,
    bool enabled = true,
    String? hint,
    Widget? prefixIcon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
        style: TextStyle(
          color: enabled ? darkBrown : Colors.grey.shade700,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: prefixIcon,
          labelStyle: TextStyle(
            color: primaryGold.withValues(alpha: 0.95),
            fontSize: 14,
          ),
          filled: !enabled,
          fillColor: enabled ? Colors.white : Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: primaryGold.withValues(alpha: 0.35),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: primaryGold,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GurujiProfileUpdateBloc, GurujiProfileUpdateState>(
      listener: (context, state) {
        if (state is GurujiProfileUpdateSuccess) {
          final message = state.model.message;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                message.isNotEmpty
                    ? message
                    : 'Profile updated successfully!',
              ),
              backgroundColor: Colors.green,
            ),
          );

          // Refresh profile in main profile bloc
          context.read<GurujiProfileBloc>().add(const GetGurujiDetailEvent());
          widget.onUpdated?.call();
          Navigator.of(context).pop();
        } else if (state is GurujiProfileUpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red.shade700,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is GurujiProfileUpdateLoading;

        return Scaffold(
          backgroundColor: creamColor,
          appBar: AppBar(
            backgroundColor: const Color(0xFFFFD3A1),
            elevation: 2,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: darkBrown),
              onPressed: isLoading ? null : () => Navigator.of(context).pop(),
            ),
            title: const Text(
              "Edit Profile",
              style: TextStyle(
                color: darkBrown,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            actions: [
              TextButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: darkBrown,
                        ),
                      )
                    : const Text(
                        "SAVE",
                        style: TextStyle(
                          color: accentMaroon,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                children: [
                  // Profile Photo Header
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryGold,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: primaryGold.withValues(alpha: 0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: widget.guruji.profilePhotoUrl.isNotEmpty
                                ? Image.network(
                                    widget.guruji.profilePhotoUrl.startsWith('http')
                                        ? widget.guruji.profilePhotoUrl
                                        : 'https://purohitsetu.com${widget.guruji.profilePhotoUrl}',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(
                                      Icons.person,
                                      size: 55,
                                      color: Colors.grey,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 55,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: primaryGold,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 1. Personal Information
                  _buildSectionCard(
                    title: "Personal Information",
                    icon: Icons.person_outline,
                    children: [
                      _buildTextField(
                        firstName,
                        "First Name *",
                        validator: (val) => val == null || val.trim().isEmpty
                            ? "First name is required"
                            : null,
                      ),
                      _buildTextField(middleName, "Middle Name"),
                      _buildTextField(
                        lastName,
                        "Last Name *",
                        validator: (val) => val == null || val.trim().isEmpty
                            ? "Last name is required"
                            : null,
                      ),
                      // Gender Selector
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: DropdownButtonFormField<String>(
                          initialValue: selectedGender,
                          decoration: InputDecoration(
                            labelText: "Gender",
                            labelStyle: TextStyle(
                              color: primaryGold.withValues(alpha: 0.95),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: primaryGold.withValues(alpha: 0.35),
                              ),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'male',
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: 'female',
                              child: Text('Female'),
                            ),
                            DropdownMenuItem(
                              value: 'other',
                              child: Text('Other'),
                            ),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => selectedGender = val);
                            }
                          },
                        ),
                      ),
                      // Date of Birth
                      GestureDetector(
                        onTap: _selectDate,
                        child: AbsorbPointer(
                          child: _buildTextField(
                            dob,
                            "Date of Birth (YYYY-MM-DD)",
                            hint: "Select birth date",
                            prefixIcon: const Icon(
                              Icons.calendar_today,
                              color: primaryGold,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      _buildTextField(
                        bio,
                        "Short Bio",
                        hint: "Brief details about your spiritual work...",
                        maxLines: 3,
                      ),
                    ],
                  ),

                  // 2. Contact Information
                  _buildSectionCard(
                    title: "Contact Information",
                    icon: Icons.contact_phone_outlined,
                    children: [
                      _buildTextField(
                        phone,
                        "Phone Number *",
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.phone, color: primaryGold),
                        validator: (val) => val == null || val.trim().isEmpty
                            ? "Phone number is required"
                            : null,
                      ),
                      _buildTextField(
                        alternatePhone,
                        "Alternate Phone",
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.phone_outlined, color: primaryGold),
                      ),
                      _buildTextField(
                        whatsapp,
                        "WhatsApp Number",
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.chat, color: primaryGold),
                      ),
                      _buildTextField(
                        email,
                        "Email Address",
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined, color: primaryGold),
                      ),
                    ],
                  ),

                  // 3. Spiritual & Vedic Background
                  _buildSectionCard(
                    title: "Vedic & Spiritual Background",
                    icon: Icons.temple_hindu_outlined,
                    children: [
                      _buildTextField(religion, "Religion", hint: "e.g. Hindu"),
                      _buildTextField(
                        sampraday,
                        "Sampraday",
                        hint: "e.g. Shaiva, Vaishnava, Smartha",
                      ),
                      _buildTextField(
                        vedaShakha,
                        "Veda Shakha",
                        hint: "e.g. Rigveda, Yajurveda, Samaveda",
                      ),
                      _buildTextField(
                        qualification,
                        "Qualification",
                        hint: "e.g. Shastri, Acharya, Diploma",
                      ),
                      _buildTextField(
                        experience,
                        "Experience (Years) *",
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return "Enter experience in years";
                          }
                          if (int.tryParse(val.trim()) == null) {
                            return "Enter a valid number";
                          }
                          return null;
                        },
                      ),
                      // Language Preference
                      Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: DropdownButtonFormField<String>(
                          initialValue: selectedLanguage,
                          decoration: InputDecoration(
                            labelText: "Preferred Language",
                            labelStyle: TextStyle(
                              color: primaryGold.withValues(alpha: 0.95),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: primaryGold.withValues(alpha: 0.35),
                              ),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'mr',
                              child: Text('Marathi (मराठी)'),
                            ),
                            DropdownMenuItem(
                              value: 'hi',
                              child: Text('Hindi (हिंदी)'),
                            ),
                            DropdownMenuItem(
                              value: 'en',
                              child: Text('English'),
                            ),
                            DropdownMenuItem(
                              value: 'gu',
                              child: Text('Gujarati (ગુજરાતી)'),
                            ),
                            DropdownMenuItem(
                              value: 'sa',
                              child: Text('Sanskrit (संस्कृतम्)'),
                            ),
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => selectedLanguage = val);
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  // 4. Current Address
                  _buildSectionCard(
                    title: "Current Address",
                    icon: Icons.location_on_outlined,
                    children: [
                      _buildTextField(currentAddress1, "Address Line 1"),
                      _buildTextField(currentAddress2, "Address Line 2"),
                      _buildTextField(currentVillage, "Village / Town"),
                      _buildTextField(currentTaluka, "Taluka"),
                      _buildTextField(currentDistrict, "District"),
                      _buildTextField(currentState, "State"),
                      _buildTextField(currentCountry, "Country"),
                      _buildTextField(
                        currentPincode,
                        "Pincode",
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),

                  // 5. Permanent Address
                  _buildSectionCard(
                    title: "Permanent Address",
                    icon: Icons.home_outlined,
                    children: [
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        activeColor: primaryGold,
                        value: permanentSameAsCurrent,
                        title: const Text(
                          "Permanent address same as current address",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: darkBrown,
                          ),
                        ),
                        onChanged: (val) {
                          setState(() {
                            permanentSameAsCurrent = val ?? false;
                            if (permanentSameAsCurrent) {
                              _copyCurrentToPermanent();
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 6),
                      _buildTextField(
                        permanentAddress1,
                        "Address Line 1",
                        enabled: !permanentSameAsCurrent,
                      ),
                      _buildTextField(
                        permanentAddress2,
                        "Address Line 2",
                        enabled: !permanentSameAsCurrent,
                      ),
                      _buildTextField(
                        permanentVillage,
                        "Village / Town",
                        enabled: !permanentSameAsCurrent,
                      ),
                      _buildTextField(
                        permanentTaluka,
                        "Taluka",
                        enabled: !permanentSameAsCurrent,
                      ),
                      _buildTextField(
                        permanentDistrict,
                        "District",
                        enabled: !permanentSameAsCurrent,
                      ),
                      _buildTextField(
                        permanentState,
                        "State",
                        enabled: !permanentSameAsCurrent,
                      ),
                      _buildTextField(
                        permanentCountry,
                        "Country",
                        enabled: !permanentSameAsCurrent,
                      ),
                      _buildTextField(
                        permanentPincode,
                        "Pincode",
                        keyboardType: TextInputType.number,
                        enabled: !permanentSameAsCurrent,
                      ),
                    ],
                  ),

                  // 6. Bank Details (Optional)
                  _buildSectionCard(
                    title: "Bank Account Details",
                    icon: Icons.account_balance_outlined,
                    children: [
                      _buildTextField(accountHolder, "Account Holder Name"),
                      _buildTextField(bankName, "Bank Name"),
                      _buildTextField(
                        accountNumber,
                        "Account Number",
                        keyboardType: TextInputType.number,
                      ),
                      _buildTextField(ifsc, "IFSC Code"),
                      _buildTextField(upiId, "UPI ID"),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Submit Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentMaroon,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                    onPressed: isLoading ? null : _submit,
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Save Changes",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
