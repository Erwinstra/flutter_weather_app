import 'package:flutter/material.dart';
import '../models/constant.dart';
import '../models/city.dart';

class ChooseLocations extends StatefulWidget {
  const ChooseLocations({super.key});

  @override
  State<ChooseLocations> createState() => _ChooseLocationsState();
}

class _ChooseLocationsState extends State<ChooseLocations> {
  @override
  Widget build(BuildContext context) {
    List<City> cities =
        City.citiesList.where((city) => city.isDefault == false).toList();
    List<City> selectedCities = City.getSelectedCities();

    final Constant myColor = Constant();
    // Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedCities.isNotEmpty
              ? '${selectedCities.length} selected'
              : 'Choose a Location',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: myColor.primaryColor,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: cities.length,
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        itemBuilder: (context, index) {
          // is checklist or nah
          bool isCheck = cities[index].isSelected;

          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            checkboxShape: const CircleBorder(),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: isCheck ? myColor.primaryColor : Colors.white,
              ),
            ),
            tileColor: myColor.tileColor,
            side: BorderSide(color: myColor.primaryColor),
            activeColor: myColor.primaryColor,
            fillColor:
                isCheck ? MaterialStatePropertyAll(myColor.primaryColor) : null,
            value: isCheck,
            secondary: CircleAvatar(
              backgroundImage: AssetImage('assets/${cities[index].image}'),
            ),

            // Change value with the opposite when get clicked
            onChanged: (boolValue) {
              setState(() {
                cities[index].isSelected = !cities[index].isSelected;
              });
            },
            title: Text(
              cities[index].name,
              style: TextStyle(
                color: isCheck ? myColor.primaryColor : Colors.black54,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
        backgroundColor: myColor.primaryColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.pin_drop,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
