// screens/today_training_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// 训练项目数据模型
class TrainingItem {
  final String name;
  final int durationMinutes;
  final Color color;
  final IconData icon;
  bool isCompleted;

  TrainingItem({
    required this.name,
    required this.durationMinutes,
    required this.color,
    required this.icon,
    this.isCompleted = false,
  });
}

class TodayTrainingScreen extends StatefulWidget {
  const TodayTrainingScreen({super.key});

  @override
  State<TodayTrainingScreen> createState() => _TodayTrainingScreenState();
}

class _TodayTrainingScreenState extends State<TodayTrainingScreen> {
  int _selectedIndex = 1; // 默认选中 Schedule tab

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to main screen with the selected tab
    Navigator.pushReplacementNamed(
      context,
      '/main',
      arguments: {'initialIndex': index},
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<TrainingItem> trainingItems = [
      TrainingItem(
        name: 'Warm-up',
        durationMinutes: 10,
        color: Colors.pink[100]!,
        icon: Icons.self_improvement,
      ),
      TrainingItem(
        name: 'Squat',
        durationMinutes: 45,
        color: Colors.orange[100]!,
        icon: Icons.fitness_center,
      ),
      TrainingItem(
        name: 'Bench Press',
        durationMinutes: 45,
        color: Colors.blue[100]!,
        icon: Icons.fitness_center,
      ),
      TrainingItem(
        name: 'Deadlift',
        durationMinutes: 30,
        color: Colors.green[100]!,
        icon: Icons.fitness_center,
      ),
      TrainingItem(
        name: 'Cool-down',
        durationMinutes: 10,
        color: Colors.purple[100]!,
        icon: Icons.spa,
      ),
    ];

    final totalDuration = trainingItems.fold(0, (sum, item) => sum + item.durationMinutes);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'LTC',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Timer
            Text(
              '${totalDuration ~/ 60}:${(totalDuration % 60).toString().padLeft(2, '0')}:00',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 24),

            // Strength Training title
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Today\'s Training',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Exercise items
            Expanded(
              child: ListView.builder(
                itemCount: trainingItems.length,
                itemBuilder: (context, index) {
                  return _buildExerciseItem(trainingItems[index]);
                },
              ),
            ),

            const SizedBox(height: 16),

            // Start button
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrainingTimerScreen(trainingItems: trainingItems),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Analytics'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
      ),
    );
  }

  Widget _buildExerciseItem(TrainingItem item) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              item.icon,
              color: Colors.grey[600],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '${item.durationMinutes} min',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
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

// 训练倒计时界面
class TrainingTimerScreen extends StatefulWidget {
  final List<TrainingItem> trainingItems;

  const TrainingTimerScreen({super.key, required this.trainingItems});

  @override
  State<TrainingTimerScreen> createState() => _TrainingTimerScreenState();
}

class _TrainingTimerScreenState extends State<TrainingTimerScreen>
    with TickerProviderStateMixin {
  int currentItemIndex = 0;
  int remainingSeconds = 0;
  bool isRunning = false;
  bool isPaused = false;

  late AnimationController _progressController;
  late AnimationController _colorAnimationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.trainingItems[0].durationMinutes * 60;

    _progressController = AnimationController(
      duration: Duration(seconds: widget.trainingItems[currentItemIndex].durationMinutes * 60),
      vsync: this,
    );

    _colorAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.linear,
    ));

    _startTimer();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _colorAnimationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    if (!isRunning) {
      setState(() {
        isRunning = true;
        isPaused = false;
      });

      _progressController.duration = Duration(seconds: remainingSeconds);
      _progressController.forward();

      _countdown();
    }
  }

  void _pauseTimer() {
    setState(() {
      isPaused = true;
      isRunning = false;
    });
    _progressController.stop();
  }

  void _resumeTimer() {
    setState(() {
      isPaused = false;
      isRunning = true;
    });
    _progressController.forward();
    _countdown();
  }

  void _skipToNext() {
    _progressController.stop();
    _nextExercise();
  }

  void _finishEarly() {
    _progressController.stop();
    widget.trainingItems[currentItemIndex].isCompleted = true;
    _nextExercise();
  }

  void _countdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (isRunning && remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
        _countdown();
      } else if (remainingSeconds <= 0) {
        _nextExercise();
      }
    });
  }

  void _nextExercise() async {
    widget.trainingItems[currentItemIndex].isCompleted = true;

    if (currentItemIndex < widget.trainingItems.length - 1) {
      // 颜色过渡动画
      await _colorAnimationController.forward();

      setState(() {
        currentItemIndex++;
        remainingSeconds = widget.trainingItems[currentItemIndex].durationMinutes * 60;
        isRunning = false;
        isPaused = false;
      });

      _progressController.reset();
      _colorAnimationController.reset();

      // 震动反馈
      HapticFeedback.mediumImpact();

      // 自动开始下一个训练
      Future.delayed(const Duration(milliseconds: 500), () {
        _startTimer();
      });
    } else {
      // 训练完成
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('🎉 训练完成！'),
          content: const Text('恭喜你完成了今天的训练计划！'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('返回'),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = widget.trainingItems[currentItemIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '训练进行中',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _finishEarly,
            child: const Text(
              '提前结束',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 进度指示器
            LinearProgressIndicator(
              value: (currentItemIndex + 1) / widget.trainingItems.length,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            const SizedBox(height: 8),
            Text(
              '${currentItemIndex + 1} / ${widget.trainingItems.length}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 32),

            // 当前训练项目
            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [_progressAnimation.value, _progressAnimation.value],
                      colors: [Colors.grey[300]!, currentItem.color],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: currentItem.color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        currentItem.icon,
                        size: 64,
                        color: Colors.black87,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        currentItem.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            // 倒计时
            Text(
              _formatTime(remainingSeconds),
              style: const TextStyle(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 48),

            // 控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _skipToNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Icon(
                    Icons.skip_next,
                    color: Colors.white,
                    size: 32,
                  ),
                ),

                ElevatedButton(
                  onPressed: isRunning ? _pauseTimer : (isPaused ? _resumeTimer : _startTimer),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(32),
                  ),
                  child: Icon(
                    isRunning ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 48,
                  ),
                ),

                ElevatedButton(
                  onPressed: _finishEarly,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Icon(
                    Icons.stop,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 训练列表
            Expanded(
              child: ListView.builder(
                itemCount: widget.trainingItems.length,
                itemBuilder: (context, index) {
                  final item = widget.trainingItems[index];
                  final isActive = index == currentItemIndex;
                  final isCompleted = item.isCompleted;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isActive
                          ? item.color.withOpacity(0.3)
                          : (isCompleted ? Colors.green[100] : Colors.grey[100]),
                      borderRadius: BorderRadius.circular(8),
                      border: isActive ? Border.all(color: item.color, width: 2) : null,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isCompleted ? Icons.check_circle : item.icon,
                          color: isCompleted ? Colors.green : Colors.grey[600],
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                              color: isCompleted ? Colors.green[700] : Colors.black,
                              decoration: isCompleted ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        ),
                        Text(
                          '${item.durationMinutes} min',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}