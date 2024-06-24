import 'package:flutter/material.dart';
import 'package:investment_app/src/features/explore_feed/model/module_model.dart';

class Quiz extends StatefulWidget {
  final Function(int) onOptionSelected;
  final QuizModel quizModel;

  const Quiz({
    super.key,
    required this.onOptionSelected,
    required this.quizModel,
  });

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int? selectedOption;

  @override
  void didUpdateWidget(covariant Quiz oldWidget) {
    super.didUpdateWidget(oldWidget);
    selectedOption;
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
              widget.quizModel.question,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.quizModel.options.length,
            itemBuilder: (context, index) {
              return buildOption(
                context,
                widget.quizModel.options,
                index,
              );
            },
          ),
        ],
      ),
    );
  }

  Card buildOption(BuildContext context, List<String> option, int value) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.onPrimary,
      child: RadioListTile(
        activeColor: Theme.of(context).colorScheme.secondary,
        selectedTileColor: Theme.of(context).colorScheme.secondary,
        tileColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          option[value],
          style: Theme.of(context).textTheme.displaySmall,
        ),
        value: value,
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value;
            widget.onOptionSelected(value!);
          });
        },
      ),
    );
  }
}
