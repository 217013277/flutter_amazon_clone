import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/common/widgets/loader.dart';
import 'package:flutter_amazon_clone/features/admin/services/admin_services.dart';
import 'package:flutter_amazon_clone/features/admin/widgets/category_products_chart.dart';

import '../models/sales.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices _adminServices = AdminServices();
  int? totalEarnings;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await _adminServices.getEarnings(context);
    totalEarnings = earningData["totalEarnings"];
    earnings = earningData["sales"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalEarnings == null
        ? const Loader()
        : Column(
            children: [
              Text(
                "\$$totalEarnings",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(seriesList: [
                  charts.Series(
                      id: "Sales",
                      data: earnings!,
                      domainFn: (Sales sales, _) => sales.label,
                      measureFn: (Sales sales, _) => sales.earnings),
                ]),
              )
            ],
          );
  }
}
