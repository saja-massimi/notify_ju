import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/statisticsController.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final controller = Get.put(statisticsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Dashboard', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF464A5E),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: controller.ReportData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          final data = snapshot.data!;
          return Column(
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
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: controller.getAllAdmins(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error fetching admins'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No admins found'));
                    }

                    final admins = snapshot.data!;
                    return ListView.builder(
                      itemCount: admins.length,
                      itemBuilder: (context, index) {
                        final data = admins[index];
                        return AdminStatsCard(
                          adminDetails: data,
                        );
                      },
                    );
                  },
                ),
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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 250,
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
  final Map<String, dynamic> adminDetails;

  const AdminStatsCard({
    Key? key,
    required this.adminDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(statisticsController());
    final user_email = adminDetails['user_email'];

    if (user_email == null) {
      return Container();
    }

    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: controller.getAllWarnings(user_email),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error fetching warnings'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container();
        }

        final warnings = snapshot.data!;
        final warningTypes = <String, int>{};
        warnings.forEach((warning) {
          final type = warning['type'] as String?;
          if (type != null) {
            warningTypes[type] = (warningTypes[type] ?? 0) + 1;
          }
        });

        // Calculate average response time
        final averageResponseTime = warnings
                .map((e) => e['responseTime'] as double? ?? 0)
                .reduce((a, b) => a + b) /
            warnings.length;

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  adminDetails['admin_name'] ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  user_email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF464A5E),
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Total Warnings: ${warnings.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Average Response Time: ${averageResponseTime.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: warningTypes.entries.map((entry) {
                        // Use distinct colors for each warning type
                        final color = Colors.primaries[
                            warningTypes.keys.toList().indexOf(entry.key)];

                        return PieChartSectionData(
                          color: color,
                          value: entry.value.toDouble(),
                          title: entry.key,
                          titlePositionPercentageOffset: 1.2,
                          badgeWidget: Text(
                            '${entry.value}',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
