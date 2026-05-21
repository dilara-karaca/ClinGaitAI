import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../app_strings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool medicationReminders = true;
  bool darkMode = false;

  // Dil seçim penceresini (BottomSheet) açan sihirli fonksiyonumuz
  void _openLanguageMenu() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Text(
                'Dil Seçimi / Language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // 🇹🇷 Türkçe Seçeneği
              ListTile(
                leading: const Text('🇹🇷', style: TextStyle(fontSize: 24)),
                title: const Text('Türkçe', style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: AppStrings.currentLanguage == 'tr' ? const Icon(Icons.check, color: AppColors.mintGreen) : null,
                onTap: () {
                  setState(() {
                    AppStrings.currentLanguage = 'tr';
                  });
                  Navigator.pop(context);
                },
              ),
              const Divider(),

              // 🇬🇧 İngilizce Seçeneği (Tamamen Aktif)
              ListTile(
                leading: const Text('🇬🇧', style: TextStyle(fontSize: 24)),
                title: const Text('English', style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: AppStrings.currentLanguage == 'en' ? const Icon(Icons.check, color: AppColors.mintGreen) : null,
                onTap: () {
                  setState(() {
                    AppStrings.currentLanguage = 'en';
                  });
                  Navigator.pop(context);
                },
              ),
              const Divider(),

              // 🇸🇦 Arapça Seçeneği (Sadece buton olarak duruyor - Tam senin istediğin gibi)
              ListTile(
                leading: const Text('🇸🇦', style: TextStyle(fontSize: 24)),
                title: const Text('العربية (Yakında)', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
                onTap: () {
                  // Fuarda vizyon göstermek için boş bıraktık, basılınca hata vermez
                },
              ),
            ],
          ),
        );
      },
    ).then((_) => setState(() {})); // Pencere kapandığında Ayarlar sayfasını anında İngilizceye uçurur
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(AppStrings.get('settings')), // Dinamik Türkçe/İngilizce başlık
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SectionCard(
            title: AppStrings.get('notifications'),
            children: [
              SwitchListTile(
                value: notificationsEnabled,
                onChanged: (value) => setState(() => notificationsEnabled = value),
                title: Text(AppStrings.get('general_notif')),
                subtitle: Text(AppStrings.get('general_notif_sub')),
              ),
              SwitchListTile(
                value: medicationReminders,
                onChanged: (value) => setState(() => medicationReminders = value),
                title: Text(AppStrings.get('med_reminders')),
                subtitle: Text(AppStrings.get('med_reminders_sub')),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: AppStrings.get('appearance'),
            children: [
              SwitchListTile(
                value: darkMode,
                onChanged: (value) => setState(() => darkMode = value),
                title: Text(AppStrings.get('dark_mode')),
                subtitle: Text(AppStrings.get('dark_mode_sub')),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: AppStrings.get('app'),
            children: [
              ListTile(
                leading: const Icon(Icons.language_outlined),
                title: Text(AppStrings.get('language')),
                subtitle: Text(AppStrings.currentLanguage == 'tr' ? 'Türkçe' : 'English'),
                trailing: const Icon(Icons.chevron_right),
                onTap: _openLanguageMenu, // Dil seçme menüsünü tetikler
              ),
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: Text(AppStrings.get('privacy')),
                subtitle: Text(AppStrings.get('privacy_sub')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showDialog(
                  context,
                  AppStrings.get('privacy'),
                  'Parola değişimi, oturum yönetimi ve izinler burada bulunabilir.',
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(AppStrings.get('about')),
                subtitle: Text(AppStrings.get('about_sub')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showDialog(
                  context,
                  AppStrings.get('about'),
                  'ClinGait AI sürüm bilgileri ve yasal metinler burada yer alabilir.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SectionCard(
            title: AppStrings.get('account'),
            children: [
              ListTile(
                leading: const Icon(Icons.logout, color: AppColors.error),
                title: Text(AppStrings.get('logout')),
                subtitle: Text(AppStrings.get('logout_sub')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showDialog(
                  context,
                  AppStrings.get('logout'),
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