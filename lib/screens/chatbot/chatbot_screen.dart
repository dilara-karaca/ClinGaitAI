import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text:
          'Merhaba! 👋 Ben ClinGait AI asistanınızım. Size egzersizleriniz, ilaçlarınız veya tedavi süreciniz hakkında yardımcı olabilirim. Sormak istediğiniz bir şey var mı?',
      isBot: true,
      time: '09:00',
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text: text, isBot: false, time: '09:15'));
      _messageController.clear();

      // Simüle edilmiş bot yanıtı
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          setState(() {
            _messages.add(
              _ChatMessage(
                text: _getBotResponse(text),
                isBot: true,
                time: '09:15',
              ),
            );
          });
        }
      });
    });
  }

  String _getBotResponse(String input) {
    final lower = input.toLowerCase();
    if (lower.contains('egzersiz')) {
      return 'Bugün 4 egzersiziniz var. 2 tanesini tamamladınız. Sıradaki egzersiz: Topuk Kaldırma (3 set x 12 tekrar). Başlamak ister misiniz?';
    } else if (lower.contains('ilaç') || lower.contains('ilac')) {
      return 'Bugünkü ilaçlarınız:\n• Vitamin D3 - 1000 IU (✓ Alındı)\n• Kalsiyum - 500 mg (⏳ Bekliyor)\n• Omega-3 - 1000 mg (✓ Alındı)';
    } else if (lower.contains('randevu')) {
      return 'Bir sonraki randevunuz 15 Mart 2026, Pazar günü saat 14:00\'te Dr. Mehmet Yılmaz ile. Hatırlatıcı ayarlamak ister misiniz?';
    } else if (lower.contains('nasıl') || lower.contains('nasil')) {
      return 'Genel durumunuz iyi görünüyor! Bu hafta egzersiz tamamlama oranınız %65, adım simetriniz %92. Doktorunuz geçen hafta pozitif gelişme not etmiştir. 💪';
    } else {
      return 'Anlıyorum. Size egzersizleriniz, ilaçlarınız, randevularınız veya genel durumunuz hakkında bilgi verebilirim. Ne öğrenmek istersiniz?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Üst bar
            _buildChatHeader(),
            // Mesajlar
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageBubble(_messages[index]);
                },
              ),
            ),
            // Hızlı sorular
            _buildQuickActions(),
            // Mesaj girişi
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.smart_toy_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ClinGait Asistan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 2),
              Row(
                children: [
                  CircleAvatar(radius: 4, backgroundColor: AppColors.success),
                  SizedBox(width: 6),
                  Text(
                    'Çevrimiçi',
                    style: TextStyle(fontSize: 12, color: AppColors.success),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(_ChatMessage message) {
    return Align(
      alignment: message.isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        decoration: BoxDecoration(
          color: message.isBot ? AppColors.surface : AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(message.isBot ? 4 : 18),
            bottomRight: Radius.circular(message.isBot ? 18 : 4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                fontSize: 14,
                color: message.isBot ? AppColors.textPrimary : Colors.white,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                message.time,
                style: TextStyle(
                  fontSize: 10,
                  color:
                      message.isBot
                          ? AppColors.textLight
                          : Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    final quickQuestions = [
      'Egzersizlerim',
      'İlaçlarım',
      'Randevum',
      'Nasılım?',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              quickQuestions.map((q) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(
                      q,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    backgroundColor: AppColors.primary.withValues(alpha: 0.08),
                    side: BorderSide(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      _messageController.text = q;
                      _sendMessage();
                    },
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.sageGreenLight, width: 1),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Mesajınızı yazın...',
                  hintStyle: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 14,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryLight],
                ),
                borderRadius: BorderRadius.circular(23),
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isBot;
  final String time;

  _ChatMessage({required this.text, required this.isBot, required this.time});
}
