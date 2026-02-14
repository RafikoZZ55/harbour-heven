import 'package:flutter/material.dart';
import 'package:harbour_heven/data/model/enum/resource_type.dart';


class ResourceDisplayCard extends StatelessWidget {
const ResourceDisplayCard({ super.key, required this.resourceType, required this.amount });
  final ResourceType resourceType;
  final int amount;
  @override
  Widget build(BuildContext context){
    return SizedBox(
      child: Text("${resourceType.icon}: $amount"),
    );
  }
}