// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:notify_ju/Controller/statisticsController.dart';
import 'package:notify_ju/Widgets/AdminDrawer.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final controller = Get.put(statisticsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerWidget(),
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF464A5E),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: controller.ReportData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          final data = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Total Reports: ${data['allReports']}',
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  PieChartCard(
                    title: 'Report Distribution',
                    data: data,
                  ),
                  const SizedBox(height: 16),
                  AllFeedbacks(
                    title: 'Feedback',
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: controller.getAllAdmins(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: Text('Error fetching admins'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No admins found'));
                      }

                      final admins = snapshot.data!;
                      return Column(
                        children: admins.map((adminData) {
                          return AdminStatsCard(
                            adminDetails: adminData,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
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
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 75, 9, 92),
                      value: data['underviewReports'].toDouble(),
                      title: 'Underview',
                      titlePositionPercentageOffset: 1.8,
                      badgeWidget: Text(
                        '${data['underviewReports']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 255, 154, 46),
                      value: data['pendingReports'].toDouble(),
                      title: 'Pending',
                      titlePositionPercentageOffset: 1.5,
                      badgeWidget: Text(
                        '${data['pendingReports']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 134, 129, 133),
                      value: data['onHoldReports'].toDouble(),
                      title: 'On Hold',
                      titlePositionPercentageOffset: 1.6,
                      badgeWidget: Text(
                        '${data['onHoldReports']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 233, 35, 35),
                      value: data['rejectedReports'].toDouble(),
                      title: 'Rejected',
                      titlePositionPercentageOffset: 1.8,
                      badgeWidget: Text(
                        '${data['rejectedReports']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    PieChartSectionData(
                      color: const Color.fromARGB(255, 41, 221, 62),
                      value: data['resolvedReports'].toDouble(),
                      title: 'Resolved',
                      titlePositionPercentageOffset: 1.8,
                      badgeWidget: Text(
                        '${data['resolvedReports']}',
                        style: const TextStyle(color: Colors.white),
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


class AllFeedbacks extends StatelessWidget {
  final controller = Get.put(statisticsController());
  final String title;

  AllFeedbacks({
    Key? key,
    required this.title,
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
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 250,
              child: FutureBuilder(
                future: Future.wait([
                  controller.totalFeedbacks('Very Bad'),
                  controller.totalFeedbacks('Bad'),
                  controller.totalFeedbacks('Good'),
                  controller.totalFeedbacks('Very Good'),
                  controller.totalFeedbacks('Excellent'),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error fetching data'));
                  } else if (!snapshot.hasData) {
                    return const Center(child: Text('No data available'));
                  }

                  List<int> feedbackCounts = snapshot.data as List<int>;

                  return BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              fromY: 0,
                              toY: feedbackCounts[0].toDouble(),
                              color: const Color.fromARGB(255, 75, 9, 92),
                              width: 16,
                            ),
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: feedbackCounts[1].toDouble(),
                              color: const Color.fromARGB(255, 255, 154, 46),
                              width: 16,
                            ),
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: feedbackCounts[2].toDouble(),
                              color: const Color.fromARGB(255, 134, 129, 133),
                              width: 16,
                            ),
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: feedbackCounts[3].toDouble(),
                              color: const Color.fromARGB(255, 233, 35, 35),
                              width: 16,
                            ),
                          ],
                          showingTooltipIndicators: [0],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              toY: feedbackCounts[4].toDouble(),
                              color: const Color.fromARGB(255, 41, 221, 62),
                              width: 16,
                            ),
                          ],
                          showingTooltipIndicators: [0],
                        ),
                      ],
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          top: BorderSide.none,
                          right: BorderSide.none,
                          left: BorderSide(width: 1),
                          bottom: BorderSide(width: 1),
                        ),
                      ),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              switch (value.toInt()) {
                                case 0:
                                  return const Text('Very Bad',style: TextStyle(fontSize: 10),);
                                case 1:
                                  return const Text('Bad',style: TextStyle(fontSize: 10));
                                case 2:
                                  return const Text('Good',style: TextStyle(fontSize: 10));
                                case 3:
                                  return const Text('Very Good',style: TextStyle(fontSize: 10));
                                case 4:
                                  return const Text('Excellent',style: TextStyle(fontSize: 10));
                                default:
                                  return const Text('');
                              }
                            },
                          ),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1 ,
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
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

class AdminStatsCard extends StatelessWidget {
  final Map<String, dynamic> adminDetails;

  const AdminStatsCard({
    super.key,
    required this.adminDetails,
  });

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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching warnings'));
          } else {
            List<Map<String, dynamic>> warnings = snapshot.data ?? [];
            return FutureBuilder<double?>(
              future: controller.allReportResponseTime(user_email),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error fetching response times'));
                } else {
                  double? averageResponseTime = snapshot.data;

                  return Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      //color: const Color.fromARGB(255, 230, 221, 235),
                      color: Color.fromARGB(255, 238, 232, 243),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
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
                            averageResponseTime != null
                                ? 'Average Response Time: ${averageResponseTime.toStringAsFixed(2)} minutes'
                                : 'No response times available',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      
                    ),
                    
                  );
                }
              },
            );
          }
        });
  }
}