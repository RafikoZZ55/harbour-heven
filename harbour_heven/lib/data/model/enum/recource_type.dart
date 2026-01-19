
enum RecourceType {
  fish,
  wood,
  gold,
  stone;

  static bool checkIfExists({required String recourceType}){
    return RecourceType.values.any((e) => e.name == recourceType);
  }

  RecourceType get({required String recourceType}){
    return RecourceType.values.singleWhere((e) => e.name == recourceType);
  }  
}
