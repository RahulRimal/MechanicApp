import 'package:bato_mechanic/src/shared/widgets/async_value_widget.dart';
import 'package:bato_mechanic/src/features/repair_request/application/providers.dart';
import 'package:bato_mechanic/src/shared/utils/constants/managers/color_manager.dart';
import 'package:bato_mechanic/src/routing/app_router.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/constants/managers/values_manager.dart';
import '../../data/vehicle_repository/vehicle_repository.dart';

class VehiclesScreen extends ConsumerWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedVehicleCategoryProvider);
    final vehiclesValue = ref.watch(
        fetchVehiclesByCategoryProvider(selectedCategory!.idx.toString()));
    return Scaffold(
        body: AsyncValueWidget(
      value: vehiclesValue,
      data: (vehicles) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 200,
              ),
              Text(
                'Select your vehicle to repair'.hardcoded(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: vehicles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    context.goNamed(APP_ROUTE.parts.name);
                  },
                  child: Card(
                    margin: const EdgeInsets.all(AppMargin.m8),
                    child: Padding(
                      padding: const EdgeInsets.all(AppMargin.m8),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              vehicles[index].image,
                              width: AppWidth.h150,
                            ),
                            Flexible(
                              child: Text(
                                vehicles[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(color: ThemeColor.black),
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
