import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constants/partner_constants.dart';
import '../core/theme/partner_theme.dart';
import '../models/partner_models.dart';
import '../providers/partner_provider.dart';
import '../services/partner_api_service.dart';

class PartnerDashboardScreen extends StatelessWidget {
  const PartnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PartnerProvider>();
    final profile = provider.profile;
    final api = PartnerApiService();

    return Scaffold(
      backgroundColor: PartnerTheme.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(PartnerConstants.appName, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: PartnerTheme.primaryGold)),
            Text('${profile.assignedZone} • Master Franchise', style: const TextStyle(fontSize: 10.5, color: PartnerTheme.textSecondary)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded, color: PartnerTheme.primaryGold),
            tooltip: 'Invite Store Owner',
            onPressed: () => api.sendStoreInvitation('+919835000000', 'Local Store'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Executive Wallet Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: PartnerTheme.surfaceCard,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: PartnerTheme.primaryGold.withValues(alpha: 0.4)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  PartnerTheme.primaryGold.withValues(alpha: 0.18),
                  PartnerTheme.surfaceCard,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('WITHDRAWABLE COMMISSION', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: PartnerTheme.primaryGold, letterSpacing: 1)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: PartnerTheme.emeraldGreen.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                      child: const Text('AUTO-PAYOUT ON', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: PartnerTheme.emeraldGreen)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text('₹${profile.withdrawableBalance.toStringAsFixed(2)}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: PartnerTheme.textPrimary)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total GMV Processed', style: TextStyle(fontSize: 10, color: PartnerTheme.textMuted)),
                          const SizedBox(height: 2),
                          Text('₹${profile.totalGmv.toStringAsFixed(0)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: PartnerTheme.textPrimary)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Lifetime Commission', style: TextStyle(fontSize: 10, color: PartnerTheme.textMuted)),
                          const SizedBox(height: 2),
                          Text('₹${profile.totalCommissionEarned.toStringAsFixed(0)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: PartnerTheme.primaryGold)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('💸 Payout request of ₹${profile.withdrawableBalance.toStringAsFixed(0)} submitted to bank/UPI!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PartnerTheme.primaryGold,
                    foregroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(42),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: const Icon(Icons.account_balance_rounded, size: 18),
                  label: const Text('Withdraw Commission to Bank / UPI', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Territory Overview Tiles
          Row(
            children: [
              Expanded(
                child: _buildMetricTile(
                  icon: Icons.storefront_rounded,
                  label: 'Territory Stores',
                  value: profile.managedStores.toString(),
                  color: PartnerTheme.cyanAccent,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricTile(
                  icon: Icons.two_wheeler_rounded,
                  label: 'Assigned Riders',
                  value: profile.activeRiders.toString(),
                  color: PartnerTheme.emeraldGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Commission Ledger Feed
          const Text('RECENT COMMISSION EARNINGS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: PartnerTheme.textSecondary, letterSpacing: 0.8)),
          const SizedBox(height: 10),

          ...provider.ledger.map((txn) => _buildLedgerTile(txn)),
        ],
      ),
    );
  }

  Widget _buildMetricTile({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PartnerTheme.surfaceCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PartnerTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: PartnerTheme.textPrimary)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11, color: PartnerTheme.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildLedgerTile(CommissionTransactionModel txn) {
    final isCredit = txn.amount > 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: PartnerTheme.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: PartnerTheme.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isCredit ? PartnerTheme.emeraldGreen.withValues(alpha: 0.15) : PartnerTheme.crimsonRed.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
              color: isCredit ? PartnerTheme.emeraldGreen : PartnerTheme.crimsonRed,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(txn.storeOrOrderId, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(txn.type.replaceAll('_', ' ').toUpperCase(), style: const TextStyle(fontSize: 9.5, color: PartnerTheme.textMuted, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Text(
            '${isCredit ? '+' : ''}₹${txn.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: isCredit ? PartnerTheme.emeraldGreen : PartnerTheme.crimsonRed,
            ),
          ),
        ],
      ),
    );
  }
}
