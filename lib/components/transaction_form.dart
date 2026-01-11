import 'package:expenses/components/adaptative_button.dart';
import 'package:expenses/components/adaptative_date_picker.dart';
import 'package:expenses/components/adaptative_input.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm({super.key, required this.onSubmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _onSubmit() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final paddingButton = MediaQuery.of(context).viewInsets.bottom + 10;

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: paddingButton,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AdaptativeInput(
                label: "Titulo:",
                isValueNumber: false,
                onPressed: _onSubmit,
                inputController: _titleController,
              ),
              AdaptativeInput(
                label: "Valor R\$:",
                isValueNumber: true,
                onPressed: _onSubmit,
                inputController: _valueController,
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onChagedDate: (newDateTime) {
                  setState(() {
                    _selectedDate = newDateTime;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: () => _onSubmit(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
