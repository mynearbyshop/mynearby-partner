import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/partner_theme.dart';
import '../models/partner_models.dart';
import '../providers/partner_provider.dart';

class PartnerAiScreen extends StatefulWidget {
  const PartnerAiScreen({super.key});

  @override
  State<PartnerAiScreen> createState() => _PartnerAiScreenState();
}

class _PartnerAiScreenState extends State<PartnerAiScreen> {
  final _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(PartnerProvider provider) {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    _messageController.clear();
    provider.sendMessage(text);
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PartnerProvider>();

    return Scaffold(
      backgroundColor: PartnerTheme.background,
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Partner AI Assistant', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900)),
            Text('Autonomous Franchise Strategy & Ledger Assistant', style: TextStyle(fontSize: 10.5, color: PartnerTheme.primaryGold)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: provider.chatMessages.length,
              itemBuilder: (context, index) {
                final msg = provider.chatMessages[index];
                return _buildChatBubble(msg);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PartnerTheme.surfaceCard,
              border: Border(top: BorderSide(color: PartnerTheme.border)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(fontSize: 13, color: PartnerTheme.textPrimary),
                      decoration: InputDecoration(
                        hintText: 'Ask Partner AI about commissions, store verification...',
                        hintStyle: const TextStyle(fontSize: 11.5, color: PartnerTheme.textMuted),
                        filled: true,
                        fillColor: PartnerTheme.surfaceElevated,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                      ),
                      onSubmitted: (_) => _sendMessage(provider),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: () => _sendMessage(provider),
                    icon: const Icon(Icons.send_rounded, size: 18),
                    style: IconButton.styleFrom(backgroundColor: PartnerTheme.primaryGold, foregroundColor: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(PartnerChatMessageModel msg) {
    if (msg.isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12, left: 40),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: PartnerTheme.primaryGold.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: PartnerTheme.primaryGold.withValues(alpha: 0.4)),
          ),
          child: Text(msg.text, style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600)),
        ),
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12, right: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: PartnerTheme.primaryGold.withValues(alpha: 0.2), shape: BoxShape.circle),
              child: const Icon(Icons.smart_toy_rounded, size: 18, color: PartnerTheme.primaryGold),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: PartnerTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: PartnerTheme.border),
                ),
                child: Text(msg.text, style: const TextStyle(fontSize: 12.5, color: PartnerTheme.textPrimary, height: 1.45)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
