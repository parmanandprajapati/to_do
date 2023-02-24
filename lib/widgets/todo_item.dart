import 'package:flutter/material.dart';
import 'package:to_do/constant/colors.dart';
import 'package:to_do/model/todo.dart';


class ToDoItem extends StatelessWidget {
  //ToDo type ka data type hai. jiska naam todo hai
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem({Key? key,required this.todo,required this.onToDoChanged,
  required this.onDeleteItem}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom:20),
      child: ListTile(
        onTap: () {
          // it will pass todo argument to _handletodochange in home.dart file
          onToDoChanged(todo);
          print('clicked on todo item');
        },
        // list tile ke shape ke liye Rounded Rectangleborder.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
        tileColor: Colors.white,
        leading: Icon(
            todo.isDone ? Icons.check_box: Icons.check_box_outline_blank, color: tdBlue),
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            // line ko(check) cut karne ke liye
              // isDone me agar true store hoga toh lineThrough execute hoga.
            decoration:todo.isDone? TextDecoration.lineThrough : null
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height:35,
          width:35,
          decoration:BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(onPressed: (){
            onDeleteItem(todo.id);
            print('clicked on delete button');
          },
              icon: Icon(Icons.delete),
          iconSize: 18,
          color: Colors.white,)

        ),
      ),
    );
  }
}
