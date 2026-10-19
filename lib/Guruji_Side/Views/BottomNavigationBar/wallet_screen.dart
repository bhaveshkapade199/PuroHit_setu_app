import 'package:flutter/material.dart';
import 'package:purohitset_app/Widget/custom_appbar.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  static const Color primaryColor = Color(0xFF421212);
  static const Color navyColor = Color(0xFF1E3A5F);
  static const Color backgroundColor = Color(0xFFF8F6F0);

  final List<Map<String, dynamic>> transactions = const [
    {
      'title': 'Pooja Booking Payment',
      'subtitle': 'Rahul Sharma',
      'date': '19 Oct 2026 • 09:30 AM',
      'amount': 5100.0,
      'type': 'credit',
      'status': 'Completed',
    },
    {
      'title': 'Bank Withdrawal',
      'subtitle': 'Account •••• 4582',
      'date': '18 Oct 2026 • 05:15 PM',
      'amount': 2000.0,
      'type': 'debit',
      'status': 'Completed',
    },
    {
      'title': 'Satyanarayan Pooja',
      'subtitle': 'Amit Patil',
      'date': '18 Oct 2026 • 11:20 AM',
      'amount': 3100.0,
      'type': 'credit',
      'status': 'Completed',
    },
    {
      'title': 'Ganesh Pooja Booking',
      'subtitle': 'Sneha Joshi',
      'date': '17 Oct 2026 • 02:45 PM',
      'amount': 2100.0,
      'type': 'credit',
      'status': 'Pending',
    },
    {
      'title': 'Bank Withdrawal',
      'subtitle': 'Account •••• 4582',
      'date': '16 Oct 2026 • 04:10 PM',
      'amount': 1500.0,
      'type': 'debit',
      'status': 'Completed',
    },
    {
      'title': 'Griha Pravesh Pooja',
      'subtitle': 'Vikas Deshmukh',
      'date': '15 Oct 2026 • 10:00 AM',
      'amount': 7500.0,
      'type': 'credit',
      'status': 'Completed',
    },
    {
      'title': 'Pooja Booking Payment',
      'subtitle': 'Priya Kulkarni',
      'date': '14 Oct 2026 • 12:30 PM',
      'amount': 2500.0,
      'type': 'credit',
      'status': 'Failed',
    },
    {
      'title': 'Lakshmi Pooja',
      'subtitle': 'Neha Patil',
      'date': '13 Oct 2026 • 09:00 AM',
      'amount': 4100.0,
      'type': 'credit',
      'status': 'Completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: 'Wallet', centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Wallet Balance Card
            Card(
              elevation: 3,
              shadowColor: primaryColor.withValues(alpha: 0.15),
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EBDD),
                  border: Border.all(width: 1.5, color: primaryColor),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_outlined,
                          color: primaryColor,
                          size: 22,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Available Balance',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '₹10,00,000.00',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Implement withdrawal flow.
                          },
                          icon: const Icon(
                            Icons.arrow_upward_rounded,
                            size: 18,
                          ),
                          label: const Text('Withdraw'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: navyColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            // Transaction Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transactions',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFE0D8CC)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.sort_rounded,
                        size: 18,
                        color: Color(0xFF421212),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Sort',
                        style: TextStyle(
                          color: Color(0xFF421212),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18,
                        color: Color(0xFF421212),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Transaction List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: transactions.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final transaction = transactions[index];

                  final bool isCredit = transaction['type'] == 'credit';

                  final String status = transaction['status'] as String;

                  final Color statusColor = status == 'Completed'
                      ? const Color(0xFF218653)
                      : status == 'Pending'
                      ? const Color(0xFFB7791F)
                      : const Color(0xFFC0392B);

                  final Color amountColor = status == 'Failed'
                      ? Colors.grey
                      : isCredit
                      ? const Color(0xFF218653)
                      : primaryColor;

                  final IconData transactionIcon = status == 'Failed'
                      ? Icons.error_outline_rounded
                      : isCredit
                      ? Icons.south_west_rounded
                      : Icons.north_east_rounded;

                  final double amount = transaction['amount'] as double;

                  return Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFEAE5DC)),
                    ),
                    child: Row(
                      children: [
                        // Transaction Icon
                        Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            color:
                                (isCredit ? const Color(0xFF218653) : navyColor)
                                    .withValues(alpha: 0.09),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Icon(
                            transactionIcon,
                            color: isCredit
                                ? const Color(0xFF218653)
                                : navyColor,
                            size: 23,
                          ),
                        ),

                        const SizedBox(width: 12),

                        // Transaction Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction['title'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF292524),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                transaction['subtitle'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 11,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                transaction['date'] as String,
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 10,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.10),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Transaction Amount
                        Text(
                          '${isCredit ? '+' : '-'} ₹${amount.toStringAsFixed(2)}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: amountColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
