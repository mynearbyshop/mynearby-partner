import 'package:flutter/foundation.dart';
import '../models/partner_models.dart';

class PartnerProvider extends ChangeNotifier {
  // Partner Profile
  PartnerProfileModel _profile = const PartnerProfileModel(
    id: 101,
    name: 'Vikash Kumar Srivastava',
    phone: '+91 98352 90114',
    email: 'vikash.partner@mynearby.shop',
    assignedZone: 'Mohania, Kudra & Kaimur Belt',
    city: 'Mohania',
    state: 'Bihar',
    totalGmv: 486250.0,
    totalCommissionEarned: 24312.0,
    withdrawableBalance: 8450.0,
    managedStores: 350,
    activeRiders: 12,
  );

  PartnerProfileModel get profile => _profile;

  // Stores in Partner's Territory
  final List<PartnerStoreModel> _stores = [
    PartnerStoreModel(
      id: 2094,
      name: 'Saloni Kirana Store',
      phone: '+91 62024 19200',
      address: 'Badka Kajhar, Kudra - Lalapur Flyover',
      category: 'Quick Grocery',
      gmvThisMonth: 38400.0,
      partnerCommission: 768.0,
      status: 'claim_requested',
      joinedDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    PartnerStoreModel(
      id: 2077,
      name: 'Nyaz Vastralaya Mohania',
      phone: '+91 97983 95175',
      address: 'Station Road, Mohania GT Road',
      category: 'eCommerce',
      gmvThisMonth: 84200.0,
      partnerCommission: 1684.0,
      status: 'active',
      joinedDate: DateTime.now().subtract(const Duration(days: 28)),
    ),
    PartnerStoreModel(
      id: 2076,
      name: 'Santosh Kumar Pandey Kirana',
      phone: '+91 73766 69946',
      address: 'Station Chowk, Mohania',
      category: 'Quick Grocery',
      gmvThisMonth: 62100.0,
      partnerCommission: 1242.0,
      status: 'active',
      joinedDate: DateTime.now().subtract(const Duration(days: 45)),
    ),
    PartnerStoreModel(
      id: 1979,
      name: 'Sada Bahar Cake Shop',
      phone: '+91 91227 25578',
      address: 'Sada Bahar Gali, Kudra Market Road',
      category: 'Bakery',
      gmvThisMonth: 29500.0,
      partnerCommission: 590.0,
      status: 'active',
      joinedDate: DateTime.now().subtract(const Duration(days: 14)),
    ),
    PartnerStoreModel(
      id: 2093,
      name: 'Keshri Tambaku & General Store',
      phone: '+91 87095 84991',
      address: 'Shop No 5, Lalapur Kudra',
      category: 'Quick Grocery',
      gmvThisMonth: 12800.0,
      partnerCommission: 256.0,
      status: 'pending_verification',
      joinedDate: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  List<PartnerStoreModel> get stores => _stores;

  void verifyStore(int storeId) {
    final idx = _stores.indexWhere((s) => s.id == storeId);
    if (idx != -1) {
      final s = _stores[idx];
      _stores[idx] = PartnerStoreModel(
        id: s.id,
        name: s.name,
        phone: s.phone,
        address: s.address,
        category: s.category,
        gmvThisMonth: s.gmvThisMonth,
        partnerCommission: s.partnerCommission + 250.0, // Onboarding Bounty
        status: 'active',
        joinedDate: s.joinedDate,
      );
      _profile = PartnerProfileModel(
        id: _profile.id,
        name: _profile.name,
        phone: _profile.phone,
        email: _profile.email,
        assignedZone: _profile.assignedZone,
        city: _profile.city,
        state: _profile.state,
        totalGmv: _profile.totalGmv,
        totalCommissionEarned: _profile.totalCommissionEarned + 250.0,
        withdrawableBalance: _profile.withdrawableBalance + 250.0,
        managedStores: _profile.managedStores + 1,
        activeRiders: _profile.activeRiders,
      );
      notifyListeners();
    }
  }

  // Riders in Territory
  final List<PartnerRiderModel> _riders = [
    const PartnerRiderModel(id: 1, name: 'Sunil Kumar', phone: '+91 70071 52890', completedTripsToday: 9, unremittedCash: 3120.0, isOnline: true),
    const PartnerRiderModel(id: 2, name: 'Pankaj Bind', phone: '+91 91250 88219', completedTripsToday: 6, unremittedCash: 1240.0, isOnline: true),
    const PartnerRiderModel(id: 3, name: 'Raju Kushwaha', phone: '+91 98351 10923', completedTripsToday: 4, unremittedCash: 680.0, isOnline: false),
  ];

  List<PartnerRiderModel> get riders => _riders;

  // Commission Ledger
  final List<CommissionTransactionModel> _ledger = [
    CommissionTransactionModel(id: 'TXN-908', storeOrOrderId: 'ORD-5412 (Mohania)', type: 'order_commission', amount: 48.0, timestamp: DateTime.now().subtract(const Duration(minutes: 25)), status: 'credited'),
    CommissionTransactionModel(id: 'TXN-907', storeOrOrderId: 'STORE-2076 (Mohania)', type: 'bounty', amount: 250.0, timestamp: DateTime.now().subtract(const Duration(hours: 4)), status: 'credited'),
    CommissionTransactionModel(id: 'TXN-906', storeOrOrderId: 'PAYOUT-UPI-884', type: 'payout', amount: -5000.0, timestamp: DateTime.now().subtract(const Duration(days: 2)), status: 'paid'),
    CommissionTransactionModel(id: 'TXN-905', storeOrOrderId: 'ORD-5390 (Kudra)', type: 'order_commission', amount: 32.0, timestamp: DateTime.now().subtract(const Duration(days: 2)), status: 'credited'),
  ];

  List<CommissionTransactionModel> get ledger => _ledger;

  // Partner AI Chat
  final List<PartnerChatMessageModel> _chatMessages = [
    PartnerChatMessageModel(
      id: 'AI-1',
      isUser: false,
      text: 'Namaste Vikash Ji! I am your MyNearby Partner AI.\n\nYour Mohania & Kudra franchise has processed ₹4.86L GMV this month with ₹24,312 commission earned.\n\nWhat would you like to review today?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
  ];

  List<PartnerChatMessageModel> get chatMessages => _chatMessages;

  void sendMessage(String prompt) {
    _chatMessages.add(
      PartnerChatMessageModel(
        id: 'USER-${DateTime.now().millisecondsSinceEpoch}',
        isUser: true,
        text: prompt,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 600), () {
      String response = 'Understood! Updating territory metrics for your franchise.';
      final lower = prompt.toLowerCase();
      if (lower.contains('store') || lower.contains('kudra') || lower.contains('mohania')) {
        response = '📍 Territory Stores Overview:\n• 343 Stores in Mohania, 7 in Kudra\n• Saloni Kirana (Kudra) has requested claim approval.\n• Suggestion: Tap "Approve & Verify" to earn ₹250 onboarding bounty.';
      } else if (lower.contains('commission') || lower.contains('payout') || lower.contains('balance')) {
        response = '💰 Wallet & Payouts:\n• Available balance: ₹8,450.00\n• Minimum payout threshold: ₹1,000\n• Bank/UPI transfer will be processed to: vikash@upi.';
      } else if (lower.contains('rider')) {
        response = '🛵 Fleet Status:\n• 12 Riders assigned in Mohania & Kudra\n• Sunil Kumar has collected ₹3,120 COD cash (exceeds ₹2,500 limit). Automated UPI remittance reminder has been sent.';
      }

      _chatMessages.add(
        PartnerChatMessageModel(
          id: 'AI-RESP-${DateTime.now().millisecondsSinceEpoch}',
          isUser: false,
          text: response,
          timestamp: DateTime.now(),
        ),
      );
      notifyListeners();
    });
  }
}
