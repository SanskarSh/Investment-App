class UserModel {
  final String name;
  final int age;
  final double income;
  final double expenses;
  final int retirementAge;
  final double savingsGoal;

  UserModel(
      {required this.name,
      required this.age,
      required this.income,
      required this.expenses,
      required this.retirementAge,
      required this.savingsGoal});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'monthlyIncome': income,
      'monthlyExpenses': expenses,
      'retirementAge': retirementAge,
      'savingGoal': savingsGoal,
    };
  }
}
