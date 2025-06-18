// screens/coach_schedule_page.dart (Coach版本)
import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Today Schedule
          _buildScheduleSection(
            title: 'Today schedule',
            imagePath: 'assets/images/today_schedule.jpg',
            backgroundColor: Colors.orange,
            onTap: () {
              // 处理今日日程点击事件
            },
          ),

          const SizedBox(height: 16),

          // Appointment Schedule
          _buildScheduleSection(
            title: 'appointment schedule',
            imagePath: 'assets/images/appointment.jpg',
            backgroundColor: Colors.orange,
            onTap: () {
              // 处理预约日程点击事件
            },
          ),

          const SizedBox(height: 16),

          // Reservation Status
          _buildScheduleSection(
            title: 'Reservation status',
            imagePath: 'assets/images/reservation.jpg',
            backgroundColor: Colors.orange,
            onTap: () {
              // 处理预约状态点击事件
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleSection({
    required String title,
    required String imagePath,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // 背景图片
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey.shade300, Colors.grey.shade100],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Icon(
                  Icons.schedule,
                  size: 60,
                  color: Colors.grey,
                ),
              ),

              // 橙色标题栏
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: backgroundColor,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white, // 保持白色，因为背景是橙色
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // 点击效果
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    child: Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}