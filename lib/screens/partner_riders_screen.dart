import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/partner_theme.dart';
import '../models/partner_models.dart';
import '../providers/partner_provider.dart';
import '../services/partner_api_service.dart';

class PartnerRidersScreen extends StatelessWidget {
  const PartnerRidersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PartnerProvider>();
    final api = PartnerApiService();

    return Scaffold(
      backgroundColor: PartnerTheme.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Local Delivery Fleet', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
            Text('Territory Riders • COD Cash-in-Hand Supervision', style: TextStyle(fontSize: 10.5, color: PartnerTheme.emeraldGreen)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_rounded, color: PartnerTheme.emeraldGreen),
            tooltip: 'Recruit Rider',
            onPressed: () => api.sendRiderRecruitment('+919835000000'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Fleet Risk Guard Banner
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: PartnerTheme.emeraldGreen.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: PartnerTheme.emeraldGreen.withValues(alpha: 0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.security_rounded, color: PartnerTheme.emeraldGreen, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Cash-on-Delivery (COD) Risk Guard Active', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: PartnerTheme.emeraldGreen)),
                      SizedBox(height: 2),
                      Text('Riders with >₹2,500 unremitted cash are flagged for immediate UPI collection.', style: TextStyle(fontSize: 10.5, color: PartnerTheme.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          const Text('ASSIGNED TERRITORY RIDERS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: PartnerTheme.textSecondary, letterSpacing: 0.8)),
          const SizedBox(height: 8),

          ...provider.riders.map((rider) => _buildRiderTile(context, rider, api)),
        ],
      ),
    );
  }

  Widget _buildRiderTile(BuildContext context, PartnerRiderModel rider, PartnerApiService api) {
    final isLocked = rider.unremittedCash >= 2500.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PartnerTheme.surfaceCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isLocked ? PartnerTheme.crimsonRed : PartnerTheme.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: isLocked ? PartnerTheme.crimsonRed.withValues(alpha: 0.15) : PartnerTheme.emeraldGreen.withValues(alpha: 0.15),
            child: Icon(Icons.two_wheeler_rounded, color: isLocked ? PartnerTheme.crimsonRed : PartnerTheme.emeraldGreen, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(rider.name, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                      decoration: BoxDecoration(
                        color: rider.isOnline ? PartnerTheme.emeraldGreen.withValues(alpha: 0.2) : PartnerTheme.surfaceElevated,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(rider.isOnline ? 'ONLINE' : 'OFFLINE', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: rider.isOnline ? PartnerTheme.emeraldGreen : PartnerTheme.textMuted)),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text('Today: ${rider.completedTripsToday} deliveries completed', style: const TextStyle(fontSize: 11, color: PartnerTheme.textSecondary)),
                Text(
                  'COD Cash in Hand: ₹${rider.unremittedCash.toStringAsFixed(0)}${isLocked ? ' ⚠️ LIMIT EXCEEDED' : ''}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: isLocked ? PartnerTheme.crimsonRed : PartnerTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chat_rounded, color: PartnerTheme.emeraldGreen),
            tooltip: 'Remind Rider via WhatsApp',
            onPressed: () => api.sendRiderRecruitment(rider.phone),
          ),
        ],
      ),
    );
  }
}
