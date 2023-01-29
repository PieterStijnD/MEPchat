List<String> recipeParser(String ingredient) {
  // regular expression that separates the measurement, unit and ingredient
  RegExp exp = RegExp(r"(\d+\.\d+|\d+)\s*([a-zA-Z]+)\s*(.*)");

  List<String> newList = [];
  Match? match = exp.firstMatch(ingredient);
  if (match == null) {
    newList.add(ingredient);
  }
  if (match != null) {
    String? measurement = match.group(1);
    String? unit = match.group(2);
    String? ingredient = match.group(3);
    print("Measurement: $measurement");
    print("Unit: $unit");
    print("Ingredient: $ingredient");

    newList.add(measurement!);
    newList.add(unit!);
    newList.add(ingredient!);
  }
  return newList;
}
