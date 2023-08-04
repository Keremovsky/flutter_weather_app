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

  // getting name of current city name
  Future<String> getCurrentCity() async {
    final result = await _locationRepository.getCurrentCity();

    return result;
  }
}
