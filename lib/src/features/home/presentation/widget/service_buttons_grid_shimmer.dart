import 'package:bato_mechanic/src/features/services/presentation/widgets/service_type_button_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/managers/values_manager.dart';

class ServiceButtonsGridShimmerWidget extends StatelessWidget {
  const ServiceButtonsGridShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p8,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: AppPadding.p4,
          mainAxisSpacing: AppPadding.p12,
        ),
        itemCount: 4,
        itemBuilder: (ctx, idx) => const ServiceTypeButtonShimmerWidget());
  }
}
