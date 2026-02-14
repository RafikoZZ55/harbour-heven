
enum ResourceType {
  fish(icon: "🐟"),
  wood(icon: "🌳"),
  gold(icon: "🪙"),
  stone(icon: "🪨");

  final String icon;

  const ResourceType({
    required this.icon
  });

  static bool checkIfExists({required String recourceType}){
    return ResourceType.values.any((e) => e.name == recourceType);
  }

  static ResourceType get({required String recourceType}){
    return ResourceType.values.singleWhere((e) => e.name == recourceType);
  }  
}
