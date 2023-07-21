import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/constants/constants.dart';

class CityTile extends ConsumerWidget {
  final String city;
  final String country;
  final Function selectCity;
  final bool isSelected;

  const CityTile({
    required this.city,
    required this.country,
    required this.isSelected,
    required this.selectCity,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 24,
      color: Colors.deepPurple.shade300,
    );

    return ListTile(
      onTap: () => selectCity(ref, city),
      title: Row(
        children: [
          SizedBox(
              height: 44,
              child: Image.asset("assets/icons/flags/$country.png")),
          const SizedBox(width: 10),
          Text(
            city,
            style: isSelected
                ? textStyle
                : const TextStyle(
                    fontSize: 24,
                  ),
          ),
        ],
      ),
      trailing: isSelected
          ? Icon(
              Icons.check,
              color: Colors.deepPurple.shade300,
            )
          : null,
    );
  }
}
