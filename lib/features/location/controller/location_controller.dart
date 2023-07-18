import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/features/location/repository/location_repository.dart';

final locationControllerProvider =
    StateNotifierProvider((ref) => LocationController(
          locationRepository: ref.read(locationRepositoryProvider),
        ));

class LocationController extends StateNotifier {
  final LocationRepository _locationRepository;

  LocationController({required locationRepository})
      : _locationRepository = locationRepository,
        super(false);

  Future<String> getCurrentCity() async {
    final result = await _locationRepository.getCurrentCity();

    switch (result) {
      case "disabled":
        return "Location services disabled";
      case "disabled_forever":
        return "Location permission permanently denied.";
      case "error":
        return "Some error occurred.";
      default:
        return result;
    }
  }
}
