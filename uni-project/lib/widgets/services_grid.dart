import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/service_item.dart';
import '../models/all_services_response.dart';
import './addition_item_in_grid.dart';
//ignore_for_file: prefer_const_constructors

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final servicesData = Provider.of<Services>(context);

    final services = servicesData.items;
    return Container(
      height: MediaQuery.of(context).size.height,
      child: (GridView.builder(
        padding: const EdgeInsets.all(15.0),
        itemCount: services.length + 1,
        itemBuilder: (ctx, i) => i == services.length
            ? AdditionItem()
            : ChangeNotifierProvider.value(
                value: services[i],
                child: ServiceItem(),
              ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
      )),
    );
  }
}
