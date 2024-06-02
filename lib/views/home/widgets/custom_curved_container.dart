import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spendwise/views/home/widgets/curved_container.dart';
import 'package:spendwise/views/themes/app_colors.dart';
import 'package:spendwise/views/widgets/custom_button.dart';

import '../../../core/services/services.dart';

class CustomCurvedContainer extends StatefulWidget {
  const CustomCurvedContainer({
    super.key,
    required this.height,
    this.name = 'User',
    this.isHome = true,
    this.pageName = 'page',
    this.isPop = false,
  });

  final double height;
  final String name;
  final String pageName;
  final bool isHome;
  final bool isPop;

  @override
  _CustomCurvedContainerState createState() => _CustomCurvedContainerState();
}

class _CustomCurvedContainerState extends State<CustomCurvedContainer> {
  final NotificationService _notificationService = NotificationService();
  bool _notificationsEnabled = false;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 22, minute: 0);
  final Box _settingsBox = Hive.box('settings');

  @override
  void initState() {
    super.initState();
    _notificationsEnabled = _settingsBox.get('notificationsEnabled', defaultValue: false);
    final storedHour = _settingsBox.get('notificationHour', defaultValue: 22);
    final storedMinute = _settingsBox.get('notificationMinute', defaultValue: 0);
    _selectedTime = TimeOfDay(hour: storedHour, minute: storedMinute);
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 17) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  Future<void> _showNotificationDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: AppColors.primaryLightColor,
              title: Text(
                'Notification Settings',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: Text(
                      'Enable Notifications',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.white),
                    ),
                    value: _notificationsEnabled,
                    onChanged: (bool value) async {
                      setState(() {
                        _notificationsEnabled = value;
                        _settingsBox.put('notificationsEnabled', value);
                      });
                      if (value) {
                        await _notificationService.requestExactAlarmPermission();
                      }
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Notification Time',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: AppColors.white),
                    ),
                    trailing: Text(
                      _selectedTime.format(context),
                    ),
                    onTap: () async {
                      TimeOfDay? picked = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (picked != null && picked != _selectedTime) {
                        setState(() {
                          _selectedTime = picked;
                          _settingsBox.put('notificationHour', picked.hour);
                          _settingsBox.put('notificationMinute', picked.minute);
                        });
                        if (_notificationsEnabled) {
                          await _notificationService.scheduleDailyNotification(
                            hour: _selectedTime.hour,
                            minute: _selectedTime.minute,
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
              actions: [
                CustomButton(
                  isWhite: true,
                  onPressed: () {
                    context.pop();
                  },
                  text: 'Close',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.info,
                      color: AppColors.beige,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Time is based on the timezone.',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 10),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final greetings = _getGreeting();

    return CurvedContainer(
      height: widget.height / 2.9,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: widget.height * 0.055,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.isHome
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$greetings,',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(widget.name,
                                style: Theme.of(context).textTheme.bodyLarge),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: _showNotificationDialog,
                        icon: const Icon(
                          Icons.notifications,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: widget.isPop,
                        child: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Text(widget.pageName,
                          style: Theme.of(context).textTheme.bodyLarge),
                      const Icon(
                        Icons.more_horiz,
                        color: AppColors.white,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
