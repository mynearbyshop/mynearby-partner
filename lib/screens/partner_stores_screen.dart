import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/partner_theme.dart';
import '../models/partner_models.dart';
import '../providers/partner_provider.dart';
import '../services/partner_api_service.dart';

class PartnerStoresScreen extends StatelessWidget {
  const PartnerStoresScreen({super.key});

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
            Text('Territory Stores & Claims', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
            Text('Approve Claims • Earn ₹250 Bounty • Oversee GMV', style: TextStyle(fontSize: 10.5, color: PartnerTheme.primaryGold)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Bounty Explainer Banner
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: PartnerTheme.primaryGold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: PartnerTheme.primaryGold.withValues(alpha: 0.3)),
            ),
            child: const Row(
              children: [
                Icon(Icons.workspace_premium_rounded, color: PartnerTheme.primaryGold, size: 24),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('₹250 Onboarding Bounty Active', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: PartnerTheme.primaryGold)),
                      SizedBox(height: 2),
                      Text('Verify local shop owners and help them download Vendor App to claim your bounty.', style: TextStyle(fontSize: 10.5, color: PartnerTheme.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          const Text('STORES IN YOUR FRANCHISE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: PartnerTheme.textSecondary, letterSpacing: 0.8)),
          const SizedBox(height: 8),

          ...provider.stores.map((store) => _buildStoreTile(context, store, provider, api)),
        ],
      ),
    );
  }

  Widget _buildStoreTile(BuildContext context, PartnerStoreModel store, PartnerProvider provider, PartnerApiService api) {
    final isClaim = store.status == 'claim_requested';
    final isPending = store.status == 'pending_verification';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: PartnerTheme.surfaceCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isClaim ? PartnerTheme.primaryGold : PartnerTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: PartnerTheme.surfaceElevated, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.storefront_rounded, color: PartnerTheme.primaryGold, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(store.name, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 2),
                    Text('${store.category} • ${store.address}', style: const TextStyle(fontSize: 10.5, color: PartnerTheme.textSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              if (isClaim)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(color: PartnerTheme.primaryGold.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
                  child: const Text('CLAIM PENDING', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: PartnerTheme.primaryGold)),
                )
              else if (isPending)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(color: PartnerTheme.cyanAccent.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
                  child: const Text('VERIFICATION', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: PartnerTheme.cyanAccent)),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(color: PartnerTheme.emeraldGreen.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
                  child: const Text('ACTIVE', style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w900, color: PartnerTheme.emeraldGreen)),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('GMV: ₹${store.gmvThisMonth.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11, color: PartnerTheme.textMuted)),
              Text('Your Commission: ₹${store.partnerCommission.toStringAsFixed(0)}', style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: PartnerTheme.primaryGold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => api.sendStoreInvitation(store.phone, store.name),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: PartnerTheme.textPrimary,
                    side: const BorderSide(color: PartnerTheme.border),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  icon: const Icon(Icons.chat_rounded, size: 16, color: PartnerTheme.emeraldGreen),
                  label: const Text('WhatsApp', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                ),
              ),
              if (isClaim || isPending) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      provider.verifyStore(store.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('✅ ${store.name} verified! ₹250 bounty credited to your balance.')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PartnerTheme.emeraldGreen,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    icon: const Icon(Icons.check_circle_rounded, size: 16),
                    label: const Text('Approve (+₹250)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
