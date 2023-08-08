import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/features/notification/repository/notification_repository.dart';

final notificationControllerProvider =
    StateNotifierProvider((ref) => NotificationController(
          notificationRepository: ref.read(notificationRepositoryProvider),
        ));

class NotificationController extends StateNotifier {
  final NotificationRepository _notificationRepository;

  NotificationController({required notificationRepository})
      : _notificationRepository = notificationRepository,
        super(false);

  void setScheduleNotification(BuildContext context, String cityName,
      Duration repeat, int hour, int minutes) async {
    final result = await _notificationRepository.setScheduleNotification(
      cityName,
      repeat,
      hour,
      minutes,
    );

    if (result == "success") {
      if (mounted) {
        _giveFeedback(context, "Notification created.");
      }
    } else if (result == "no_permission") {
      if (mounted) {
        _giveFeedback(
            context, "Couldn't get permission for sending notification.");
      }
    } else if (result == "already_has_city") {
      if (mounted) {
        _giveFeedback(context, "$cityName already has notification.");
      }
    } else if (result == "android_alarm_false") {
      if (mounted) {
        _giveFeedback(context, "Got an error while creating notification.");
      }
    } else {
      if (mounted) {
        _giveFeedback(context, "Some unknown error occurred.");
      }
    }
  }

  void removeScheduleNotification(
      BuildContext context, List<String> cities) async {
    final result =
        await _notificationRepository.removeScheduleNotification(cities);

    if (result == "success") {
      if (mounted) {
        _giveFeedback(context, "Notification removed.");
      }
    } else if (result == "android_alarm_false") {
      if (mounted) {
        _giveFeedback(context, "Got an error while removing notification.");
      }
    } else {
      if (mounted) {
        _giveFeedback(context, "Some unknown error occurred.");
      }
    }
  }
}

// giving proper feedbacks
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _giveFeedback(
    BuildContext context, String content) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(content),
    ),
  );
}
