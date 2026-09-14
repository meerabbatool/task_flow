import 'package:flutter/material.dart';
import '../models/task.dart';
import '../theme/colors.dart';

enum FilterTab { all, pending, completed }

class EmptyState extends StatelessWidget {
  final VoidCallback onAddTask;
  const EmptyState({super.key, required this.onAddTask});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 56, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.mint,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.checklist_rtl,
              size: 34,
              color: AppColors.green,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'No tasks yet',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Add your first task below and start\nchecking things off your list.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: AppColors.sub, height: 1.4),
          ),
          const SizedBox(height: 22),
          ElevatedButton.icon(
            onPressed: onAddTask,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            icon: const Icon(Icons.add, size: 18),
            label: const Text(
              'Add your first task',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  final VoidCallback onAddTask;
  const HomeHeader({super.key, required this.onAddTask});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back, color: AppColors.ink),
            tooltip: 'Back',
          ),
          const SizedBox(width: 4),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TaskFlow',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                Text(
                  'Simple daily task manager',
                  style: TextStyle(fontSize: 13, color: AppColors.sub),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: onAddTask,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.green,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.add, size: 18),
            label: const Text(
              'Add Task',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterTabs extends StatelessWidget {
  final FilterTab selected;
  final int allCount;
  final int pendingCount;
  final int completedCount;
  final ValueChanged<FilterTab> onChanged;

  const FilterTabs({
    super.key,
    required this.selected,
    required this.allCount,
    required this.pendingCount,
    required this.completedCount,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.tabBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _tab('All', allCount, FilterTab.all),
          _tab('Pending', pendingCount, FilterTab.pending),
          _tab('Completed', completedCount, FilterTab.completed),
        ],
      ),
    );
  }

  Widget _tab(String label, int count, FilterTab tab) {
    final isActive = selected == tab;
    return GestureDetector(
      onTap: () => onChanged(tab),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: isActive ? AppColors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.white : AppColors.sub,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.white.withValues(alpha: 0.35)
                    : Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.white : AppColors.ink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = task.status == TaskStatus.completed;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDone ? const Color(0xFFCFE9D6) : AppColors.line,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 22,
              height: 22,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? AppColors.green : Colors.transparent,
                border: Border.all(
                  color: isDone ? AppColors.green : const Color(0xFFCFCABB),
                  width: 2,
                ),
              ),
              child: isDone
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 10,
                  runSpacing: 4,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDone ? const Color(0xFF8A8679) : AppColors.ink,
                        decoration: isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isDone ? AppColors.mint : AppColors.pink,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isDone ? 'Completed' : 'Pending',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDone ? AppColors.green : AppColors.pinkText,
                        ),
                      ),
                    ),
                  ],
                ),
                if (task.description.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text(
                    task.description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.sub,
                      height: 1.4,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onEdit,
            child: const Icon(
              Icons.edit_outlined,
              size: 18,
              color: Color(0xFF8A8679),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onDelete,
            child: const Icon(
              Icons.delete_outline,
              size: 18,
              color: Color(0xFF8A8679),
            ),
          ),
        ],
      ),
    );
  }
}

class OverviewCard extends StatelessWidget {
  final int total;
  final int pending;
  final int completed;
  final double progress;

  const OverviewCard({
    super.key,
    required this.total,
    required this.pending,
    required this.completed,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'A quick look at how your day is shaping up.',
            style: TextStyle(fontSize: 13, color: AppColors.sub),
          ),
          const SizedBox(height: 16),
          _statRow(
            Icons.list_alt,
            const Color(0xFFEFEDE6),
            AppColors.ink,
            'Total tasks',
            total,
          ),
          const SizedBox(height: 10),
          _statRow(
            Icons.access_time,
            AppColors.pink,
            AppColors.pinkText,
            'Pending',
            pending,
          ),
          const SizedBox(height: 10),
          _statRow(
            Icons.check_circle_outline,
            AppColors.mint,
            AppColors.green,
            'Completed',
            completed,
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overall progress',
                style: TextStyle(fontSize: 14, color: AppColors.ink),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.amber,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFE9E5D8),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.amber),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statRow(
    IconData icon,
    Color iconBg,
    Color iconColor,
    String label,
    int value,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.line),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(icon, size: 17, color: iconColor),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(fontSize: 15, color: AppColors.ink),
              ),
            ],
          ),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

class TipOfTheDay extends StatelessWidget {
  const TipOfTheDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.tipBg,
        border: Border.all(color: const Color(0xFFF6D9D6)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.pink,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.lightbulb_outline,
              size: 17,
              color: AppColors.pinkText,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tip of the day',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Tap any task card to edit it, or hit the round checkbox to mark it done in one click.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.sub,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
