import 'package:url_launcher/url_launcher.dart';
import '../core/constants/partner_constants.dart';

class PartnerApiService {
  Future<bool> launchExternal(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    return false;
  }

  Future<void> sendStoreInvitation(String phone, String storeName) async {
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');
    final msg = Uri.encodeComponent(
        'Namaste! Your store $storeName in ${PartnerConstants.defaultCity} has been pre-verified by your local MyNearby City Partner. Download the official Vendor App to start receiving orders: ${PartnerConstants.vendorApkUrl}');
    final uri = Uri.parse('https://wa.me/$cleanPhone?text=$msg');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> sendRiderRecruitment(String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'\D'), '');
    final msg = Uri.encodeComponent(
        'Hello! Join the MyNearby delivery fleet in ${PartnerConstants.defaultCity} with daily payouts & flexible hours. Download Driver App: ${PartnerConstants.deliveryApkUrl}');
    final uri = Uri.parse('https://wa.me/$cleanPhone?text=$msg');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
