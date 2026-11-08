import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/partner_theme.dart';
import 'providers/partner_provider.dart';
import 'screens/partner_shell_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyNearbyPartnerApp());
}

class MyNearbyPartnerApp extends StatelessWidget {
  const MyNearbyPartnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PartnerProvider()),
      ],
      child: MaterialApp(
        title: 'MyNearby Partner',
        debugShowCheckedModeBanner: false,
        theme: PartnerTheme.darkTheme,
        home: const PartnerShellScreen(),
      ),
    );
  }
}
