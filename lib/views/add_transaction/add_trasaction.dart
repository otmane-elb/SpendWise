// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/views/add_transaction/widgets/confirm_details.dart';
import 'package:uuid/uuid.dart';
import 'package:spendwise/views/themes/app_colors.dart';
import 'package:spendwise/views/widgets/custom_button.dart';
import '../../core/models/transaction_model/transaction_model.dart';
import '../../core/providers/transaction_provider.dart';
import '../../utils/extentions/image_managment.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/icon_display.dart';
import 'widgets/icon_selector.dart';

class AddTransaction extends ConsumerStatefulWidget {
  const AddTransaction({super.key});

  @override
  AddTransactionState createState() => AddTransactionState();
}

class AddTransactionState extends ConsumerState<AddTransaction> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final Uuid uuid = const Uuid();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isExpense = true;
  IconData? selectedIcon;
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('Add Transaction',
            style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        label: 'Name',
                        hintText: 'Name',
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      ExpansionTile(
                        title: const Text(
                          'Select Icon',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey400,
                          ),
                        ),
                        children: [
                          IconSelector(
                            selectedIcon: selectedIcon,
                            onIconSelected: (icon) {
                              setState(() {
                                selectedIcon = icon;
                              });
                            },
                          ),
                        ],
                      ),
                      CustomTextFormField(
                        label: 'Amount',
                        hintText: 'Amount',
                        controller: amountController,
                        isNumber: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        label: 'Date',
                        hintText: 'Date',
                        controller: dateController,
                        isDate: true,
                      ),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: DottedBorder(
                            dashPattern: const [10, 10],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            color: Colors.black,
                            strokeWidth: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                imageFile == null
                                    ? const Icon(
                                        Icons.add_circle,
                                        color: AppColors.grey400,
                                      )
                                    : const Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                      ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Add invoice',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.grey400,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      CustomDropdownField(
                        label: 'Transaction Type',
                        value: isExpense,
                        onChanged: (value) {
                          setState(() {
                            isExpense = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomButton(
                            isWhite: true,
                            onPressed: () {
                              context.pop();
                            },
                            text: 'Cancel',
                          ),
                          CustomButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final title = nameController.text;
                                final value =
                                    double.tryParse(amountController.text) ??
                                        0.0;
                                final dateFormatter =
                                    DateFormat('EEE, dd MMM yyyy');
                                final date =
                                    dateFormatter.parse(dateController.text);

                                final transactions = ref
                                    .read(transactionProvider.notifier)
                                    .state;
                                final order = transactions.length;

                                final transaction = Transaction(
                                  id: uuid.v4(),
                                  title: title,
                                  date: date,
                                  isExpense: isExpense,
                                  value: value,
                                  icon: getStringFromIconData(selectedIcon),
                                  image: imageFile?.path != null
                                      ? await fileToBytes(imageFile!.path)
                                      : null,
                                  order: order, // Set the order value
                                );

                                ref
                                    .read(transactionProvider.notifier)
                                    .addTransaction(transaction);

                                if (context.mounted) context.pop();
                              }
                            },
                            text: 'Save',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await pickImage();
    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });

      final String extractedText = await extractTextFromImage(pickedFile);
      List<String> lines = extractedText.split('\n');

      String totalAmount = extractTotalAmount(lines);
      String date = extractDateFromText(lines);

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDetailsDialog(
            totalAmount: totalAmount,
            date: date,
            onConfirm: (bool confirmAmount, bool confirmDate) {
              if (confirmAmount) {
                amountController.text = totalAmount;
              }
              if (confirmDate) {
                dateController.text = date;
              }
            },
          );
        },
      );
    }
  }
}
