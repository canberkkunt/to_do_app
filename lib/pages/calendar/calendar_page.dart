import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:to_do_app/pages/calendar/calendar_controller.dart';
import 'package:to_do_app/pages/home/home_controller.dart';
import 'package:to_do_app/pages/home/model/task_model.dart';

class CalendarPage extends GetView<CalendarController> {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Takvim', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _showAddEventDialog(controller);
            },
            icon: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade900,
      body: Column(
        children: [
          Obx(
            () {
                  final _ = controller.calendarVersion.value;

                  return TableCalendar<TaskModel>(
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, events) {
                        if (events.isNotEmpty) {
                          return Positioned(
                            right: 1.0,
                            left: 1.0,
                            child: Container(
                              padding: EdgeInsets.all(0.2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '${events.length}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        }
                        return null;
                      },
                    ),
                    eventLoader: controller.getEventsForDay,
                    focusedDay: controller.focusedDay.value,
                    firstDay: DateTime.utc(2020, 01, 01),
                    lastDay: DateTime.utc(2030, 12, 31),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Colors.redAccent),
                      todayDecoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    selectedDayPredicate: (day) =>
                        isSameDay(controller.selectedDay.value, day),
                    onDaySelected: controller.onDaySelected,
                  );
                }
                as WidgetCallback,
          ),

          Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Bu Günün Planları',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.selectedEvents.isEmpty
                  ? Center(
                      child: Text(
                        'Bugün için planlamış görev yok',
                        style: TextStyle(color: Colors.white54),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.selectedEvents.length,
                      itemBuilder: (context, index) {
                        final TaskModel event =
                            controller.selectedEvents[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 12.0,
                          ),
                          color: Colors.grey.shade800,
                          child: ListTile(
                            title: Text(
                              event.title,
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: Icon(
                              event.isDone
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: event.isDone ? Colors.green : Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEventDialog(CalendarController controller) {
    final TextEditingController textEditingController = TextEditingController();
    final HomeController homeController = Get.find<HomeController>();
    Get.dialog(
      AlertDialog(
        title: Text('Yeni Plan Ekle'),
        content: TextField(
          controller: textEditingController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Planınızı buraya yazın...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('İptal'),
          ),
          ElevatedButton(
            onPressed: () {
              String taskTitle = textEditingController.text;
              homeController.addTask(
                taskTitle,
                date: controller.selectedDay.value,
              );
              Get.back();
            },
            child: Text('Ekle'),
          ),
        ],
      ),
    );
  }
}
