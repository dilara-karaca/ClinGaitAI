import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ExercisesScreen extends StatefulWidget {
  const ExercisesScreen({super.key});

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  String? _selectedCategory;

  final List<Map<String, dynamic>> _allExercises = [
    {
      'title': 'Denge Egzersizi',
      'category': 'Güçlenme',
      'duration': '2 set x 30 sn',
      'desc':
          'Tek ayak üzerinde durarak dengenizi koruyun. Vücudunuz dik olmalı.',
      'icon': Icons.accessibility_new,
    },
    {
      'title': 'Ayak Bileği Rotasyonu',
      'category': 'Isınma',
      'duration': '3 set x 15 tekrar',
      'desc': 'Bileğinizi yavaşça saat yönünde ve tersine çevirin.',
      'icon': Icons.airline_seat_legroom_extra,
    },
    {
      'title': 'Topuk Kaldırma',
      'category': 'Güçlenme',
      'duration': '3 set x 12 tekrar',
      'desc': 'Parmak uçlarında yükselin ve inin. Baldır kaslarını çalıştırır.',
      'icon': Icons.height,
    },
    {
      'title': 'Diz Esnetme',
      'category': 'Germe',
      'duration': '3 set x 10 tekrar',
      'desc': 'Dizinizi göğsünüze doğru çekip esnetin. Kasları uzatır.',
      'icon': Icons.nordic_walking,
    },
    {
      'title': 'Parmak Ucu Yürüyüşü',
      'category': 'Güçlenme',
      'duration': '2 set x 20 adım',
      'desc':
          'Parmak uçlarında adım atarak yürüyün. Ayak tabanını güçlendirir.',
      'icon': Icons.directions_walk,
    },
    {
      'title': 'Hafif Tempoyla Yürüyüş',
      'category': 'Isınma',
      'duration': '5 dk',
      'desc': 'Yavaş tempoyla yürüyerek tüm kasları hazırlayın.',
      'icon': Icons.directions_run,
    },
    {
      'title': 'Oturarak Bacak Uzatma',
      'category': 'Germe',
      'duration': '2 set x 15 sn',
      'desc': 'Sandalyede otururken bacağınızı öne düz uzatıp bekleyin.',
      'icon': Icons.event_seat,
    },
    {
      'title': 'Omuz Çevirme',
      'category': 'Isınma',
      'duration': '10 tekrar',
      'desc':
          'Omuzlarınızı yavaşça öne ve arkaya doğru dairesel hareketlerle çevirin.',
      'icon': Icons.emoji_people,
    },
    {
      'title': 'Bel Esnetme',
      'category': 'Germe',
      'duration': '2 set x 20 sn',
      'desc': 'Sırt üstü yatarak dizlerinizi sağa ve sola yavaşça yatırın.',
      'icon': Icons.self_improvement,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final displayedExercises =
        _selectedCategory == null
            ? _allExercises
            : _allExercises
                .where((e) => e['category'] == _selectedCategory)
                .toList();

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
            _buildWeeklyProgress(),
            const SizedBox(height: 16),
            _buildDailyProgress(),
            const SizedBox(height: 24),
            _buildSectionTitle('Kategoriler'),
            const SizedBox(height: 12),
            _buildCategories(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionTitle(
                  _selectedCategory == null
                      ? 'Tüm Hareketler'
                      : '$_selectedCategory Hareketleri',
                ),
                if (_selectedCategory != null)
                  TextButton(
                    onPressed: () => setState(() => _selectedCategory = null),
                    child: const Text(
                      'Tümünü Gör',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            ...displayedExercises.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ExpandableExerciseCard(
                  title: e['title'],
                  subtitle: e['duration'],
                  description: e['desc'],
                  icon: e['icon'],
                ),
              ),
            ),
            const SizedBox(height: 100),
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

  Widget _buildWeeklyProgress() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Haftalık İlerleme',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: List.generate(7, (index) {
              final days = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];
              final isCompleted = index < 3; // İlk 3 gün tamam
              final isToday = index == 3;
              return Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color:
                            isCompleted
                                ? AppColors.success
                                : (isToday
                                    ? AppColors.primary
                                    : AppColors.sageGreenLight),
                        shape: BoxShape.circle,
                        border:
                            isToday
                                ? Border.all(
                                  color: AppColors.primaryLight,
                                  width: 2,
                                )
                                : null,
                      ),
                      child: Icon(
                        isCompleted
                            ? Icons.check
                            : (isToday ? Icons.play_arrow : null),
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      days[index],
                      style: TextStyle(
                        fontSize: 11,
                        color:
                            isToday
                                ? AppColors.primary
                                : AppColors.textSecondary,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyProgress() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Günlük Takip (Bugün)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontSize: 16,
                ),
              ),
              const Text(
                '3/5 Tamamlandı',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(
              value: 0.6,
              minHeight: 12,
              backgroundColor: AppColors.sageGreenLight,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        children: [
          _CategoryCard(
            title: 'Isınma',
            icon: Icons.local_fire_department,
            color: AppColors.accent,
            isSelected: _selectedCategory == 'Isınma',
            onTap: () {
              setState(
                () =>
                    _selectedCategory =
                        _selectedCategory == 'Isınma' ? null : 'Isınma',
              );
            },
          ),
          const SizedBox(width: 12),
          _CategoryCard(
            title: 'Germe',
            icon: Icons.accessibility_new,
            color: AppColors.secondary,
            isSelected: _selectedCategory == 'Germe',
            onTap: () {
              setState(
                () =>
                    _selectedCategory =
                        _selectedCategory == 'Germe' ? null : 'Germe',
              );
            },
          ),
          const SizedBox(width: 12),
          _CategoryCard(
            title: 'Güçlenme',
            icon: Icons.fitness_center,
            color: AppColors.chartPurple,
            isSelected: _selectedCategory == 'Güçlenme',
            onTap: () {
              setState(
                () =>
                    _selectedCategory =
                        _selectedCategory == 'Güçlenme' ? null : 'Güçlenme',
              );
            },
          ),
        ],
      ),
    );
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
                    fillColor: AppColors.surface,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.sageGreenLight),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.mintGreen, width: 2),
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
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 110,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withValues(alpha: isSelected ? 1.0 : 0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                  : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Colors.white : color, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExpandableExerciseCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;

  const _ExpandableExerciseCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
  });

  @override
  State<_ExpandableExerciseCard> createState() =>
      _ExpandableExerciseCardState();
}

class _ExpandableExerciseCardState extends State<_ExpandableExerciseCard> {
  bool isCompleted = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => isExpanded = !isExpanded),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.sageGreenLight,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Shadow body effect: Aynı ikonun daha büyük ve soluk hali
                        Icon(
                          widget.icon,
                          color: AppColors.textLight.withValues(alpha: 0.25),
                          size: 38,
                        ),
                        // Ana ikon
                        Icon(widget.icon, color: AppColors.primary, size: 22),
                      ],
                    ),
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
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            decoration:
                                isCompleted ? TextDecoration.lineThrough : null,
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
                    onTap: () => setState(() => isCompleted = !isCompleted),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color:
                            isCompleted
                                ? AppColors.success.withValues(alpha: 0.12)
                                : AppColors.sageGreenLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isCompleted
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color:
                            isCompleted
                                ? AppColors.success
                                : AppColors.textLight,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity, height: 0),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.sageGreenLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            crossFadeState:
                isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
