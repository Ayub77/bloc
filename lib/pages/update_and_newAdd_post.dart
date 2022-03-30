// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bloc/model/post_model.dart';
import 'package:bloc/viewmodel/update_and_newAdd_post_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateAndAdd extends StatefulWidget {
  const UpdateAndAdd({ Key? key, required this.title, required this.id, this.post}) : super(key: key);
  final String title;
  final String id;
  final dynamic post;
  @override
  State<UpdateAndAdd> createState() => _UpdateAndAddState();
}

class _UpdateAndAddState extends State<UpdateAndAdd> {
  
  UpdateAndAddmodel updAndAddModel = UpdateAndAddmodel();
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.post!=null)updAndAddModel.choose(widget.title, widget.post);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(widget.title),
      centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context)=>updAndAddModel,
        child: Consumer<UpdateAndAddmodel>(
          builder: (context,model,index){
        return Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: updAndAddModel.titleController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                    labelText: "title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1
                      )
                    )
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: updAndAddModel.bodyController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                    labelText: "body",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1
                      )
                    )
                  ),
                ),
                 SizedBox(height: 10,),
                TextField(
                  controller: updAndAddModel.userIdController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                    labelText: "userId",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1
                      )
                    )
                  ),
                ),
                widget.title!="Add"?Column(
                  children: [
                    SizedBox(height: 10,),
                TextField(
                  controller: updAndAddModel.idController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                    labelText: "id",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 1
                      )
                    )
                  ),
                ),
                  ],
                ):Container(),
                SizedBox(height: 20,),
                FlatButton(
                  height: 50,
                  minWidth: double.infinity,
                  onPressed: (){
                  updAndAddModel.apiPostAdd(widget.title,widget.id).then((value) => {
                    if(value){
                      Navigator.pop(context)
                    }
                  });
                },
                 child: Text("Ok",style: TextStyle(color: Colors.white),),
                 color: Colors.blue,)
              ],
            ),
          ),
          updAndAddModel.loading?Center(child: CircularProgressIndicator(),):SizedBox.shrink()
        ],
      );
          },
        ),
      )
    );
  }
}