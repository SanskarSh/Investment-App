
import 'package:flutter/material.dart';
import 'package:investment_app/src/features/home/presenter/widget/category_card.dart';
import 'package:ionicons/ionicons.dart';

List<Widget> catigoryData = [
  const CategoryCard(
    icon: Ionicons.home_outline,
    color: Color.fromRGBO(111, 70, 245, 1),
    title: "Housing",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.car_outline,
    color: Color.fromRGBO(241, 160, 65, 1),
    title: "Transportation",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.restaurant_outline,
    color: Color.fromRGBO(225, 65, 165, 1),
    title: "Food & Groceries",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.fitness_outline,
    color: Color.fromRGBO(80, 165, 250, 1),
    title: "Health & Wellness",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.shield_checkmark_outline,
    color: Color.fromRGBO(240, 160, 65, 1),
    title: "Insurance",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.card_outline,
    color: Color.fromRGBO(121, 220, 121, 1),
    title: "Debt Payments",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.trending_up_outline,
    color: Color.fromRGBO(255, 193, 7, 1),
    title: "Savings & Investments",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.play_circle_outline,
    color: Color.fromRGBO(255, 87, 34, 1),
    title: "Entertainment & Recreation",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.wifi_outline,
    color: Color.fromRGBO(76, 175, 80, 1),
    title: "Utilities & Services",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.school_outline,
    color: Color.fromRGBO(33, 150, 243, 1),
    title: "Education",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.shirt_outline,
    color: Color.fromRGBO(156, 39, 176, 1),
    title: "Personal Spending",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.people_outline,
    color: Color.fromRGBO(103, 58, 183, 1),
    title: "Family & Children",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.ellipsis_horizontal_circle_outline,
    color: Color.fromRGBO(63, 81, 181, 1),
    title: "Miscellaneous",
    amount: "＄ 0.00",
  ),
  const CategoryCard(
    icon: Ionicons.receipt_outline,
    color: Color.fromRGBO(233, 30, 99, 1),
    title: "Taxes",
    amount: "＄ 0.00",
  ),
];