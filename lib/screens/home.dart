import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/constant/colors.dart';
import 'package:to_do/model/todo.dart';
import 'package:to_do/widgets/todo_item.dart';

class Home extends  StatefulWidget{
   Home({Key?key}) : super(key:key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //for searching bar
  List<ToDo> _foundToDo=[];
  final todosList= ToDo.todoList();
  //we need to create controller for adding item
  final _todoController= TextEditingController();
  //initialize init function for search bar
  @override
  void initState(){
    //we are assinging the data already todo in model  to _foundToDo
    _foundToDo=todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      // this will change color of body of particular screen.
      backgroundColor:tdBGColor,
      appBar:_buildAppBar(),
         //_buildAppBar() function defined below.
      body: Stack(
        children:[ Container(
           //padding space create kardega app bar aur body ke bich me.
          padding:EdgeInsets.symmetric(horizontal: 15,vertical: 15),

          child:Column(
            children: [
              // search box widget defined below.
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    Container(
                      margin:EdgeInsets.only(top:50,bottom: 20),
                      child: Text('All ToDos',style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),),
                    ),
                 // todoList //todo.dart ke andar method hai
                    //ToDoItem ek statelessWidget hai and uso call karnege
                    // toh neccesarry hai ki hm todo parameter pass karre
                   //ToDoItem widget me todo type ka data pass hoga
                   // jo udar ja kar final todo me stored hoga
                 // for (ToDo todo in todosList)
                    for(ToDo todo in _foundToDo.reversed)
                   ToDoItem(todo: todo,
                   onToDoChanged: _handleToDoChange,
                   onDeleteItem: _deleteToDoItem,),

                  ],
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          //because last line contain two things.
          child: Row(children: [
            Expanded(child:
            Container(
              margin: EdgeInsets.only(
                bottom:20,
                right:20,
                left:20
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                //BoxShadow always wrap with square brackets
                boxShadow: const [BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0,0.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                )],
                borderRadius: BorderRadius.circular(10),


              ),
              child: TextField(
                controller: _todoController,
                decoration: InputDecoration(
                  hintText: 'Add a new todo Item',
                  border: InputBorder.none,
                ),
              ),
            )),
            Container(
              margin: EdgeInsets.only(bottom: 20,
              right:20),
              child: ElevatedButton(onPressed: (){
                _addToDoItem(_todoController.text);
              },
                  child: Text('+',style: TextStyle(fontSize: 40,color: Colors.white),),
              style: ElevatedButton.styleFrom(
                primary: tdBlue,
                    minimumSize:Size(60,60),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero
                )
              ))
            )
          ],)
        )]
      )
    );
  }
void _addToDoItem( String toDo){
          setState(() {

    todosList.add(ToDo(id:DateTime.now().millisecondsSinceEpoch.toString(),
            todoText:toDo));
          });
          // clear add field after adding todo
  _todoController.clear();
}
  void _handleToDoChange(ToDo todo){
    setState(() {
      todo.isDone=!todo.isDone;
    });
    // this will chang isDone to From true to False viceversa.

  }
  void _deleteToDoItem(String id){
    // removeWhere is function which remove id it id pass to argument
    // will match to id present in todoList.
    setState(() {

    todosList.removeWhere((item) => item.id==id);
    });
  }
  void _runFilter(String enteredKeyword){
    List<ToDo> results = [];
    if(enteredKeyword.isEmpty){
      results=todosList;
    }
    else{
      results=todosList.where((item)=> item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo=results;
    });
  }
  Widget searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value)=> _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon:Icon(
              Icons.search,
              color:Colors.black,
              size: 20,
            ),
            //BoxConstraints can be used to modify the surrounding of the prefixIcon. This property is particularly useful for getting the decoration's height less than 48px.
            prefixIconConstraints: BoxConstraints(maxHeight: 20,minWidth: 25),
            border:InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color:tdGrey)
        ),
      ),

    );
  }

 AppBar _buildAppBar(){
  return AppBar(
  title: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //children ke andar widgets ke bich me space la dega
  children: [
  Icon(Icons.menu, color: tdBlack,size: 30,),
  Container(
  height: 40,
  width:40,
  child: ClipRRect(

  child: Image.asset('assests/images/avatar.jpg'),
  borderRadius: BorderRadius.circular(20),
  )
  )
  ],
  ),
  backgroundColor: tdBGColor,
  // appbar ke shadow ke liye use hota hai
  elevation:0,
  centerTitle: true,
  //ye status bar ko dark ya light kar dega.
  systemOverlayStyle: SystemUiOverlayStyle.dark,
  );}
}