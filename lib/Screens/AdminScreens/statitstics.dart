import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  Future<Map<String, dynamic>> fetchReportData() async {
    final _db = FirebaseFirestore.instance;
    int allReports = 0;
    int underviewReports = 0;
    int pendingReports = 0;
    int onHoldReports = 0;
    int rejectedReports = 0;
    int resolvedReports = 0;

    try {
      final reportsSnapshot = await _db.collectionGroup('reports').get();
      for (var report in reportsSnapshot.docs) {
        allReports++;
        switch (report['report_status']) {
          case 'Under Review':
            underviewReports++;
            break;
          case 'Pending':
            pendingReports++;
            break;
          case 'On Hold':
            onHoldReports++;
            break;
          case 'Rejected':
            rejectedReports++;
            break;
          case 'Resolved':
            resolvedReports++;
            break;
          default:
            break;
        }
      }
    } catch (e) {
      print('Error fetching report data: $e');
    }

    return {
      'allReports': allReports,
      'underviewReports': underviewReports,
      'pendingReports': pendingReports,
      'onHoldReports': onHoldReports,
      'rejectedReports': rejectedReports,
      'resolvedReports': resolvedReports,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF464A5E),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchReportData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final data = snapshot.data!;
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text(
                'Total Reports: ${data['allReports']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              PieChartCard(
                title: 'Report Distribution',
                data: data,
              ),
              SizedBox(height: 16),
              AdminStatsCard(
                adminName: 'Admin 1',
                totalAdminWarnings: 8,
                averageResponseTime: 15,
              ),
            ],
          );
        },
      ),
    );
  }
}

class PieChartCard extends StatelessWidget {
  final String title;
  final Map<String, dynamic> data;

  const PieChartCard({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Color.fromARGB(255, 75, 9, 92),
                      value: data['underviewReports'].toDouble(),
                      title: 'Underview',
                      titlePositionPercentageOffset: 1.8,
                      badgeWidget: Text(
                        '${data['underviewReports']}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    PieChartSectionData(
                      color: Color.fromARGB(255, 255, 154, 46),
                      value: data['pendingReports'].toDouble(),
                      title: 'Pending',
                      titlePositionPercentageOffset: 1.2,
                      badgeWidget: Text(
                        '${data['pendingReports']}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    PieChartSectionData(
                      color: Color.fromARGB(255, 134, 129, 133),
                      value: data['onHoldReports'].toDouble(),
                      title: 'On Hold',
                      titlePositionPercentageOffset: 1.6,
                      badgeWidget: Text(
                        '${data['onHoldReports']}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    PieChartSectionData(
                      color: Color.fromARGB(255, 233, 35, 35),
                      value: data['rejectedReports'].toDouble(),
                      title: 'Rejected',
                      titlePositionPercentageOffset: 1.8,
                      badgeWidget: Text(
                        '${data['rejectedReports']}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    PieChartSectionData(
                      color: Color.fromARGB(255, 41, 221, 62),
                      value: data['resolvedReports'].toDouble(),
                      title: 'Resolved',
                      titlePositionPercentageOffset: 1.8,
                      badgeWidget: Text(
                        '${data['resolvedReports']}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminStatsCard extends StatelessWidget {
  final String adminName;
  final int totalAdminWarnings;
  final int averageResponseTime;

  const AdminStatsCard({
    Key? key,
    required this.adminName,
    required this.totalAdminWarnings,
    required this.averageResponseTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              adminName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 12),
            Text('Total Admin Warnings: $totalAdminWarnings'),
            SizedBox(height: 8),
            Text('Average Response Time: $averageResponseTime minutes'),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: Colors.green,
                      value: totalAdminWarnings.toDouble(),
                      title: '$totalAdminWarnings',
                    ),
                    PieChartSectionData(
                      color: Colors.blue,
                      value: 60 - totalAdminWarnings.toDouble(),
                      title: '${60 - totalAdminWarnings}',
                    ),
                  ],
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 40,
                  sectionsSpace: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
