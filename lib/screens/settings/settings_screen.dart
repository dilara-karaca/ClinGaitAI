import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool medicationReminders = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Ayarlar'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SectionCard(
            title: 'Bildirimler',
            children: [
              SwitchListTile(
                value: notificationsEnabled,
                onChanged:
                    (value) => setState(() => notificationsEnabled = value),
                title: const Text('Genel bildirimler'),
                subtitle: const Text('Uygulama uyarılarını aç veya kapat'),
              ),
              SwitchListTile(
                value: medicationReminders,
                onChanged:
                    (value) => setState(() => medicationReminders = value),
                title: const Text('İlaç hatırlatmaları'),
                subtitle: const Text('İlaç saatlerinde bildirim göster'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Görünüm',
            children: [
              SwitchListTile(
                value: darkMode,
                onChanged: (value) => setState(() => darkMode = value),
                title: const Text('Koyu tema'),
                subtitle: const Text('Tema tercihini değiştir'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Uygulama',
            children: [
              ListTile(
                leading: const Icon(Icons.language_outlined),
                title: const Text('Dil'),
                subtitle: const Text('Türkçe'),
                trailing: const Icon(Icons.chevron_right),
                onTap:
                    () => _showDialog(
                      context,
                      'Dil',
                      'Dil ayarları burada değiştirilebilir.',
                    ),
              ),
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: const Text('Gizlilik ve güvenlik'),
                subtitle: const Text('Parola ve oturum ayarları'),
                trailing: const Icon(Icons.chevron_right),
                onTap:
                    () => _showDialog(
                      context,
                      'Gizlilik ve güvenlik',
                      'Parola değişimi, oturum yönetimi ve izinler burada bulunabilir.',
                    ),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('Uygulama hakkında'),
                subtitle: const Text('Sürüm ve yasal bilgiler'),
                trailing: const Icon(Icons.chevron_right),
                onTap:
                    () => _showDialog(
                      context,
                      'Uygulama hakkında',
                      'ClinGait AI sürüm bilgileri ve yasal metinler burada yer alabilir.',
                    ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: 'Hesap',
            children: [
              ListTile(
                leading: const Icon(Icons.logout, color: AppColors.error),
                title: const Text('Çıkış yap'),
                subtitle: const Text('Oturumu sonlandır'),
                trailing: const Icon(Icons.chevron_right),
                onTap:
                    () => _showDialog(
                      context,
                      'Çıkış yap',
                      'Çıkış işlemi burada onaylatılabilir.',
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

void _showDialog(BuildContext context, String title, String message) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kapat'),
          ),
        ],
      );
    },
  );
}
