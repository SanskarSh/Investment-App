import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:investment_app/src/features/home/presenter/widget/category_card.dart';
import 'package:ionicons/ionicons.dart';

List<Widget> catigoryData = [
  const CategoryCard(
    icon: Ionicons.home_outline,
    color: Color.fromRGBO(111, 70, 245, 1),
    title: "Housing",
    amount: "₹18000.00",
  ),
  const CategoryCard(
    icon: Ionicons.car_outline,
    color: Color.fromRGBO(241, 160, 65, 1),
    title: "Transportation",
    amount: "₹ 2000.00",
  ),
  const CategoryCard(
    icon: Ionicons.restaurant_outline,
    color: Color.fromRGBO(225, 65, 165, 1),
    title: "Food & Groceries",
    amount: "₹ 20.00",
  ),
  const CategoryCard(
    icon: Ionicons.fitness_outline,
    color: Color.fromRGBO(80, 165, 250, 1),
    title: "Health & Wellness",
    amount: "₹ 2784.00",
  ),
  const CategoryCard(
    icon: Ionicons.shield_checkmark_outline,
    color: Color.fromRGBO(240, 160, 65, 1),
    title: "Insurance",
    amount: "₹ 1200.00",
  ),
  const CategoryCard(
    icon: Ionicons.card_outline,
    color: Color.fromRGBO(121, 220, 121, 1),
    title: "Debt Payments",
    amount: "₹ 10,000",
  ),
  const CategoryCard(
    icon: Ionicons.trending_up_outline,
    color: Color.fromRGBO(255, 193, 7, 1),
    title: "Savings & Investments",
    amount: "₹ 30,000",
  ),
  const CategoryCard(
    icon: Ionicons.play_circle_outline,
    color: Color.fromRGBO(255, 87, 34, 1),
    title: "Entertainment & Recreation",
    amount: "₹ 250.00",
  ),
  const CategoryCard(
    icon: Ionicons.wifi_outline,
    color: Color.fromRGBO(76, 175, 80, 1),
    title: "Utilities & Services",
    amount: "₹ 469.00",
  ),
  const CategoryCard(
    icon: Ionicons.school_outline,
    color: Color.fromRGBO(33, 150, 243, 1),
    title: "Education",
    amount: "₹ 10.00",
  ),
  const CategoryCard(
    icon: Ionicons.shirt_outline,
    color: Color.fromRGBO(156, 39, 176, 1),
    title: "Personal Spending",
    amount: "₹ 6000.00",
  ),
  const CategoryCard(
    icon: Ionicons.people_outline,
    color: Color.fromRGBO(103, 58, 183, 1),
    title: "Family & Children",
    amount: "₹ 798.00",
  ),
  const CategoryCard(
    icon: Ionicons.ellipsis_horizontal_circle_outline,
    color: Color.fromRGBO(63, 81, 181, 1),
    title: "Miscellaneous",
    amount: "₹ 783.00",
  ),
  const CategoryCard(
    icon: Ionicons.receipt_outline,
    color: Color.fromRGBO(233, 30, 99, 1),
    title: "Taxes",
    amount: "₹ 5000.00",
  ),
];

List<Map<String, dynamic>> categoryMapData = [
  {
    "icon": Ionicons.home_outline,
    "color": const Color.fromRGBO(111, 70, 245, 1),
    "title": "Housing",
    "amount": "₹ 18000.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.car_outline,
    "color": const Color.fromRGBO(241, 160, 65, 1),
    "title": "Transportation",
    "amount": "₹ 200.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.restaurant_outline,
    "color": const Color.fromRGBO(225, 65, 165, 1),
    "title": "Food & Groceries",
    "amount": "₹ 20.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.fitness_outline,
    "color": const Color.fromRGBO(80, 165, 250, 1),
    "title": "Health & Wellness",
    "amount": "₹ 2784.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.shield_checkmark_outline,
    "color": const Color.fromRGBO(240, 160, 65, 1),
    "title": "Insurance",
    "amount": "₹ 1200.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.card_outline,
    "color": const Color.fromRGBO(121, 220, 121, 1),
    "title": "Debt Payments",
    "amount": "₹ 10,000.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.trending_up_outline,
    "color": const Color.fromRGBO(255, 193, 7, 1),
    "title": "Savings & Investments",
    "amount": "₹ 30,000.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.play_circle_outline,
    "color": const Color.fromRGBO(255, 87, 34, 1),
    "title": "Entertainment & Recreation",
    "amount": "₹ 250.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.wifi_outline,
    "color": const Color.fromRGBO(76, 175, 80, 1),
    "title": "Utilities & Services",
    "amount": "₹ 469.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.school_outline,
    "color": const Color.fromRGBO(33, 150, 243, 1),
    "title": "Education",
    "amount": "₹ 10.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.shirt_outline,
    "color": const Color.fromRGBO(156, 39, 176, 1),
    "title": "Personal Spending",
    "amount": "₹ 6000.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.people_outline,
    "color": const Color.fromRGBO(103, 58, 183, 1),
    "title": "Family & Children",
    "amount": "₹ 798.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.ellipsis_horizontal_circle_outline,
    "color": const Color.fromRGBO(63, 81, 181, 1),
    "title": "Miscellaneous",
    "amount": "₹ 783.00",
    "date": _generateRandomDate(),
  },
  {
    "icon": Ionicons.receipt_outline,
    "color": const Color.fromRGBO(233, 30, 99, 1),
    "title": "Taxes",
    "amount": "₹ 5000.00",
    "date": _generateRandomDate(),
  },
];

String _generateRandomDate() {
  final startDate = DateTime(2024, 5, 10);
  final endDate = DateTime(2024, 6, 23);
  final random = Random();
  final randomDate = startDate.add(
      Duration(days: random.nextInt(endDate.difference(startDate).inDays)));
  final formattedDate = DateFormat('d MMM yyyy').format(randomDate);
  return formattedDate;
}
