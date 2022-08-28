import 'dart:math';
import 'package:flutter/material.dart';
import 'package:platform_pattern_provider/viewmodel/detail_view_model.dart';
import 'package:provider/provider.dart';

import '../models/post_model.dart';
import '../services/network_service.dart';

enum DetailState { create, update }

class DetailPage extends StatefulWidget {
  final Post? post;
  final DetailState state;

  const DetailPage({Key? key, this.post, this.state = DetailState.create})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  DetailViewModel detailViewModel = DetailViewModel();
  void init() {
    if (widget.state == DetailState.update) {
      detailViewModel.titleController = TextEditingController(text: widget.post!.title);
      detailViewModel.bodyController = TextEditingController(text: widget.post!.body);
    }
  }


  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: widget.state == DetailState.create
            ? const Text("Add post")
            : const Text("Update post"),
      ),
      body: ChangeNotifierProvider(
        create: (context) => detailViewModel,
        child: Consumer<DetailViewModel>(
          builder: (context,model,index){
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: detailViewModel.titleController,
                        decoration: InputDecoration(
                            label: const Text("Title"),
                            hintText: "Title",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                            border: const OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        controller: detailViewModel.bodyController,
                        decoration: InputDecoration(
                            label: const Text("Body"),
                            hintText: "Body",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            border: const OutlineInputBorder()),
                      ),
                      const SizedBox(height: 20,),
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          if (widget.state == DetailState.create) {
                            detailViewModel.addPage;
                          } else {
                            detailViewModel.updatePost(context);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text("Submit Text"),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: detailViewModel.isLoading,
                  child: const CircularProgressIndicator(
                    color: Colors.red,
                  ),
                )
              ],
            );
          },
        )


      )
    );
  }
}