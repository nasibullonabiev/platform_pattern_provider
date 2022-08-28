
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:platform_pattern_provider/viewmodel/home_view_model.dart';
import '../models/post_model.dart';

Widget itemsOfPost(HomeViewModel viewModel,Post post) {
  return Slidable(
    key: ValueKey(post),
    startActionPane: ActionPane(
      extentRatio: 0.2,
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {
            viewModel.apiPostDelete(post).then((value) => {
              if(value) viewModel.apiPostList()
            });
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: Icons.update,
        ),
      ],
    ),
    endActionPane: ActionPane(
      extentRatio: 0.2,
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {
            viewModel.apiPostDelete(post);
          },
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete_outline,
        ),
      ],
    ),
    child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          Text(
            post.title.toUpperCase(),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            post.body,
            style: const TextStyle(color: Colors.black),
          )
        ],
      ),
    ),
  );
}