import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CityTile extends ConsumerWidget {
  // city name
  final String city;
  // country code
  final String country;
  // function to select city
  final Function selectCity;
  // control if city is selected
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
      fontSize: 20,
      color: Colors.deepPurple.shade300,
    );

    return ListTile(
      onTap: () => selectCity(city),
      title: Row(
        children: [
          SizedBox(
            height: 44,
            child: Image.asset("assets/icons/flags/$country.png"),
          ),
          const SizedBox(width: 10),
          Text(
            city,
            style: isSelected
                ? textStyle
                : const TextStyle(
                    fontSize: 20,
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
