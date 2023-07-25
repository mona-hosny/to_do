import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:to_do/models/todo_dm.dart';
import 'package:to_do/utiles/app_color.dart';

class Todo extends StatelessWidget {
  TodoDm todo;

  Todo({required this.todo});

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: ObjectKey(todo),
      leadingActions: [
        SwipeAction(
          onTap: (CompletionHandler handler) {},
          color: Colors.red,
          content: Container(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Column(children: [
              Icon(Icons.delete, size: 40, color: AppColor.secondColor),
              Text(
                "delete",
                style: TextStyle(
                  color: AppColor.secondColor,
                ),
                textAlign: TextAlign.center,
              )
            ]),
          ),
          backgroundRadius: 25,
        )
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        margin: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(children: [
          buildVerticalLine(),
          buildcColume(context),
          const Spacer(),
          InkWell(
              onTap: () {},
              child: todo.isDone
                  ? const Text(
                      'Done!',
                      style: TextStyle(
                          fontSize: 22,
                          color: AppColor.fifthColor,
                          fontWeight: FontWeight.bold),
                    )
                  : buildIconState())
        ]),
      ),
    );
  }

  Widget buildcColume(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            todo.title,
            style:Theme.of(context).textTheme.bodyLarge?.copyWith(color:todo.isDone?AppColor.fifthColor:AppColor.primaryColor ),
          ),
          Text(
            todo.description,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }

  Widget buildVerticalLine() {
    return Container(
      color: (todo.isDone?AppColor.fifthColor:AppColor.primaryColor),
      height: 50,
      width: 4,
    );
  }

  Widget buildIconState() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
          color: AppColor.primaryColor, borderRadius: BorderRadius.circular(8)),
      child: Image.asset('assets/Icon awesome-check.png'),
    );
  }
}
