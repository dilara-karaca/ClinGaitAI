import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Egzersizlerim'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showExerciseSearch(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDailyProgress(),
            const SizedBox(height: 24),
            _buildSectionTitle('Bugünün Programı'),
            const SizedBox(height: 12),
            _buildTodayExercises(),
            const SizedBox(height: 24),
            _buildSectionTitle('Kategoriler'),
            const SizedBox(height: 12),
            _buildCategories(),
            const SizedBox(height: 24),
            _buildSectionTitle('Tüm Egzersizler'),
            const SizedBox(height: 12),
            _buildAllExercises(),
            const SizedBox(height: 100), // Bottom nav bar padding
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildDailyProgress() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: CircularProgressIndicator(
                  value: 0.6,
                  backgroundColor: AppColors.primaryLight.withValues(
                    alpha: 0.2,
                  ),
                  color: AppColors.primary,
                  strokeWidth: 8,
                  strokeCap: StrokeCap.round,
                ),
              ),
              const Text(
                '%60',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Günlük Hedef',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '3 / 5 egzersiz tamamlandı',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Devam et, harika gidiyorsun! 💪',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayExercises() {
    return const Column(
      children: [
        _ExerciseCard(
          title: 'Ayak Bileği Rotasyonu',
          subtitle: '3 set x 15 tekrar • 10 dk',
          icon: Icons.rotate_right,
          color: AppColors.chartBlue,
        ),
        SizedBox(height: 12),
        _ExerciseCard(
          title: 'Topuk Kaldırma',
          subtitle: '3 set x 12 tekrar • 8 dk',
          icon: Icons.height,
          color: AppColors.chartOrange,
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          _CategoryCard(
            title: 'Isınma',
            icon: Icons.local_fire_department,
            color: AppColors.accent,
          ),
          SizedBox(width: 12),
          _CategoryCard(
            title: 'Germe',
            icon: Icons.accessibility_new,
            color: AppColors.secondary,
          ),
          SizedBox(width: 12),
          _CategoryCard(
            title: 'Güçlenme',
            icon: Icons.fitness_center,
            color: AppColors.chartPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildAllExercises() {
    return const Column(
      children: [
        _ExerciseCard(
          title: 'Denge Egzersizi',
          subtitle: '2 set x 30 sn • 10 dk',
          icon: Icons.balance,
          color: AppColors.chartGreen,
        ),
        SizedBox(height: 12),
        _ExerciseCard(
          title: 'Parmak Ucu Yürüyüşü',
          subtitle: '2 set x 20 adım • 5 dk',
          icon: Icons.directions_walk,
          color: AppColors.primaryLight,
        ),
        SizedBox(height: 12),
        _ExerciseCard(
          title: 'Diz Esnetme',
          subtitle: '3 set x 10 tekrar • 8 dk',
          icon: Icons.airline_seat_legroom_extra,
          color: AppColors.chartBlue,
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _CategoryCard({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _ExerciseCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  State<_ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<_ExerciseCard> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
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
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: widget.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(widget.icon, color: widget.color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isCompleted = !isCompleted;
              });
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color:
                    isCompleted
                        ? AppColors.success.withValues(alpha: 0.12)
                        : AppColors.background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted ? Icons.check_circle : Icons.play_arrow_rounded,
                color: isCompleted ? AppColors.success : AppColors.primary,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _showExerciseSearch(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Egzersiz Ara',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Egzersiz adı gir',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Öneriler',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(label: Text('Denge Egzersizi')),
                  Chip(label: Text('Ayak Bileği Rotasyonu')),
                  Chip(label: Text('Topuk Kaldırma')),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
