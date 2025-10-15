import 'package:animation/features/finances_view/viewmodel/finances_view_viewmodel.dart';
import 'package:flutter/material.dart';

class EditSalesEventDialog extends StatefulWidget {
  final SalesEvent event;
  const EditSalesEventDialog({super.key, required this.event});

  @override
  State<EditSalesEventDialog> createState() => _EditSalesEventDialogState();
}

class _EditSalesEventDialogState extends State<EditSalesEventDialog> {
  late TextEditingController titleController;
  late TextEditingController dateController;
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.event.title);
    dateController = TextEditingController(text: widget.event.date);
    amountController = TextEditingController(text: widget.event.amount);
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Sales Event'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: dateController, decoration: const InputDecoration(labelText: 'Date')),
            TextField(controller: amountController, decoration: const InputDecoration(labelText: 'Amount')),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(
              context,
              SalesEvent(
                title: titleController.text,
                date: dateController.text,
                amount: amountController.text, 
                id: '', 
                boothId: '',
              ),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class EditExpenseEventDialog extends StatefulWidget {
  final ExpenseEvent event;
  const EditExpenseEventDialog({super.key, required this.event});

  @override
  State<EditExpenseEventDialog> createState() => _EditExpenseEventDialogState();
}

class _EditExpenseEventDialogState extends State<EditExpenseEventDialog> {
  late TextEditingController titleController;
  late TextEditingController dateController;
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.event.title);
    dateController = TextEditingController(text: widget.event.date);
    amountController = TextEditingController(text: widget.event.amount);
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Expense Event'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: dateController,
              decoration: const InputDecoration(labelText: 'Date'),
            ),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(
              context,
              ExpenseEvent(
                title: titleController.text,
                date: dateController.text,
                amount: amountController.text,
                id: '',      // preserve or fill in existing ID if needed
                boothId: '', // preserve booth ID if needed
              ),
            );
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
