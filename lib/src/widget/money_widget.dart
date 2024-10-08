import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mealgenius/src/models/content.dart';
import '../data/data.dart';

class DayMoneySpentWidget extends StatefulWidget {
  const DayMoneySpentWidget({super.key});

  @override
  State<DayMoneySpentWidget> createState() => _DayMoneySpentWidgetState();
}

class _DayMoneySpentWidgetState extends State<DayMoneySpentWidget> {
  double sum(List<String> k) {
    double sum = 0;
    for (int i = 0; i < 3; i++) {
      sum += double.parse(k[i]);
    }
    return sum;
  }

  late bool isCheaper;
  @override
  void initState() {
    super.initState();
    isCheaper = sum(todayrecipe!
            .where((element) => element.cost.runtimeType == String)
            .map((e) => e.cost)
            .toList()) >
        sum(weekday[(currentday - 2) % 7]!
            .where((element) => element.cost.runtimeType == String)
            .map((e) => e.cost)
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25)),
            color: primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 30.0, top: 15, bottom: 105),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: LineChart(
                LineChartData(
                    titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          axisNameWidget: Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Breackfeast',
                                    style: GoogleFonts.lato(color: tipo)),
                                Text('Lunch',
                                    style: GoogleFonts.lato(color: tipo)),
                                Text('Dinner',
                                    style: GoogleFonts.lato(color: tipo)),
                                Text('Snack',
                                    style: GoogleFonts.lato(color: tipo)),
                              ],
                            ),
                          ),
                        ),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        leftTitles: const AxisTitles(
                            sideTitles: SideTitles(
                                showTitles: true, reservedSize: 30))),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    minX: 0,
                    maxX: 3,
                    minY: 0,
                    maxY: double.parse(todayrecipe!
                        .reduce((value, element) => double.parse(value.cost) >
                                double.parse(element.cost)
                            ? value
                            : element)
                        .cost),
                    lineBarsData: [
                      LineChartBarData(
                          spots: [
                            FlSpot(
                                0,
                                todayrecipe![0] !=
                                        recipeContent(ingredients: [])
                                    ? double.parse(todayrecipe![0].cost)
                                    : 0),
                            FlSpot(
                                1,
                                todayrecipe![1] !=
                                        recipeContent(ingredients: [])
                                    ? double.parse(todayrecipe![1].cost)
                                    : 0),
                            FlSpot(
                                2,
                                todayrecipe![2] !=
                                        recipeContent(ingredients: [])
                                    ? double.parse(todayrecipe![2].cost)
                                    : 0),
                            FlSpot(
                                3,
                                todayrecipe![3] !=
                                        recipeContent(ingredients: [])
                                    ? double.parse(todayrecipe![3].cost)
                                    : 0)
                          ],
                          isCurved: true,
                          color: neutral,
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [neutral, primaryColor])))
                    ]),
                duration: const Duration(milliseconds: 250),
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 20,
            left: 25,
            child: Stack(
              children: [
                Container(
                  height: 80,
                  width: 310,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      gradient: primaryGradient),
                ),
                Positioned(
                  top: 15,
                  left: 20,
                  child: Text(
                    'Today',
                    style: GoogleFonts.lato(
                        color: backgroundColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: Row(
                    children: [
                      Text(
                        '€${sum(todayrecipe!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList())}',
                        style: GoogleFonts.lato(
                            color: backgroundColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        ' euro',
                        style: GoogleFonts.lato(
                            color: backgroundColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 50,
                  bottom: 30,
                  child: Row(
                    children: [
                      Text(
                        '${(sum(todayrecipe!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList()) - sum(weekday[(currentday - 2) % 7]!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList())) / sum(weekday[(currentday - 2) % 7]!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList()) * 100}% ',
                        style: GoogleFonts.lato(
                            color: backgroundColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      isCheaper == true
                          ? Image.asset('lib/img/increase.png',
                              height: 25, width: 25)
                          : Image.asset('lib/img/decrease.png',
                              height: 25, width: 25)
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }
}

class WeekMoneySpentWidget extends StatefulWidget {
  final bool dayshow;
  final int currentday;
  const WeekMoneySpentWidget(
      {required this.currentday, this.dayshow = true, super.key});

  @override
  State<WeekMoneySpentWidget> createState() => _WeekMoneySpentWidgetState();
}

class _WeekMoneySpentWidgetState extends State<WeekMoneySpentWidget> {
  double sum(List<String> k) {
    double sum = 0;
    for (int i = 0; i < 3; i++) {
      sum += double.parse(k[i]);
    }
    return sum;
  }

  late bool isCheaper;
  @override
  void initState() {
    super.initState();
    isCheaper = sum(weekday[widget.currentday]!
            .where((element) => element.cost.runtimeType == String)
            .map((e) => e.cost)
            .toList()) >
        sum(weekday[(widget.currentday - 1) % 7]!
            .where((element) => element.cost.runtimeType == String)
            .map((e) => e.cost)
            .toList());
  }

  List<String> days = ['Mon', 'Tue', 'Wen', 'Thir', 'Fri', 'Sat', 'Sun'];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
              color: backstat3, borderRadius: BorderRadius.circular(20)),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 20, left: 10),
          child: SizedBox(
              height: 125,
              width: double.infinity,
              child: LineChart(
                LineChartData(
                    titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Text('${value.toInt()}',
                                  style: GoogleFonts.lato(color: tipo2));
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                            axisNameWidget: Padding(
                                padding:
                                    const EdgeInsets.only(left: 25.0, top: 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: weekday.map((e) {
                                    return Text(
                                      days[weekday.indexOf(e)],
                                      style: GoogleFonts.lato(
                                          color: weekday.indexOf(e) ==
                                                  widget.currentday
                                              ? tipo3
                                              : tipo2,
                                          fontSize: 15),
                                    );
                                  }).toList(),
                                )))),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    lineBarsData: [
                      LineChartBarData(
                          color: linecolor,
                          belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [linecolor, backstat])),
                          isCurved: true,
                          spots: weekday.map((e) {
                            return FlSpot(
                                weekday.indexOf(e).toDouble(),
                                sum(weekday[weekday.indexOf(e)]!
                                    .where((element) =>
                                        element.cost.runtimeType == String)
                                    .map((e) => e.cost)
                                    .toList()));
                          }).toList()),
                    ]),
              )),
        ),
        Positioned(
            bottom: 20,
            left: 25,
            child: Stack(children: [
              Container(
                height: 80,
                width: 310,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    gradient: weekStatGradient),
              ),
              Positioned(
                top: 15,
                left: 20,
                child: Text(
                  widget.dayshow == true ? 'Week' : 'Today',
                  style: GoogleFonts.lato(
                      color: tipo2, fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                child: Row(
                  children: [
                    Text(
                      widget.dayshow == true
                          ? '€${weekday.fold(0.0, (previousValue, element) => previousValue + sum(element!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList()))}'
                          : '€${sum(weekday[widget.currentday]!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList())}',
                      style: GoogleFonts.lato(
                          color: backgroundColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      ' euro',
                      style: GoogleFonts.lato(
                          color: backgroundColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 50,
                bottom: 30,
                child: Row(
                  children: [
                    Text(
                      '${((sum(weekday[widget.currentday]!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList()) - sum(weekday[(widget.currentday - 1) % 7]!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList())) / sum(weekday[(widget.currentday - 1) % 7]!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList()) * 100).toStringAsFixed(1)}% ',
                      style: GoogleFonts.lato(
                          color: backgroundColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    isCheaper == true
                        ? Image.asset('lib/img/increase.png',
                            height: 25, width: 25)
                        : Image.asset('lib/img/decrease.png',
                            height: 25, width: 25)
                  ],
                ),
              )
            ]))
      ],
    );
  }
}

class MonthMoneySpentWidget extends StatefulWidget {
  const MonthMoneySpentWidget({super.key});

  @override
  State<MonthMoneySpentWidget> createState() => _MonthMoneySpentWidgetState();
}

class _MonthMoneySpentWidgetState extends State<MonthMoneySpentWidget> {
  double sum(List<String> k) {
    double sum = 0;
    for (int i = 0; i < 3; i++) {
      sum += double.parse(k[i]);
    }
    return sum;
  }

  late bool isCheaper;
  @override
  void initState() {
    super.initState();
    isCheaper = sum(todayrecipe!
            .where((element) => element.cost.runtimeType == String)
            .map((e) => e.cost)
            .toList()) >
        sum(weekday[(currentday - 2) % 7]!
            .where((element) => element.cost.runtimeType == String)
            .map((e) => e.cost)
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: themeColor3),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 20, left: 10),
          child: SizedBox(
              height: 125,
              width: double.infinity,
              child: LineChart(
                LineChartData(
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            return Text('${value.toInt()}',
                                style:
                                    GoogleFonts.lato(color: typographyColor2));
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    lineBarsData: [
                      LineChartBarData(
                          color: lineChartColor,
                          belowBarData: BarAreaData(
                              show: true, gradient: lineChartGradient),
                          isCurved: true,
                          spots: weekday.map((e) {
                            return FlSpot(
                                weekday.indexOf(e).toDouble(),
                                sum(weekday[weekday.indexOf(e)]!
                                    .where((element) =>
                                        element.cost.runtimeType == String)
                                    .map((e) => e.cost)
                                    .toList()));
                          }).toList()),
                    ]),
              )),
        ),
        Positioned(
            bottom: 20,
            left: 25,
            child: Stack(
              children: [
                Container(
                  height: 80,
                  width: 310,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: newThemeGradient),
                ),
                Positioned(
                  top: 15,
                  left: 20,
                  child: Text(
                    'This Month',
                    style: GoogleFonts.lato(
                        color: typographyColor3,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 20,
                  child: Row(
                    children: [
                      Text(
                        '€${sum(todayrecipe!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList())}',
                        style: GoogleFonts.lato(
                            color: typographyColor2,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        ' euro',
                        style: GoogleFonts.lato(
                            color: typographyColor2,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 50,
                  bottom: 30,
                  child: Row(
                    children: [
                      Text(
                        '${(sum(todayrecipe!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList()) - sum(weekday[(currentday - 2) % 7]!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList())) / sum(weekday[(currentday - 2) % 7]!.where((element) => element.cost.runtimeType == String).map((e) => e.cost).toList()) * 100}% ',
                        style: GoogleFonts.lato(
                            color: typographyColor2,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      isCheaper == true
                          ? Image.asset('lib/img/increase.png',
                              height: 25, width: 25)
                          : Image.asset('lib/img/decrease.png',
                              height: 25, width: 25)
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }
}
