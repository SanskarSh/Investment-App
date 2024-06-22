import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  const Quiz({
    super.key,
    required this.onOptionSelected,
    required this.title,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
  });

  final Function(int) onOptionSelected;

  final String title;

  final String option1;
  final String option2;
  final String option3;
  final String option4;

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int? selectedOption;

  @override
  void didUpdateWidget(covariant Quiz oldWidget) {
    super.didUpdateWidget(oldWidget);
    selectedOption = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
                width: 2,
              ),
            ),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.onPrimary,
            child: RadioListTile(
              activeColor: Theme.of(context).colorScheme.secondary,
              selectedTileColor: Theme.of(context).colorScheme.secondary,
              tileColor: Theme.of(context).colorScheme.onPrimary,
              title: Text(
                widget.option1,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              value: 1,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                  widget.onOptionSelected(value!);
                });
              },
            ),
          ),
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.onPrimary,
            child: RadioListTile(
              activeColor: Theme.of(context).colorScheme.secondary,
              selectedTileColor: Theme.of(context).colorScheme.secondary,
              tileColor: Theme.of(context).colorScheme.onPrimary,
              title: Text(
                widget.option2,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              value: 2,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                  widget.onOptionSelected(value!);
                });
              },
            ),
          ),
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.onPrimary,
            child: RadioListTile(
              activeColor: Theme.of(context).colorScheme.secondary,
              selectedTileColor: Theme.of(context).colorScheme.secondary,
              tileColor: Theme.of(context).colorScheme.onPrimary,
              title: Text(
                widget.option3,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              value: 3,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                  widget.onOptionSelected(value!);
                });
              },
            ),
          ),
          Card(
            elevation: 0,
            color: Theme.of(context).colorScheme.onPrimary,
            child: RadioListTile(
              activeColor: Theme.of(context).colorScheme.secondary,
              selectedTileColor: Theme.of(context).colorScheme.secondary,
              tileColor: Theme.of(context).colorScheme.onPrimary,
              title: Text(
                widget.option4,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              value: 4,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value;
                  widget.onOptionSelected(value!);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
