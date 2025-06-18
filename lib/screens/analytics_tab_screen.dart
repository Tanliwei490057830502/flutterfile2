// screens/analytics_tab_screen.dart
import 'package:flutter/material.dart';

class AnalyticsTabScreen extends StatelessWidget {
  const AnalyticsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Training intensity chart
            const Text(
              'Your training intensity',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Strength',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Bar chart simulation
                  SizedBox(
                    height: 200,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildBarChart('Mon', 5, Colors.blue),
                        _buildBarChart('Tue', 3, Colors.blue),
                        _buildBarChart('Wed', 4, Colors.blue),
                        _buildBarChart('Thu', 2, Colors.blue),
                        _buildBarChart('Fri', 5, Colors.blue),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Time',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Weight estimate section
            const Text(
              'weight estimate',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Y-axis labels
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('75kg', style: TextStyle(color: Colors.white, fontSize: 12)),
                          SizedBox(height: 20),
                          Text('74kg', style: TextStyle(color: Colors.white, fontSize: 12)),
                          SizedBox(height: 20),
                          Text('73kg', style: TextStyle(color: Colors.white, fontSize: 12)),
                          SizedBox(height: 20),
                          Text('72kg', style: TextStyle(color: Colors.white, fontSize: 12)),
                          SizedBox(height: 20),
                          Text('71kg', style: TextStyle(color: Colors.white, fontSize: 12)),
                          SizedBox(height: 20),
                          Text('70kg', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ],
                      ),
                      SizedBox(width: 16),

                    ],
                  ),

                  const SizedBox(height: 16),

                  // X-axis labels
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('week', style: TextStyle(color: Colors.white, fontSize: 10)),
                      Text('week', style: TextStyle(color: Colors.white, fontSize: 10)),
                      Text('week', style: TextStyle(color: Colors.white, fontSize: 10)),
                      Text('week', style: TextStyle(color: Colors.white, fontSize: 10)),
                      Text('week', style: TextStyle(color: Colors.white, fontSize: 10)),
                      Text('week', style: TextStyle(color: Colors.white, fontSize: 10)),
                      Text('week', style: TextStyle(color: Colors.white, fontSize: 10)),
                      Text('week', style: TextStyle(color: Colors.white, fontSize: 10)),
                      Text('week', style: TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'time',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Next button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart(String day, int value, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: value * 30.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class WeightChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Draw grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1;

    for (int i = 0; i <= 6; i++) {
      double y = size.height / 6 * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    for (int i = 0; i <= 8; i++) {
      double x = size.width / 8 * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    // Draw weight trend line (simulated declining trend)
    path.moveTo(0, size.height * 0.8);
    path.lineTo(size.width * 0.2, size.height * 0.7);
    path.lineTo(size.width * 0.4, size.height * 0.6);
    path.lineTo(size.width * 0.6, size.height * 0.5);
    path.lineTo(size.width * 0.8, size.height * 0.4);
    path.lineTo(size.width, size.height * 0.3);

    canvas.drawPath(path, paint);

    // Draw data points
    final pointPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(0, size.height * 0.8), 3, pointPaint);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.7), 3, pointPaint);
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.6), 3, pointPaint);
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.5), 3, pointPaint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.4), 3, pointPaint);
    canvas.drawCircle(Offset(size.width, size.height * 0.3), 3, pointPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}