import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../model/sale_chart_model.dart';
import '../../../view_model/home_viewmodel.dart';

class RevenueChartScreen extends StatelessWidget {

   RevenueChartScreen({super.key});
  final salon = Get.find<HomeViewmodel>();
  List<FlSpot> generateFlSpots(List<SalesDatum> jsonList) {
  return List.generate(jsonList.length, (index) {
    final item = jsonList[index];
    final price = double.tryParse(item.price ?? '0') ?? 0;
    return FlSpot(index.toDouble(), price); // x = index, y = price
  });
}
void _showDatePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Date Range'),
          content: SizedBox(
            height: 300,
            width: 300,
            child: SfDateRangePicker(
              onSelectionChanged: salon.onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                DateTime.now().subtract(const Duration(days: 3)),
                DateTime.now().add(const Duration(days: 3)),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // print(salon.startDate.value);
                // print(salon.endDate.value);
                salon.saleChart(fromDate:DateFormat("yyyy-MM-dd").format(salon.startDate.value??DateTime.now()),toDate: DateFormat("yyyy-MM-dd").format(salon.endDate.value??DateTime.now()),isload: true);
                Navigator.pop(context); // close the dialog
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        ()=>salon.isLoading.value?SizedBox(): Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Revenue',
                        style: GoogleFonts.montserrat(fontWeight: FontWeight.w700, fontSize: 18.sp,color: Color(0xFF002B5B)),
                      ),
                      ElevatedButton(onPressed: (){
                        _showDatePickerDialog(context);
                      }, child: Text("Custom",style: GoogleFonts.montserrat(color: Colors.white,fontWeight:FontWeight.bold),))
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 250.h,
                    child: LineChart(
                      LineChartData(
                        lineTouchData: LineTouchData(
                          enabled: true,
                          touchTooltipData: LineTouchTooltipData(
                            // tooltipBgColor: Colors.black.withOpacity(0.8),
                            getTooltipItems: (touchedSpots) {
                              return touchedSpots.map((spot) {
                                return LineTooltipItem(
                                  '${spot.y.toStringAsFixed(0)}', // Show Y value here
                                  // children: [
                                  //   TextSpan(
                                  //     text: '\n${DateTime.parse(salon.revenueChart.value.data?.salesData?[spot.x.toInt()].createdAt ?? '').day}',
                                  //     style: const TextStyle(fontSize: 12, color: Colors.white),
                                  //   ),
                                  // ],
                                  const TextStyle(color: Colors.white),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        extraLinesData: ExtraLinesData(
                            verticalLines: [
                              VerticalLine(
                                x: 0,
                                color: Color(0xFF002B5B),
                                strokeWidth: 2,
                                // dashArray: [6, 3],
                              ),
                            ],
                          ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                var labels = salon.revenueChart.value.data?.salesData?.map((e) => e.createdAt).toList() ?? [];
                                if (value.toInt() < labels.length) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text("${ DateTime.parse(labels[value.toInt()]??"").day.toString()}", style: const TextStyle(fontSize: 12)),
                                  );
                                }
                                return const Text('');
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              reservedSize: 40,
                              showTitles: true, interval: 100
                              ),
                          ),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        minY: 0,
                        maxY: 500,
                        lineBarsData: [
                          LineChartBarData(
                            isCurved: false,
                            color: Color(0xFF002B5B),
                            dotData: FlDotData(show: true),
                            spots:generateFlSpots( salon.revenueChart.value.data?.salesData??[]), 
                            // spots: const [
                            //   FlSpot(0, 50),
                            //   FlSpot(1, 180),
                            //   FlSpot(2, 250),
                            //   FlSpot(3, 370),
                            //   FlSpot(4, 430),
                            // ],
                          ),
                          
                          LineChartBarData(
                            isCurved: false,
                            // isStrokeCapRound: true,
                            // barWidth: 2,
                            
                            color: Colors.green,
                            dotData: FlDotData(show: true),
                            show: true,
                            spots: const [
                              FlSpot(0, 0),
                              FlSpot(1, 0),
                              FlSpot(2, 0),
                              FlSpot(3, 0),
                              FlSpot(4, 0),
                              FlSpot(5, 0),
                            ],
                          ),
                        ],
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(show: false),
                      ),
                      
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
