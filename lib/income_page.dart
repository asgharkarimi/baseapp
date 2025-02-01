import 'package:flutter/material.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final _formKey = GlobalKey<FormState>();

  // List of income types
  final List<String> _incomeTypes = [
    'درآمد ساعتی', // Hourly Income
    'درآمد هکتاری', // Per Hectare Income
    'درآمد سرویس بار تریلی', // Trailer Service Income
    'درآمد کودپاش', // Fertilizer Application Income
  ];

  String? _selectedIncomeType; // Selected income type
  double _incomeAmount = 0.0; // Amount for the selected income type

  void _saveIncome() {
    if (_formKey.currentState!.validate()) {
      if (_selectedIncomeType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لطفاً نوع درآمد را انتخاب کنید')), // Please select an income type
        );
        return;
      }

      // Save logic here (e.g., store in database or send to server)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'درآمد "$_selectedIncomeType" با مقدار $_incomeAmount ذخیره شد',
          ),
        ),
      );

      // Reset fields after saving
      setState(() {
        _selectedIncomeType = null;
        _incomeAmount = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('افزودن درآمد'), // Persian: Add Income
        centerTitle: true,
        backgroundColor: Colors.blue, // Use your app's primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedIncomeType,
                items: _incomeTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedIncomeType = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'نوع درآمد', // Persian: Income Type
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفاً نوع درآمد را انتخاب کنید'; // Please select an income type
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'مبلغ', // Persian: Amount
                  border: OutlineInputBorder(),
                ),
                initialValue: _incomeAmount.toString(),
                onChanged: (value) {
                  setState(() {
                    _incomeAmount = double.tryParse(value) ?? 0.0;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفاً مبلغ را وارد کنید'; // Please enter an amount
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _saveIncome,
                  child: const Text('ذخیره'), // Persian: Save
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}