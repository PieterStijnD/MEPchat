List<String> recipeParser(List<String> list) {
  // regular expression that separates the measurement, unit and ingredient
  RegExp exp = RegExp(r"(\d+\.\d+|\d+)\s*([a-zA-Z]+)\s*(.*)");

  List<String> newList = [];
  print("IM TRYING OVER HERE");
  for (String recipeText in list) {
    print("RecipeText: $recipeText");
    Match? match = exp.firstMatch(recipeText);
    print("Match: $match");
    if (match == null) {
      print("THAT DIDNT WORK DADDY");
      newList.add(recipeText);
    }
    if (match != null) {
      String? measurement = match.group(1);
      String? unit = match.group(3);
      String? ingredient = match.group(5);
      print("Measurement: $measurement");
      print("Unit: $unit");
      print("Ingredient: $ingredient");

      newList.add(measurement!);
      newList.add(unit!);
      newList.add(ingredient!);
    }
  }
  print("NewList: $newList");
  return newList;
}
