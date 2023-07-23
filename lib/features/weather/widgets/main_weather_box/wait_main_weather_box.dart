import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../common/loading_indicator.dart';

class WaitMainWeatherBox extends StatelessWidget {
  const WaitMainWeatherBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 195,
          width: double.infinity,
          child: Card(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 25,
                  sigmaY: 25,
                ),
                child: const LoadingIndicator(),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            height: 112.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return const Card(
                  child: SizedBox(
                    height: 105,
                    width: 105,
                    child: LoadingIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
