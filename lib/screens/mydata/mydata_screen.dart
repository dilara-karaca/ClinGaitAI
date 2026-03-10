import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class MyDataScreen extends StatelessWidget {
  const MyDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Verilerim & İlaçlarım',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 24),

              // Sensör Verileri
              _buildSectionHeader('Sensör Verileri'),
              const SizedBox(height: 12),
              _buildSensorDataCards(),
              const SizedBox(height: 24),

              // İlaçlarım
              _buildSectionHeader('İlaçlarım'),
              const SizedBox(height: 12),
              _buildMedicationsList(),
              const SizedBox(height: 24),

              // Ölçüm Geçmişi
              _buildSectionHeader('Ölçüm Geçmişi'),
              const SizedBox(height: 12),
              _buildMeasurementHistory(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildSensorDataCards() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        _buildDataCard(
          'Basınç Dağılımı',
          'Normal',
          Icons.grid_on,
          AppColors.chartBlue,
          '↑ %5 iyileşme',
        ),
        _buildDataCard(
          'Pronasyon',
          'Hafif',
          Icons.swap_horiz,
          AppColors.chartOrange,
          'Kontrol altında',
        ),
        _buildDataCard(
          'Adım Simetrisi',
          '%92',
          Icons.balance,
          AppColors.chartGreen,
          '↑ %3 iyileşme',
        ),
        _buildDataCard(
          'Tibia Rotasyonu',
          '8.2°',
          Icons.rotate_90_degrees_ccw,
          AppColors.chartPurple,
          'Normal aralıkta',
        ),
      ],
    );
  }

  Widget _buildDataCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String trend,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 22),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            trend,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationsList() {
    final medications = [
      _MedicationData(
        'Vitamin D3',
        '1000 IU',
        'Günde 1 kez',
        Icons.wb_sunny,
        AppColors.chartOrange,
        true,
      ),
      _MedicationData(
        'Kalsiyum',
        '500 mg',
        'Günde 2 kez',
        Icons.medication_outlined,
        AppColors.chartBlue,
        false,
      ),
      _MedicationData(
        'Omega-3',
        '1000 mg',
        'Günde 1 kez',
        Icons.water_drop_outlined,
        AppColors.chartGreen,
        true,
      ),
    ];

    return Column(
      children: medications.map((m) => _buildMedicationCard(m)).toList(),
    );
  }

  Widget _buildMedicationCard(_MedicationData med) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: med.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(med.icon, color: med.color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  med.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${med.dosage} • ${med.frequency}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color:
                  med.isTaken
                      ? AppColors.success.withValues(alpha: 0.12)
                      : AppColors.background,
              shape: BoxShape.circle,
            ),
            child: Icon(
              med.isTaken ? Icons.check_circle : Icons.circle_outlined,
              color: med.isTaken ? AppColors.success : AppColors.textLight,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementHistory() {
    final measurements = [
      {'date': '10 Mart', 'type': 'Yürüyüş Analizi', 'status': 'Tamamlandı'},
      {'date': '8 Mart', 'type': 'Basınç Ölçümü', 'status': 'Tamamlandı'},
      {'date': '5 Mart', 'type': 'Diz Biyomekaniği', 'status': 'Tamamlandı'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children:
            measurements.asMap().entries.map((entry) {
              final i = entry.key;
              final m = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.assessment_outlined,
                        color: AppColors.primary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      m['type']!,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      m['date']!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        m['status']!,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ),
                  if (i < measurements.length - 1)
                    const Divider(height: 1, indent: 72),
                ],
              );
            }).toList(),
      ),
    );
  }
}

class _MedicationData {
  final String name;
  final String dosage;
  final String frequency;
  final IconData icon;
  final Color color;
  final bool isTaken;

  _MedicationData(
    this.name,
    this.dosage,
    this.frequency,
    this.icon,
    this.color,
    this.isTaken,
  );
}
