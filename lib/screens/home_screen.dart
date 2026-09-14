import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import '../theme/colors.dart';
import 'home_widgets.dart';
import 'new_task_screen.dart';

/// A brand-new user starts here with NO tasks; returning users see
/// whatever was previously saved on the device.
class TaskFlowHomeScreen extends StatefulWidget {
  const TaskFlowHomeScreen({super.key});

  @override
  State<TaskFlowHomeScreen> createState() => _TaskFlowHomeScreenState();
}

class _TaskFlowHomeScreenState extends State<TaskFlowHomeScreen> {
  FilterTab _selectedTab = FilterTab.all;
  final List<Task> _tasks = [];
  bool _loaded = false;
  static const _storageKey = 'taskflow_tasks';

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw != null) {
      final List<dynamic> decoded = jsonDecode(raw);
      _tasks.addAll(
        decoded.map((e) => Task.fromJson(e as Map<String, dynamic>)),
      );
    }
    setState(() => _loaded = true);
  }

  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(_tasks.map((t) => t.toJson()).toList());
    await prefs.setString(_storageKey, raw);
  }

  int get _totalCount => _tasks.length;
  int get _pendingCount =>
      _tasks.where((t) => t.status == TaskStatus.pending).length;
  int get _completedCount =>
      _tasks.where((t) => t.status == TaskStatus.completed).length;
  double get _progress => _totalCount == 0 ? 0 : _completedCount / _totalCount;

  List<Task> get _visibleTasks {
    switch (_selectedTab) {
      case FilterTab.pending:
        return _tasks.where((t) => t.status == TaskStatus.pending).toList();
      case FilterTab.completed:
        return _tasks.where((t) => t.status == TaskStatus.completed).toList();
      case FilterTab.all:
        return _tasks;
    }
  }

  void _toggleTask(Task task) {
    setState(() {
      task.status = task.status == TaskStatus.pending
          ? TaskStatus.completed
          : TaskStatus.pending;
    });
    _saveTasks();
  }

  void _deleteTask(Task task) {
    setState(() => _tasks.remove(task));
    _saveTasks();
  }

  Future<void> _openNewTaskScreen() async {
    final result = await Navigator.of(context).push<Map<String, String>>(
      MaterialPageRoute(builder: (_) => const NewTaskScreen()),
    );
    if (result != null) {
      setState(() {
        _tasks.insert(
          0,
          Task(
            title: result['title']!,
            description: result['description'] ?? '',
            status: TaskStatus.pending,
          ),
        );
      });
      _saveTasks();
    }
  }

  Future<void> _openEditTaskScreen(Task task) async {
    final result = await Navigator.of(context).push<Map<String, String>>(
      MaterialPageRoute(builder: (_) => NewTaskScreen(existingTask: task)),
    );
    if (result != null) {
      setState(() {
        task.title = result['title']!;
        task.description = result['description'] ?? '';
      });
      _saveTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        backgroundColor: AppColors.cream,
        body: Center(child: CircularProgressIndicator(color: AppColors.green)),
      );
    }

    final isEmpty = _tasks.isEmpty;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          children: [
            HomeHeader(onAddTask: _openNewTaskScreen),
            const SizedBox(height: 24),
            const Text(
              "Today's Tasks",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isEmpty
                  ? "You're all clear — add your first task to get started."
                  : 'You have $_pendingCount pending tasks to get through.',
              style: const TextStyle(fontSize: 14, color: AppColors.sub),
            ),
            const SizedBox(height: 18),
            if (!isEmpty) ...[
              FilterTabs(
                selected: _selectedTab,
                allCount: _totalCount,
                pendingCount: _pendingCount,
                completedCount: _completedCount,
                onChanged: (tab) => setState(() => _selectedTab = tab),
              ),
              const SizedBox(height: 16),
              for (final task in _visibleTasks) ...[
                TaskCard(
                  task: task,
                  onToggle: () => _toggleTask(task),
                  onEdit: () => _openEditTaskScreen(task),
                  onDelete: () => _deleteTask(task),
                ),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 12),
              OverviewCard(
                total: _totalCount,
                pending: _pendingCount,
                completed: _completedCount,
                progress: _progress,
              ),
              const SizedBox(height: 20),
              const TipOfTheDay(),
            ] else
              EmptyState(onAddTask: _openNewTaskScreen),
          ],
        ),
      ),
    );
  }
}
