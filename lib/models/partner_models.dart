class PartnerProfileModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String assignedZone;
  final String city;
  final String state;
  final double totalGmv;
  final double totalCommissionEarned;
  final double withdrawableBalance;
  final int managedStores;
  final int activeRiders;

  const PartnerProfileModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.assignedZone,
    required this.city,
    required this.state,
    required this.totalGmv,
    required this.totalCommissionEarned,
    required this.withdrawableBalance,
    required this.managedStores,
    required this.activeRiders,
  });
}

class PartnerStoreModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String category;
  final double gmvThisMonth;
  final double partnerCommission;
  final String status; // 'active', 'pending_verification', 'claim_requested'
  final DateTime joinedDate;

  const PartnerStoreModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.category,
    required this.gmvThisMonth,
    required this.partnerCommission,
    required this.status,
    required this.joinedDate,
  });
}

class CommissionTransactionModel {
  final String id;
  final String storeOrOrderId;
  final String type; // 'order_commission', 'bounty', 'payout'
  final double amount;
  final DateTime timestamp;
  final String status; // 'credited', 'paid', 'processing'

  const CommissionTransactionModel({
    required this.id,
    required this.storeOrOrderId,
    required this.type,
    required this.amount,
    required this.timestamp,
    required this.status,
  });
}

class PartnerRiderModel {
  final int id;
  final String name;
  final String phone;
  final int completedTripsToday;
  final double unremittedCash;
  final bool isOnline;

  const PartnerRiderModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.completedTripsToday,
    required this.unremittedCash,
    required this.isOnline,
  });
}

class PartnerChatMessageModel {
  final String id;
  final bool isUser;
  final String text;
  final DateTime timestamp;

  const PartnerChatMessageModel({
    required this.id,
    required this.isUser,
    required this.text,
    required this.timestamp,
  });
}
