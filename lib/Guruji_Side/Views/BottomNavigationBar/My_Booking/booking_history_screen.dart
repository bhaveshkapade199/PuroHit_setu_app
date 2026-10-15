import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigation_bloc.dart';
import 'package:purohitset_app/Guruji_Side/Bloc/BottomNavigationBar/bottomNavigationbar_event.dart';
import 'package:purohitset_app/Guruji_Side/Views/BottomNavigationBar/My_Booking/pooja_detail_screen.dart';
import 'package:purohitset_app/Widget/custom_appbar.dart';

enum BookingStatus { incoming, current, completed, rejected }

class Booking {
  final String poojaId;
  final String poojaName;
  final String yajamanName;
  final String location;
  final BookingStatus status;

  const Booking({
    required this.poojaId,
    required this.poojaName,
    required this.yajamanName,
    required this.location,
    required this.status,
  });

  Booking copyWith({
    String? poojaId,
    String? poojaName,
    String? yajamanName,
    String? location,
    BookingStatus? status,
  }) {
    return Booking(
      poojaId: poojaId ?? this.poojaId,
      poojaName: poojaName ?? this.poojaName,
      yajamanName: yajamanName ?? this.yajamanName,
      location: location ?? this.location,
      status: status ?? this.status,
    );
  }
}

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  int _selectedTabIndex = 0;

  final List<Booking> _bookings = [
    const Booking(
      poojaId: 'POOJA001',
      poojaName: 'Ganesh Pooja',
      yajamanName: 'Amit Sharma',
      location: 'Pune, Maharashtra',
      status: BookingStatus.incoming,
    ),
    const Booking(
      poojaId: 'POOJA002',
      poojaName: 'Satyanarayan Pooja',
      yajamanName: 'Rahul Patil',
      location: 'Nashik, Maharashtra',
      status: BookingStatus.incoming,
    ),
    const Booking(
      poojaId: 'POOJA003',
      poojaName: 'Griha Pravesh Pooja',
      yajamanName: 'Suresh Joshi',
      location: 'Mumbai, Maharashtra',
      status: BookingStatus.current,
    ),
    const Booking(
      poojaId: 'POOJA004',
      poojaName: 'Lakshmi Pooja',
      yajamanName: 'Rohit Deshmukh',
      location: 'Nagpur, Maharashtra',
      status: BookingStatus.completed,
    ),
  ];

  void _updateBookingStatus(Booking booking, BookingStatus newStatus) {
    setState(() {
      final index = _bookings.indexWhere(
        (item) => item.poojaId == booking.poojaId,
      );

      if (index != -1) {
        _bookings[index] = _bookings[index].copyWith(status: newStatus);
      }

      // Automatically open the tab matching the new status.
      if (newStatus == BookingStatus.current) {
        _selectedTabIndex = 1;
      } else if (newStatus == BookingStatus.completed) {
        _selectedTabIndex = 2;
      }
    });

    switch (newStatus) {
      case BookingStatus.current:
        _showMessage('Booking accepted successfully');
        break;
      case BookingStatus.rejected:
        _showMessage('Booking rejected');
        break;
      case BookingStatus.completed:
        _showMessage('Pooja marked as completed');
        break;
      case BookingStatus.incoming:
        break;
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF66110B),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  List<Booking> _getBookings(BookingStatus status) {
    return _bookings.where((booking) => booking.status == status).toList();
  }

  Widget _buildTab(String title, int index) {
    final bool isSelected = _selectedTabIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 3),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF66110B) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF66110B),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingList(BookingStatus status) {
    final bookings = _getBookings(status);

    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              status == BookingStatus.incoming
                  ? Icons.inbox_outlined
                  : status == BookingStatus.current
                  ? Icons.event_note_outlined
                  : Icons.task_alt_outlined,
              size: 60,
              color: const Color(0xFFCD9933),
            ),
            const SizedBox(height: 12),
            Text(
              status == BookingStatus.incoming
                  ? 'No incoming pooja bookings'
                  : status == BookingStatus.current
                  ? 'No current pooja bookings'
                  : 'No completed pooja bookings',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF4A2418),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      key: PageStorageKey<BookingStatus>(status),
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];

        return BookingRequestTile(
          key: ValueKey(booking.poojaId),
          booking: booking,
          onAccept: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PoojaDetailScreen()),
            );
          },
          onReject: () {
            _updateBookingStatus(booking, BookingStatus.rejected);
          },
          onComplete: () {
            _updateBookingStatus(booking, BookingStatus.completed);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAF0),
      appBar: const CustomAppBar(
        title: 'My Bookings',

        showLogo: false,
        appBarHeight: 120,
        centerTitle: true,
      ),

      body: Column(
        children: [
          // Custom tabs outside the AppBar.
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF0EBDD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildTab('Incoming Pooja', 0),
                _buildTab('Current Pooja', 1),
                _buildTab('Completed Pooja', 2),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Display the list for the selected custom tab.
          Expanded(
            child: IndexedStack(
              index: _selectedTabIndex,
              children: [
                _buildBookingList(BookingStatus.incoming),
                _buildBookingList(BookingStatus.current),
                _buildBookingList(BookingStatus.completed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BookingRequestTile extends StatelessWidget {
  final Booking booking;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onComplete;

  const BookingRequestTile({
    super.key,
    required this.booking,
    required this.onAccept,
    required this.onReject,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF0EBDD),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.event_note,
                  color: Color(0xFF66110B),
                  size: 22,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    booking.poojaName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A2418),
                    ),
                  ),
                ),
                _buildStatusBadge(),
              ],
            ),

            const SizedBox(height: 12),

            _buildDetail('Pooja ID', booking.poojaId),
            _buildDetail('Yajaman Name', booking.yajamanName),
            _buildDetail('Location', booking.location),

            const SizedBox(height: 14),

            if (booking.status == BookingStatus.incoming)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReject,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF66110B),
                        side: const BorderSide(color: Color(0xFF66110B)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Reject'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onAccept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF66110B),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Accept'),
                    ),
                  ),
                ],
              ),

            if (booking.status == BookingStatus.current)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onComplete,
                  icon: const Icon(Icons.check_circle_outline),
                  label: const Text('Mark as Completed'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF66110B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 115,
            child: Text(
              '$title:',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A2418),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, color: Color(0xFF4A2418)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    late final String label;
    late final Color backgroundColor;
    late final Color textColor;

    switch (booking.status) {
      case BookingStatus.incoming:
        label = 'Incoming';
        backgroundColor = const Color(0xFFFFE0B2);
        textColor = const Color(0xFF8A4B08);
        break;

      case BookingStatus.current:
        label = 'Current';
        backgroundColor = const Color(0xFFD9E8FF);
        textColor = const Color(0xFF174A8B);
        break;

      case BookingStatus.completed:
        label = 'Completed';
        backgroundColor = const Color(0xFFD8EBD5);
        textColor = const Color(0xFF28652B);
        break;

      case BookingStatus.rejected:
        label = 'Rejected';
        backgroundColor = const Color(0xFFFFDADA);
        textColor = const Color(0xFF9B1C1C);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
