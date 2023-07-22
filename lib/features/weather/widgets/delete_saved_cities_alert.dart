import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAllSavedCitiesAlert extends StatelessWidget {
  const DeleteAllSavedCitiesAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Are you sure?",
                style: TextStyle(fontSize: 20),
              ),
              const Text(
                "This will delete all Saved Cities!",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setStringList("savedCities", []);

                      Navigator.of(context).pop();
                    },
                    child: const Text("Yes"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("No"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
