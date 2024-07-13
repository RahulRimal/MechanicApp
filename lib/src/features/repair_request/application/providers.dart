import 'package:bato_mechanic/src/features/services/domain/service/service.dart';
import 'package:bato_mechanic/src/features/vehicle_category/domain/vehicle_category/vehicle_category.dart';
import 'package:bato_mechanic/src/features/vehicle_part/domain/vehicle_part/vehicle_part.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/vehicle_repair_request.dart';

part 'providers.g.dart';

// @riverpod
// class SelectedVehicleCategory extends _$SelectedVehicleCategory {
//   @override
//   VehicleCategory? build() {
//     return null;
//   }

//   void setSelectedCategory(VehicleCategory category) {
//     state = category;
//   }
// }

@riverpod
class ActiveRepairRequest extends _$ActiveRepairRequest {
  @override
  VehicleRepairRequest? build() {
    return null;
  }

  void setActiveRepairRequest(VehicleRepairRequest? request) {
    state = request;
  }
}

class SelectedVehicleCategory extends Notifier<VehicleCategory?> {
  @override
  VehicleCategory? build() {
    return null;
  }

  void setSelectedCategory(VehicleCategory category) {
    state = category;
  }
}

final selectedVehicleCategoryProvider =
    NotifierProvider<SelectedVehicleCategory, VehicleCategory?>(() {
  return SelectedVehicleCategory();
});

@riverpod
class SelectedVehiclePart extends _$SelectedVehiclePart {
  @override
  VehiclePart? build() {
    return null;
  }
}

// @riverpod
// class SelectedService extends _$SelectedService {
//   @override
//   Service? build() {
//     return null;
//   }

//   void setSelectedService(Service service) {
//     state = service;
//   }
// }

class SelectedService extends Notifier<Service?> {
  @override
  Service? build() {
    return null;
  }

  void setSelectedService(Service service) {
    state = service;
  }
}

final selectedServiceProvider = NotifierProvider<SelectedService, Service?>(() {
  return SelectedService();
});
