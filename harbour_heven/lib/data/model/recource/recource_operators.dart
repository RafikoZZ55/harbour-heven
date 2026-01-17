import 'package:harbour_heven/data/model/recource/recource.dart';

extension RecourceOperators on Recource {
  void add({required int amount, required int capacity}) {
    quantity += amount.clamp(0, capacity - quantity);
  }

  void spend({required int amount}) {
    if(!hasEnough(amount: amount)) return;
    quantity -= amount;
  }

  bool hasEnough({required int amount}) {
    return amount <= quantity;
  }
}