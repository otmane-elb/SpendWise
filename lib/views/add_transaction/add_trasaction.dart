import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:spendwise/views/themes/app_colors.dart';
import 'package:spendwise/views/widgets/custom_button.dart';
import '../../core/models/transaction_model/transaction_model.dart';
import '../../core/providers/transaction_provider.dart';
import '../home/widgets/custom_curved_container.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/custom_textfield.dart';

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
  bool isExpense = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomCurvedContainer(
              height: height,
              pageName: 'Add Transaction',
              isHome: false,
              isPop: true,
            ),
          ),
          Positioned(
            top: height * 0.15,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: height * .6,
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
              child: Column(
                children: [
                  CustomTextFormField(
                    label: 'Name',
                    hintText: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Amount',
                    hintText: 'Amount',
                    controller: amountController,
                    isNumber: true,
                  ),
                  CustomTextFormField(
                    label: 'Date',
                    hintText: 'Date',
                    controller: dateController,
                    isDate: true,
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
                          context.replaceNamed('home');
                        },
                        text: 'Cancel',
                      ),
                      CustomButton(
                        onPressed: () async {
                          final title = nameController.text;
                          final value =
                              double.tryParse(amountController.text) ?? 0.0;
                          final dateFormatter = DateFormat('EEE, dd MMM yyyy');
                          final date = dateFormatter.parse(dateController.text);

                          
                          final transaction = Transaction(
                            id: uuid.v4(),
                            title: title,
                            date: date,
                            isExpense: isExpense,
                            value: value,
                          );

                          ref
                              .read(transactionProvider.notifier)
                              .addTransaction(transaction);


                          context.replaceNamed('home');
                        },
                        text: 'Save',
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
