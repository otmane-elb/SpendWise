import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/views/themes/app_colors.dart';
import 'package:spendwise/views/widgets/custom_button.dart';
import '../home/widgets/custom_curved_container.dart';
import '../widgets/custom_textfield.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    TextEditingController controller = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    TextEditingController controller3 = TextEditingController();

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
                    controller: controller,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Amount',
                    hintText: 'Amount',
                    controller: controller2,
                    isNumber: true,
                  ),
                  CustomTextFormField(
                    label: 'Date',
                    hintText: 'Amount',
                    controller: controller3,
                    isDate: true,
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
                        onPressed: () {},
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
