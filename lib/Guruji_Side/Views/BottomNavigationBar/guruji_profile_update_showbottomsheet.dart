import 'package:flutter/material.dart';
import 'package:purohitset_app/Guruji_Side/Model/Auth/guruji_profile_model.dart';
import 'package:purohitset_app/Guruji_Side/Views/Profile/update_profile_screen.dart';

// Exports UpdateProfileScreen and provides a helper for showing it
export 'package:purohitset_app/Guruji_Side/Views/Profile/update_profile_screen.dart';

class GurujiProfileEditBottomSheet extends StatelessWidget {
  final Guruji guruji;
  final VoidCallback onUpdated;

  const GurujiProfileEditBottomSheet({
    super.key,
    required this.guruji,
    required this.onUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return UpdateProfileScreen(guruji: guruji, onUpdated: onUpdated);
  }
}
