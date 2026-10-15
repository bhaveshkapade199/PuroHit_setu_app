import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purohitset_app/Widget/custom_appbar.dart';

class PoojaDetailScreen extends StatelessWidget {
  const PoojaDetailScreen({super.key});

  static const Color maroon = Color(0xFF66110B);
  static const Color gold = Color(0xFFCD9933);
  static const Color cream = Color(0xFFFFFAF0);
  static const Color darkBrown = Color(0xFF4A2418);
  static const Color cardColor = Color(0xFFF0EBDD);

  final String poojaId = 'POOJA001';
  final String poojaName = 'Ganesh Pooja';
  final String yajamanName = 'Amit Sharma';
  final String contactNumber = '+91 98765 43210';
  final String email = 'amit.sharma@example.com';
  final String date = '20 October 2026';
  final String time = '10:00 AM';
  final String location = 'Kothrud, Pune';

  final String fullAddress =
      'Flat 202, Shree Residency, Near MIT College, '
      'Kothrud, Pune, Maharashtra 411038';

  final List<String> samagriList = const [
    'Lord Ganesha idol or photo',
    'Flowers',
    'Durva grass',
    'Coconut',
    'Betel leaves',
    'Betel nuts',
    'Turmeric powder',
    'Kumkum',
    'Akshata (rice grains)',
    'Incense sticks',
    'Camphor',
    'Diya and cotton wicks',
    'Ghee or oil',
    'Fruits',
    'Modak or sweets',
  ];

  Future<void> _copyAddress(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: fullAddress));

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Address copied successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,
      appBar: CustomAppBar(
        title: "Pooja Details",
        showLogo: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 16),
            _buildSectionTitle('Yajaman Details'),
            _buildYajamanCard(),
            const SizedBox(height: 16),
            _buildSectionTitle('Pooja Location'),
            _buildLocationCard(context),
            const SizedBox(height: 16),
            _buildSectionTitle('Pooja Samagri'),
            _buildSamagriCard(),
            const SizedBox(height: 24),
            _buildActionButtons(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: maroon,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            poojaName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pooja ID: $poojaId',
            style: const TextStyle(color: Colors.white70),
          ),
          const Divider(color: Colors.white30, height: 24),
          _headerInfo(Icons.calendar_month, date),
          const SizedBox(height: 10),
          _headerInfo(Icons.access_time, time),
          const SizedBox(height: 10),
          _headerInfo(Icons.location_on, location),
        ],
      ),
    );
  }

  Widget _headerInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: gold, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: maroon,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildYajamanCard() {
    return _buildCard(
      child: Column(
        children: [
          _detailRow(Icons.person, 'Yajaman Name', yajamanName),
          _detailRow(Icons.phone, 'Contact Number', contactNumber),
          _detailRow(Icons.email, 'Email Address', email),
        ],
      ),
    );
  }

  Widget _buildLocationCard(BuildContext context) {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on, color: maroon, size: 24),
              SizedBox(width: 8),
              Text(
                'Pooja Address',
                style: TextStyle(fontWeight: FontWeight.bold, color: darkBrown),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            fullAddress,
            style: const TextStyle(color: darkBrown, height: 1.5),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _copyAddress(context),
              icon: const Icon(Icons.directions, color: maroon),
              label: const Text('Get Address', style: TextStyle(color: maroon)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: maroon),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSamagriCard() {
    return _buildCard(
      child: Column(
        children: List.generate(samagriList.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle_outline, color: gold, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    samagriList[index],
                    style: const TextStyle(color: darkBrown, fontSize: 14),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Start Pooja API integration required'),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start Pooja'),
            style: ElevatedButton.styleFrom(
              backgroundColor: maroon,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('End Pooja API integration required'),
                ),
              );
            },
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('End Pooja'),
            style: OutlinedButton.styleFrom(
              foregroundColor: maroon,
              side: const BorderSide(color: maroon),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: gold.withValues(alpha: 0.35)),
      ),
      child: child,
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: maroon, size: 21),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: darkBrown, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: darkBrown,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
