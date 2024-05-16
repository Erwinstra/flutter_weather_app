class City {
  bool isSelected;
  final String name;
  final String country;
  final bool isDefault;
  final String image;

  City({
    required this.isSelected,
    required this.name,
    required this.country,
    required this.isDefault,
    required this.image,
  });

  static List<City> citiesList = [
    City(
      isSelected: false,
      name: 'Jakarta',
      country: 'Indonesia',
      isDefault: true,
      image: 'indonesia.png',
    ),
    City(
      isSelected: false,
      name: 'London',
      country: 'United Kindgom',
      isDefault: false,
      image: 'england.png',
    ),
    City(
      isSelected: false,
      name: 'Tokyo',
      country: 'Japan',
      isDefault: false,
      image: 'japan.png',
    ),
    City(
      isSelected: false,
      name: 'Cairo',
      country: 'Egypt',
      isDefault: false,
      image: 'egypt.png',
    ),
    City(
      isSelected: false,
      name: 'Moscow',
      country: 'Russia',
      isDefault: false,
      image: 'russia.png',
    ),
    City(
      isSelected: false,
      name: 'Miami',
      country: 'United States',
      isDefault: false,
      image: 'usa.png',
    ),
    City(
      isSelected: false,
      name: 'Seoul',
      country: 'South Korea',
      isDefault: false,
      image: 'south-korea.png',
    ),
    City(
      isSelected: false,
      name: 'Berlin',
      country: 'Germany',
      isDefault: false,
      image: 'germany.png',
    ),
    City(
      isSelected: false,
      name: 'Riyadh',
      country: 'Sauid Arabia',
      isDefault: false,
      image: 'saudi-arabia.png',
    ),
    City(
      isSelected: false,
      name: 'Istanbul',
      country: 'Turkey',
      isDefault: false,
      image: 'turkey.png',
    ),
  ];

  //Get the selected cities
  static List<City> getSelectedCities() {
    List<City> selectedCities = City.citiesList;
    return selectedCities.where((city) => city.isSelected).toList();
  }
}
