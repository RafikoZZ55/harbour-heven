enum DifficultyType {
  easy,
  medium,
  hard,
  extreme;

  static bool checkIfExists({required String difficultyType}){
    return DifficultyType.values.any((e) => e.name == difficultyType);
  }

  DifficultyType get({required String difficultyType}){
    return DifficultyType.values.singleWhere((e) => e.name == difficultyType);
  }  
}