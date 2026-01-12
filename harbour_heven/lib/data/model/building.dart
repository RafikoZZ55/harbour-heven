
abstract class Building {
int level;
String name;
double price;
String description;

Building({
  required this.level,
  required this.name,
  required this.description,
  required this.price,
});

double calculateNextLevelCost();

}