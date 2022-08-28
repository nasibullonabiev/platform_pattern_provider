import 'package:flutter/material.dart';
import 'package:platform_pattern_provider/pages/detail_page.dart';
import 'package:platform_pattern_provider/viewmodel/home_view_model.dart';
import 'package:provider/provider.dart';
import '../views/item_of_post.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
HomeViewModel viewModel = HomeViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Consumer<HomeViewModel>(
          builder: (context,model,index){
           return Stack(
              children: [
                ListView.builder(
                    itemCount: viewModel.items.length,
                    itemBuilder: (context, index) {
                      return itemsOfPost(viewModel,viewModel.items[index]);
                    }),
                Visibility(
                  visible: viewModel.isLoading,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailPage()));

        },
        child: const Icon(Icons.add),
      ),
    );
  }

}