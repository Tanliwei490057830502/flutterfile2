// screens/coach_home_page.dart (Coach版本)
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 教练信息卡片
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade100, Colors.orange.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(
                    Icons.fitness_center,
                    size: 40,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chok Yun Ying',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // 改为黑色
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Personal Trainer',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54, // 改为黑色半透明
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 今日学生签到进度
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.bookmark, color: Colors.orange.shade700),
                    const SizedBox(width: 8),
                    const Text(
                      'Today\'s student check-in progress',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black, // 改为黑色
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      '2/4',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // 改为黑色
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ...List.generate(4, (index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                          color: index < 2 ? Colors.orange : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 今日预约概览
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.orange.shade700),
                    const SizedBox(width: 8),
                    const Text(
                      'Today\'s appointment overview',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black, // 改为黑色
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAppointmentItem('1', 'Tan Li Wei have appointment at 12-5-2025'),
                    _buildAppointmentItem('2', 'Tan Li Wei have appointment at 13-5-2025'),
                    _buildAppointmentItem('3', 'Tan Li Wei have appointment at 14-5-2025'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // 今日学生消息
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.message, color: Colors.orange.shade700),
                    const SizedBox(width: 8),
                    const Text(
                      'Today\'s Student news',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black, // 改为黑色
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tan Li Wei Bmi is low at 24.1',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87, // 改为黑色
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        '$number  $text',
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87, // 改为黑色
        ),
      ),
    );
  }
}