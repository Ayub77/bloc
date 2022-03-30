// ignore_for_file: prefer_const_constructors
import 'package:bloc/pages/update_and_newAdd_post.dart';
import 'package:bloc/viewmodel/home_view_model.dart';
import 'package:bloc/widgets/home+page_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("setState"),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, model, index) {
            return Stack(
              children: [
                ListView.builder(
                    itemCount: viewModel.items.length,
                    itemBuilder: (context, index) {
                      return HomeWidget(
                        viewModel: viewModel,
                        post: viewModel.items[index],
                      );
                    }),
                viewModel.loading? Center(child: CircularProgressIndicator(),): SizedBox.shrink()
                    ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateAndAdd(title: "Add",id: "0",))).then((value) {
            if (value) {
              viewModel.apiPostList();
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
