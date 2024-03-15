import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  final scrollController = ScrollController();
  final searchController = TextEditingController();
}
