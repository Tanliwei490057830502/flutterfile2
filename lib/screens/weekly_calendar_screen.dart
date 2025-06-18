// screens/weekly_calendar_screen.dart
import 'package:flutter/material.dart';
import 'appointment_schedule_screen.dart';

class WeeklyCalendarScreen extends StatefulWidget {
  const WeeklyCalendarScreen({super.key});

  @override
  State<WeeklyCalendarScreen> createState() => _WeeklyCalendarScreenState();
}

class _WeeklyCalendarScreenState extends State<WeeklyCalendarScreen> {
  int _selectedIndex = 1;
  DateTime selectedDate = DateTime.now();

  void _onItemTapped(int index) {
    Navigator.pushReplacementNamed(
      context,
      '/main',
      arguments: {'initialIndex': index},
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Weekly Calendar',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMonthSelector(),
                  _buildWeekdayHeader(),
                  _buildCalendarGrid(),
                  _buildEventCard(),
                  _buildBookButton(),
                ],
              ),
            ),
          ),
        ],
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

  Widget _buildMonthSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () {
              setState(() {
                selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
              });
            },
          ),
          Text(
            '${_getMonthName(selectedDate.month)} ${selectedDate.year}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {
              setState(() {
                selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
            .map((day) => Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          child: Text(
            day,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ))
            .toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          childAspectRatio: 1,
        ),
        itemCount: 42,
        itemBuilder: (context, index) {
          final firstDay = DateTime(selectedDate.year, selectedDate.month, 1);
          final startOffset = firstDay.weekday % 7;
          final dayNum = index - startOffset + 1;
          final daysInMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
          final isCurrentMonth = dayNum > 0 && dayNum <= daysInMonth;
          final isToday = isCurrentMonth &&
              dayNum == DateTime.now().day &&
              selectedDate.month == DateTime.now().month &&
              selectedDate.year == DateTime.now().year;
          final hasEvent = isCurrentMonth && (dayNum == 15 || dayNum == 20 || dayNum == 25);

          return GestureDetector(
            onTap: isCurrentMonth
                ? () {
              setState(() {
                selectedDate = DateTime(selectedDate.year, selectedDate.month, dayNum);
              });
            }
                : null,
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isToday
                    ? Colors.deepPurple
                    : selectedDate.day == dayNum && isCurrentMonth
                    ? Colors.orange.withOpacity(0.3)
                    : null,
                borderRadius: BorderRadius.circular(8),
                border: hasEvent ? Border.all(color: Colors.green, width: 2) : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isCurrentMonth ? dayNum.toString() : '',
                    style: TextStyle(
                      color: isToday
                          ? Colors.white
                          : isCurrentMonth
                          ? Colors.black
                          : Colors.transparent,
                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  if (hasEvent)
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEventCard() {
    final events = _getEventsForDate(selectedDate);

    return Container(
      margin: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Events for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (events.isEmpty)
                const Text(
                  'No events scheduled for this date',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                )
              else
                Column(
                  children: events.map((event) {
                    final eventType = event['type'] ?? 'other';
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getEventIcon(eventType),
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event['title'] ?? '',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  event['time'] ?? '',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AppointmentScheduleScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        ),
        child: const Text(
          'Book New Appointment',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  List<Map<String, String>> _getEventsForDate(DateTime date) {
    if (date.day == 15) {
      return [
        {'title': 'Personal Training Session', 'time': '8:00 AM - 10:00 AM', 'type': 'training'},
        {'title': 'Yoga Class', 'time': '6:00 PM - 7:00 PM', 'type': 'class'},
      ];
    } else if (date.day == 20) {
      return [
        {'title': 'Strength Training', 'time': '10:00 AM - 12:00 PM', 'type': 'training'},
      ];
    } else if (date.day == 25) {
      return [
        {'title': 'Cardio Session', 'time': '3:00 PM - 5:00 PM', 'type': 'cardio'},
        {'title': 'Nutrition Consultation', 'time': '7:00 PM - 8:00 PM', 'type': 'consultation'},
      ];
    }
    return [];
  }

  IconData _getEventIcon(String? type) {
    switch (type) {
      case 'training':
        return Icons.fitness_center;
      case 'class':
        return Icons.group;
      case 'cardio':
        return Icons.directions_run;
      case 'consultation':
        return Icons.chat;
      default:
        return Icons.event;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
}
