
enum ResourceType {
  fish,
  wood,
  gold,
  stone;

  static bool checkIfExists({required String recourceType}){
    return ResourceType.values.any((e) => e.name == recourceType);
  }

  static ResourceType get({required String recourceType}){
    return ResourceType.values.singleWhere((e) => e.name == recourceType);
  }  
}
