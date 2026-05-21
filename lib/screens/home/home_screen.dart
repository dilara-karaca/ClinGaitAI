import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';
import '../../app_strings.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: HomeBody());
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late final List<_MedItem> _medications = [
    _MedItem(
      'Vitamin D3',
      '1000 IU',
      'Sabah',
      Icons.wb_sunny,
      AppColors.secondary,
      true,
      'Kemik sağlığını güçlendirir ve bağışıklık sistemini destekler.',
      'Günde 1 kere (Sabah tok karnına)',
    ),
    _MedItem(
      'Kalsiyum',
      '500 mg',
      'Öğle',
      Icons.medication_outlined,
      AppColors.primary,
      false,
      'Kemik yoğunluğunu artırır, kas fonksiyonlarına yardımcı olur.',
      'Günde 1 kere (Öğle)',
    ),
    _MedItem(
      'Omega-3',
      '1000 mg',
      'Akşam',
      Icons.water_drop_outlined,
      AppColors.mintGreen,
      false,
      'Kalp ve beyin sağlığını korur, iltihaplanmayı azaltır.',
      'Günde 1 kere (Akşam tok karnına)',
    ),
    _MedItem(
      'Magnezyum',
      '250 mg',
      'Gece',
      Icons.nightlight_round,
      AppColors.sageGreen,
      false,
      'Kas kramplarını önler ve daha kaliteli bir uyku sağlar.',
      'Günde 1 kere (Gece yatmadan önce)',
    ),
  ];

  void _handleProfileMenuAction(_ProfileMenuAction action) {
    switch (action) {
      case _ProfileMenuAction.profile:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
        break;
      case _ProfileMenuAction.settings:
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: const [
    Text(
      'Merhaba Dilara',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    ),
    SizedBox(height: 4),
    Text(
      'Günün nasıl geçiyor?',
      style: TextStyle(
        fontSize: 13,
        color: AppColors.textSecondary,
      ),
    ),
  ],
), // Column
              Row(
                children: [
                  _buildConnectionIndicator(),
                  const SizedBox(width: 10),
                  _buildNotificationBadge(context),
                  const SizedBox(width: 12),
                  PopupMenuButton<_ProfileMenuAction>(
                    onSelected: (action) => _handleProfileMenuAction(action),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    offset: const Offset(0, 50),
                    itemBuilder:
                        (context) => const [
                          PopupMenuItem(
                            value: _ProfileMenuAction.profile,
                            child: Row(
                              children: [
                                Icon(Icons.person_outline, size: 20),
                                SizedBox(width: 10),
                                Text('Profil'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: _ProfileMenuAction.settings,
                            child: Row(
                              children: [
                                Icon(Icons.settings_outlined, size: 20),
                                SizedBox(width: 10),
                                Text('Ayarlar'),
                              ],
                            ),
                          ),
                        ],
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.primaryLight.withOpacity(0.2),
                      child: const Icon(
                        Icons.person,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildStreakCard(),
          const SizedBox(height: 16),

        _buildSectionTitle(AppStrings.get('meds'), Icons.medication_outlined),
          const SizedBox(height: 12),
          _buildMedicationsForDay(),
          const SizedBox(height: 16),

          _buildSectionTitle(AppStrings.get('appointments'), Icons.calendar_today),
          const SizedBox(height: 12),
          _buildAppointments(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildNotificationBadge(BuildContext context) {
    return GestureDetector(
      onTap: () => _showNotifications(context),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: AppColors.textSecondary,
              size: 24,
            ),
          ),
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bildirimler',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                _buildNotificationItem(
                  icon: Icons.medication_outlined,
                  title: 'İlaç hatırlatması',
                  subtitle: 'Akşam ilacını 20:00\'de almayı unutma.',
                ),
                const SizedBox(height: 12),
                _buildNotificationItem(
                  icon: Icons.directions_run,
                  title: 'Egzersiz zamanı',
                  subtitle: 'Bugünkü egzersizini tamamlayabilirsin.',
                ),
                const SizedBox(height: 12),
                _buildNotificationItem(
                  icon: Icons.calendar_month,
                  title: 'Randevu yaklaşımı',
                  subtitle: 'Yarın 14:30\'da kontrol randevun var.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.sageGreenLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionIndicator() {
    const bool isConnected = true;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        isConnected ? Icons.bluetooth_connected : Icons.bluetooth_disabled,
        color: isConnected ? AppColors.success : AppColors.error,
        size: 24,
      ),
    );
  }

  Widget _buildStreakCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.local_fire_department_rounded,
                  color: AppColors.mintGreen,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [ // const kelimesi yok
    Text(
      AppStrings.get('streak_title'), // Eski '12 Günlük Seri' yerine
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
    const SizedBox(height: 4),
    Text(
      AppStrings.get('streak_sub'), // Eski 'Mükemmel gidiyorsun! 🔥' yerine
      style: TextStyle(
        color: Colors.white.withOpacity(0.8),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    ),
  ],
), // Column
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final isCompleted = i < 5;
              final isToday = i == 5;
              const dayLabels = [
                'Pzt',
                'Sal',
                'Çar',
                'Per',
                'Cum',
                'Cmt',
                'Paz',
              ];

              return Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: isCompleted
                          ? const LinearGradient(
                              colors: AppColors.greenGradient,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                          : null,
                      color: isCompleted
                          ? null
                          : isToday
                          ? const Color(0xFF00E5FF)
                          : AppColors.sageGreen.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border:
                          isToday
                              ? Border.all(color: Colors.white, width: 2)
                              : null,
                    ),
                    child:
                        isCompleted
                            ? const Icon(
                              Icons.check,
                              size: 18,
                              color: Colors.white,
                            )
                            : null,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    dayLabels[i],
                    style: TextStyle(
                      color:
                          isToday
                              ? Colors.white
                              : Colors.white.withOpacity(0.6),
                      fontSize: 12,
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 22),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildMedicationsForDay() {
    return Column(children: _medications.map(_buildMedicationCard).toList());
  }

  Widget _buildMedicationCard(_MedItem medication) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: medication.isTaken ? null : AppColors.surface,
        gradient: medication.isTaken
            ? const LinearGradient(
                colors: AppColors.greenGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(14),
        border: medication.isTaken
            ? null
            : Border.all(color: AppColors.sageGreenLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _showMedicationDetails(medication),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: medication.isTaken
                      ? Colors.white.withOpacity(0.2)
                      : medication.color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  medication.icon,
                  color: medication.isTaken ? Colors.white : medication.color,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medication.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: medication.isTaken ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${medication.dosage} • ${medication.time}',
                      style: TextStyle(
                        fontSize: 12,
                        color: medication.isTaken
                            ? Colors.white.withOpacity(0.8)
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => _showMedicationDetails(medication),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: medication.isTaken
                        ? Colors.white.withOpacity(0.2)
                        : AppColors.sageGreenLight,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    medication.isTaken
                        ? Icons.check_circle
                        : Icons.arrow_forward_ios,
                    color: medication.isTaken ? Colors.white : AppColors.textLight,
                    size: medication.isTaken ? 20 : 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMedicationDetails(_MedItem medication) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.textLight.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    medication.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${medication.dosage} • ${medication.time}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            medication.description,
                            style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailTile(
                    'Durum',
                    medication.isTaken ? 'Alındı' : 'Bekliyor',
                  ),
                  const SizedBox(height: 10),
                  _buildDetailTile('Kullanım', medication.frequency),
                  const SizedBox(height: 10),
                  _buildDetailTile('Saat', medication.time),
                  const SizedBox(height: 10),
                  _buildDetailTile('Doz', medication.dosage),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          medication.isTaken = true;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Alındı Olarak İşaretle'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppointments() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.14),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.event_note_outlined,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'Yaklaşan Randevular',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildAppointmentDetailRow('Hekim', 'Dr. Ayşe Demir'),
          const SizedBox(height: 10),
          _buildAppointmentDetailRow('Klinik', 'Ortopedi'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 42,
            child: ElevatedButton(
              onPressed: _showAppointmentDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Randevu Detayları',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAppointmentDetails() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.textLight.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Randevu Detayları',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailTile('Hekim', 'Dr. Ayşe Demir'),
                  const SizedBox(height: 10),
                  _buildDetailTile('Klinik', 'Ortopedi'),
                  const SizedBox(height: 10),
                  _buildDetailTile('Tarih', '15 Mart 2026'),
                  const SizedBox(height: 10),
                  _buildDetailTile('Saat', '14:30'),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Kapat'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailTile(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.sageGreenLight,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 76,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentDetailRow(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _MedItem {
  final String name, dosage, time, description, frequency;
  final IconData icon;
  final Color color;
  bool isTaken;

  _MedItem(
    this.name,
    this.dosage,
    this.time,
    this.icon,
    this.color,
    this.isTaken,
    this.description,
    this.frequency,
  );
}

enum _ProfileMenuAction { profile, settings }
