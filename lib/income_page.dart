import 'package:flutter/material.dart';
import 'custom_text_input.dart'; // Import the CustomTextInput widget

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final _formKey = GlobalKey<FormState>();

  // List of income types
  final List<String> _incomeTypes = [
    'شخم ساعتی', // Hourly Income
    'شخم هکتاری', // Per Hectare Income
    'سرویس بار تریلی', // Trailer Service Income
    'کودپاش', // Fertilizer Application Income
  ];

  String? _selectedIncomeType; // Selected income type
  final _hourlyRateController = TextEditingController(); // مبلغ هر ساعت
  final _workingHoursController = TextEditingController(); // تعداد ساعات کارکرد
  final _employerNameController = TextEditingController(); // نام صاحب کار

  @override
  void initState() {
    super.initState();
    // Set default value for dropdown
    _selectedIncomeType = _incomeTypes[0]; // Default to "شخم ساعتی"
  }

  @override
  void dispose() {
    _hourlyRateController.dispose();
    _workingHoursController.dispose();
    _employerNameController.dispose();
    super.dispose();
  }

  void _saveIncome() {
    if (_formKey.currentState!.validate()) {
      // Retrieve input values
      final hourlyRate = _hourlyRateController.text;
      final workingHours = _workingHoursController.text;
      final employerName = _employerNameController.text;

      // Save logic here (e.g., store in database or send to server)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'درآمد "$_selectedIncomeType" با جزئیات ذخیره شد:\n'
                'مبلغ هر ساعت: $hourlyRate\n'
                'تعداد ساعات کارکرد: $workingHours\n'
                'نام صاحب کار: $employerName',
          ),
        ),
      );

      // Reset fields after saving
      setState(() {
        _selectedIncomeType = _incomeTypes[0]; // Reset dropdown to default
        _hourlyRateController.clear();
        _workingHoursController.clear();
        _employerNameController.clear();
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
        padding: const EdgeInsets.all(16.0),
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
              CustomTextInput(
                labelText: 'مبلغ هر ساعت', // Amount per Hour
                keyboardType: TextInputType.number,
                controller: _hourlyRateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفاً مبلغ هر ساعت را وارد کنید'; // Please enter amount per hour
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                labelText: 'تعداد ساعات کارکرد', // Number of Working Hours
                keyboardType: TextInputType.number,
                controller: _workingHoursController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفاً تعداد ساعات کارکرد را وارد کنید'; // Please enter working hours
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextInput(
                labelText: 'نام صاحب کار', // Employer's Name
                keyboardType: TextInputType.text,
                controller: _employerNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفاً نام صاحب کار را وارد کنید'; // Please enter employer's name
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