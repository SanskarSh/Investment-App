import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:investment_app/src/config/routes/app_route_const.dart';
import 'package:investment_app/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:investment_app/src/features/register/data/registration_api_service.dart';
import 'package:investment_app/src/features/register/model/user_model.dart';
import 'package:ionicons/ionicons.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final AuthServices _auth = AuthServices();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _expensesController = TextEditingController();
  final TextEditingController _retirementAgeController =
      TextEditingController();
  final TextEditingController _savingsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _incomeController.dispose();
    _expensesController.dispose();
    _retirementAgeController.dispose();
    _savingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _ageController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _incomeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Monthly Income',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _expensesController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Monthly Expenses',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _retirementAgeController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Retirement Age',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _savingsController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Savings Goal',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor:
                        Theme.of(context).colorScheme.secondary.withOpacity(.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (double.tryParse(_ageController.text) != null &&
                          double.tryParse(_incomeController.text) != null &&
                          double.tryParse(_expensesController.text) != null &&
                          double.tryParse(_retirementAgeController.text) !=
                              null) {
                        registerUser(
                          UserModel(
                            name: _nameController.text,
                            age: int.parse(_ageController.text),
                            income: double.parse(_incomeController.text),
                            expenses: double.parse(_expensesController.text),
                            retirementAge:
                                int.parse(_retirementAgeController.text),
                            savingsGoal: double.parse(_savingsController.text),
                          ),
                        ).then(
                          (value) {
                            if (value == 200) {
                              context.pushReplacementNamed(RouteNames.splash);
                              showTopSnackBar(
                                Overlay.of(context),
                                const CustomSnackBar.success(
                                    message: "Welcome Onboard"),
                              );
                            } else {
                              showTopSnackBar(
                                Overlay.of(context),
                                const CustomSnackBar.error(
                                    message: "Facing issue registering"),
                              );
                            }
                          },
                        );
                      }
                    }
                  },
                  child: Text(
                    'Submit',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _auth.signOut();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.caret_back,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(.5),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Go Back',
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(.5),
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
