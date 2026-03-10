import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

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
  // Takvimde seçili gün (bugün)
  DateTime _selectedDate = DateTime(2026, 3, 10);
  final DateTime _today = DateTime(2026, 3, 10);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildGreetingSection(context),
            const SizedBox(height: 20),
            // Streak kartı (tam genişlik)
            _buildStreakCard(),
            const SizedBox(height: 20),
            // Takvim
            _buildCalendarSection(),
            const SizedBox(height: 20),
            // Seçili güne ait İlaçlar
            _buildSectionTitle('İlaçlarım', Icons.medication_outlined),
            const SizedBox(height: 12),
            _buildMedicationsForDay(),
            const SizedBox(height: 20),
            // Seçili güne ait Hareketlerim/Egzersizler
            _buildSectionTitle('Egzersizlerim', Icons.directions_run),
            const SizedBox(height: 12),
            _buildExercisesForDay(),
            const SizedBox(height: 20),
            // Randevular
            _buildSectionTitle('Randevularım', Icons.calendar_month),
            const SizedBox(height: 12),
            _buildAppointments(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  // ─── KARŞILAMA ────────────────────────────────────
  Widget _buildGreetingSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Merhaba 👋',
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 4),
            const Text(
              'Ayşe',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _buildConnectionIndicator(),
            const SizedBox(width: 10),
            _buildNotificationBadge(),
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
              child: const Icon(
                Icons.person,
                color: AppColors.primary,
                size: 28,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationBadge() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
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
          right: 8,
          top: 8,
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
    );
  }

  // ─── BAĞLANTI GÖSTERGESİ ─────────────────────────
  Widget _buildConnectionIndicator() {
    // ignore: dead_code
    final bool isConnected = true;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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

  // ─── STREAK ───────────────────────────────────────
  Widget _buildStreakCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.local_fire_department_rounded,
                      color: AppColors.accent,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '12 Günlük Seri',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Mükemmel gidiyorsun! 🔥',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Haftalık ilerleme
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final isCompleted = i < 5;
              final isToday = i == 5;
              final dayLabels = [
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
                      color:
                          isCompleted
                              ? AppColors.accent
                              : isToday
                              ? Colors.white.withValues(alpha: 0.3)
                              : Colors.white.withValues(alpha: 0.1),
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
                              : Colors.white.withValues(alpha: 0.6),
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

  // ─── TAKVİM ───────────────────────────────────────
  Widget _buildCalendarSection() {
    // Haftanın günlerini göster (bu hafta)
    final weekStart = _today.subtract(Duration(days: _today.weekday - 1));
    final days = List.generate(7, (i) => weekStart.add(Duration(days: i)));
    final dayNames = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Ay başlığı
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mart 2026',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.chevron_left,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.chevron_right,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Gün satırı
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (i) {
              final day = days[i];
              final isSelected =
                  day.day == _selectedDate.day &&
                  day.month == _selectedDate.month;
              final isToday =
                  day.day == _today.day && day.month == _today.month;

              // Günlere göre ilaç/egzersiz işaretleri
              final hasActivity = day.day <= 10; // demo: 10'a kadar aktif

              return GestureDetector(
                onTap: () => setState(() => _selectedDate = day),
                child: Column(
                  children: [
                    Text(
                      dayNames[i],
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            isSelected
                                ? AppColors.primary
                                : AppColors.textLight,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.primary
                                : isToday
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                                isSelected || isToday
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                isSelected
                                    ? Colors.white
                                    : isToday
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Alt noktalar (ilaç: mavi, egzersiz: yeşil)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (hasActivity)
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: const BoxDecoration(
                              color: AppColors.chartBlue,
                              shape: BoxShape.circle,
                            ),
                          ),
                        if (hasActivity)
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: const BoxDecoration(
                              color: AppColors.chartGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          // Lejant
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.chartBlue,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'İlaç',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
              const SizedBox(width: 16),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.chartGreen,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'Egzersiz',
                style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── SEKSİYON BAŞLIĞI ─────────────────────────────
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

  // ─── İLAÇLAR ─────────────────────────────────────
  Widget _buildMedicationsForDay() {
    final medications = [
      _MedItem(
        'Vitamin D3',
        '1000 IU',
        'Sabah',
        Icons.wb_sunny,
        AppColors.chartOrange,
        true,
      ),
      _MedItem(
        'Kalsiyum',
        '500 mg',
        'Öğle',
        Icons.medication_outlined,
        AppColors.chartBlue,
        false,
      ),
      _MedItem(
        'Omega-3',
        '1000 mg',
        'Akşam',
        Icons.water_drop_outlined,
        AppColors.chartGreen,
        false,
      ),
    ];

    return Column(
      children:
          medications.map((m) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
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
                      color: m.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(m.icon, color: m.color, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          m.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${m.dosage} • ${m.time}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color:
                          m.isTaken
                              ? AppColors.success.withValues(alpha: 0.12)
                              : AppColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      m.isTaken ? Icons.check_circle : Icons.circle_outlined,
                      color:
                          m.isTaken ? AppColors.success : AppColors.textLight,
                      size: 20,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  // ─── HAREKETLERİM / EGZERSİZLER ──────────────────
  Widget _buildExercisesForDay() {
    final exercises = [
      _ExItem(
        'Ayak Bileği Rotasyonu',
        '3 set x 15 tekrar',
        '10 dk',
        Icons.rotate_right,
        AppColors.chartBlue,
        true,
      ),
      _ExItem(
        'Parmak Ucu Yürüyüşü',
        '2 set x 20 adım',
        '5 dk',
        Icons.directions_walk,
        AppColors.chartGreen,
        true,
      ),
      _ExItem(
        'Topuk Kaldırma',
        '3 set x 12 tekrar',
        '8 dk',
        Icons.height,
        AppColors.chartOrange,
        false,
      ),
      _ExItem(
        'Denge Egzersizi',
        '2 set x 30 sn',
        '10 dk',
        Icons.accessibility_new,
        AppColors.chartPurple,
        false,
      ),
    ];

    return Column(
      children:
          exercises.map((e) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
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
                      color: e.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(e.icon, color: e.color, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            decoration:
                                e.isDone ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${e.sets} • ${e.duration}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color:
                          e.isDone
                              ? AppColors.success.withValues(alpha: 0.12)
                              : AppColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      e.isDone ? Icons.check_circle : Icons.circle_outlined,
                      color: e.isDone ? AppColors.success : AppColors.textLight,
                      size: 20,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  // ─── RANDEVULAR ───────────────────────────────────
  Widget _buildAppointments() {
    final appointments = [
      _AppointmentData(
        doctor: 'Dr. Mehmet Yılmaz',
        specialty: 'Çocuk Ortopedi',
        date: '15 Mart 2026',
        time: '14:00',
        isUpcoming: true,
      ),
      _AppointmentData(
        doctor: 'Fzt. Elif Demir',
        specialty: 'Fizyoterapi',
        date: '20 Mart 2026',
        time: '10:30',
        isUpcoming: true,
      ),
      _AppointmentData(
        doctor: 'Dr. Mehmet Yılmaz',
        specialty: 'Kontrol',
        date: '5 Mart 2026',
        time: '11:00',
        isUpcoming: false,
      ),
    ];

    return Column(
      children:
          appointments.map((a) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border:
                    a.isUpcoming
                        ? Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          width: 1,
                        )
                        : null,
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
                  // Tarih kutusu
                  Container(
                    width: 52,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color:
                          a.isUpcoming
                              ? AppColors.primary.withValues(alpha: 0.1)
                              : AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(
                          a.date.split(' ')[0],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:
                                a.isUpcoming
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          a.date.split(' ')[1],
                          style: TextStyle(
                            fontSize: 11,
                            color:
                                a.isUpcoming
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a.doctor,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          a.specialty,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 14,
                              color: AppColors.textLight,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              a.time,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Durum badge'i
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color:
                          a.isUpcoming
                              ? AppColors.primary.withValues(alpha: 0.1)
                              : AppColors.success.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      a.isUpcoming ? 'Yaklaşan' : 'Tamamlandı',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color:
                            a.isUpcoming
                                ? AppColors.primary
                                : AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }
}

// ─── VERİ MODELLERİ ──────────────────────────────────
class _MedItem {
  final String name, dosage, time;
  final IconData icon;
  final Color color;
  final bool isTaken;
  _MedItem(
    this.name,
    this.dosage,
    this.time,
    this.icon,
    this.color,
    this.isTaken,
  );
}

class _ExItem {
  final String title, sets, duration;
  final IconData icon;
  final Color color;
  final bool isDone;
  _ExItem(
    this.title,
    this.sets,
    this.duration,
    this.icon,
    this.color,
    this.isDone,
  );
}

class _AppointmentData {
  final String doctor, specialty, date, time;
  final bool isUpcoming;
  _AppointmentData({
    required this.doctor,
    required this.specialty,
    required this.date,
    required this.time,
    required this.isUpcoming,
  });
}
