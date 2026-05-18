import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class MyDataScreen extends StatefulWidget {
  const MyDataScreen({super.key});

  @override
  State<MyDataScreen> createState() => _MyDataScreenState();
}

class _MyDataScreenState extends State<MyDataScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildStatusCard(),
                    const SizedBox(height: 14),
                    _buildTabBar(),
                    const SizedBox(height: 14),
                    _buildTabContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.chartBlue, AppColors.primary],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Pediatrik Yürüyüş Analizi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Ahmet Yılmaz • 8 yaş',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text(
              'AY',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
              const Text(
                'Güncel Durum',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  'Son Ölçüm: Bugün',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.75,
            children: const [
              _MetricCard(
                title: 'Yürüyüş Skoru',
                value: '76/100',
                subtitle: '↑ İyileşiyor',
                valueColor: AppColors.primary,
                accentColor: AppColors.chartBlue,
              ),
              _MetricCard(
                title: 'Sağ Pronasyon',
                value: '-8.2°',
                subtitle: '↓ Dikkat',
                valueColor: AppColors.error,
                accentColor: AppColors.warning,
              ),
              _MetricCard(
                title: 'Sol Pronasyon',
                value: '-3.1°',
                subtitle: '✓ Normal',
                valueColor: AppColors.success,
                accentColor: AppColors.success,
              ),
              _MetricCard(
                title: 'Tibia Rotasyon',
                value: '12.4°',
                subtitle: '✓ Normal',
                valueColor: AppColors.primary,
                accentColor: AppColors.chartBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    final tabs = ['Aktivite', 'Analiz', 'Raporlar'];

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.background : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  tabs[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color:
                        isSelected
                            ? AppColors.textPrimary
                            : AppColors.textLight,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTab) {
      case 1:
        return _buildAnalysisContent();
      case 2:
        return _buildReportsContent();
      case 0:
      default:
        return Column(
          children: [
            _buildChartCard(),
            const SizedBox(height: 14),
            _buildSummaryCards(),
          ],
        );
    }
  }

  Widget _buildChartCard() {
    final bars = [
      _BarData('Pzt', 0.68),
      _BarData('Sal', 0.78),
      _BarData('Çar', 0.64),
      _BarData('Per', 0.91),
      _BarData('Cum', 0.84),
      _BarData('Cmt', 0.63),
      _BarData('Paz', 0.37),
    ];

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Haftalık Adım Sayısı',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(height: 180, child: _MiniBarChart(bars: bars)),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: const [
        Expanded(
          child: _SmallStatCard(
            title: 'Bu Hafta',
            value: '46,889',
            subtitle: 'toplam adım',
            icon: Icons.directions_walk,
            accentColor: AppColors.chartBlue,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _SmallStatCard(
            title: 'Ortalama',
            value: '6,698',
            subtitle: 'adım/gün',
            icon: Icons.show_chart,
            accentColor: AppColors.success,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysisContent() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pronasyon Trendi',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Son 4 haftalık ölçümler',
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 240,
            child: CustomPaint(
              painter: _PronationTrendPainter(),
              child: const SizedBox.expand(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsContent() {
    final reports = [
      _ReportItem(
        title: 'Aylık Rapor',
        date: '05 Şubat 2026',
        subtitle: 'İyileşme görülüyor',
        doctor: 'Hekim: Dr. Ayşe Demir',
      ),
      _ReportItem(
        title: 'Aylık Rapor',
        date: '05 Ocak 2026',
        subtitle: 'Tedaviye devam',
        doctor: 'Hekim: Dr. Ayşe Demir',
      ),
      _ReportItem(
        title: 'İlk Değerlendirme',
        date: '15 Aralık 2025',
        subtitle: 'Düz taban teşhisi',
        doctor: 'Hekim: Dr. Ayşe Demir',
      ),
    ];

    return Column(
      children: [
        ...reports.map(
          (report) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _ReportCard(item: report),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.18),
            ),
          ),
          child: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download_outlined),
            label: const Text(
              'Tüm Raporları İndir',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color valueColor;
  final Color accentColor;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.valueColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.background),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color accentColor;

  const _SmallStatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: accentColor),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportItem {
  final String title;
  final String date;
  final String subtitle;
  final String doctor;

  const _ReportItem({
    required this.title,
    required this.date,
    required this.subtitle,
    required this.doctor,
  });
}

class _ReportCard extends StatelessWidget {
  final _ReportItem item;

  const _ReportCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        item.date,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.doctor,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.chevron_right, color: AppColors.textLight),
        ],
      ),
    );
  }
}

class _PronationTrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint =
        Paint()
          ..color = AppColors.textLight.withValues(alpha: 0.16)
          ..strokeWidth = 1;

    final tealPaint =
        Paint()
          ..color = AppColors.primaryLight
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;

    final bluePaint =
        Paint()
          ..color = AppColors.chartBlue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;

    final tealFill =
        Paint()
          ..color = AppColors.primaryLight
          ..style = PaintingStyle.fill;

    final blueFill =
        Paint()
          ..color = AppColors.chartBlue
          ..style = PaintingStyle.fill;

    const left = 38.0;
    const top = 16.0;
    const right = 8.0;
    const bottom = 28.0;
    final width = size.width - left - right;
    final height = size.height - top - bottom;

    for (var i = 0; i <= 4; i++) {
      final y = top + (height / 4) * i;
      canvas.drawLine(
        Offset(left, y),
        Offset(size.width - right, y),
        gridPaint,
      );
    }

    for (var i = 0; i < 4; i++) {
      final x = left + (width / 3) * i;
      canvas.drawLine(Offset(x, top), Offset(x, top + height), gridPaint);
    }

    final labels = ['1. Hafta', '2. Hafta', '3. Hafta', '4. Hafta'];
    final tealPoints = [
      Offset(left + 0 * width / 3, top + height * 0.22),
      Offset(left + 1 * width / 3, top + height * 0.20),
      Offset(left + 2 * width / 3, top + height * 0.18),
      Offset(left + 3 * width / 3, top + height * 0.17),
    ];
    final bluePoints = [
      Offset(left + 0 * width / 3, top + height * 0.86),
      Offset(left + 1 * width / 3, top + height * 0.83),
      Offset(left + 2 * width / 3, top + height * 0.80),
      Offset(left + 3 * width / 3, top + height * 0.78),
    ];

    void drawSeries(List<Offset> points, Paint linePaint, Paint dotPaint) {
      final path = Path()..moveTo(points.first.dx, points.first.dy);
      for (final point in points.skip(1)) {
        path.lineTo(point.dx, point.dy);
      }
      canvas.drawPath(path, linePaint);
      for (final point in points) {
        canvas.drawCircle(point, 3.5, dotPaint);
        canvas.drawCircle(point, 2.2, Paint()..color = AppColors.surface);
      }
    }

    drawSeries(tealPoints, tealPaint, tealFill);
    drawSeries(bluePoints, bluePaint, blueFill);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (var i = 0; i < labels.length; i++) {
      textPainter.text = TextSpan(
        text: labels[i],
        style: const TextStyle(fontSize: 9, color: AppColors.textSecondary),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          left - 10 + (width / 3) * i - textPainter.width / 2,
          size.height - 18,
        ),
      );
    }

    final yLabels = ['-2', '-4', '-6', '-8', '-10'];
    for (var i = 0; i < yLabels.length; i++) {
      textPainter.text = TextSpan(
        text: yLabels[i],
        style: const TextStyle(fontSize: 9, color: AppColors.textSecondary),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, top + (height / 4) * i - 5));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MiniBarChart extends StatelessWidget {
  final List<_BarData> bars;

  const _MiniBarChart({required this.bars});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children:
          bars.map((bar) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      bar.valueLabel,
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 120,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 20,
                        height: 120 * bar.ratio,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      bar.label,
                      style: const TextStyle(
                        fontSize: 9,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}

class _BarData {
  final String label;
  final double ratio;

  const _BarData(this.label, this.ratio);

  String get valueLabel {
    final value = (ratio * 10000).round();
    return value.toString();
  }
}
