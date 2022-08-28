import 'package:flutter/cupertino.dart';

import '../models/post_model.dart';
import '../services/network_service.dart';

class HomeViewModel extends ChangeNotifier{
  List<Post> items = [];
  bool isLoading = false;

  Future<void> apiPostList() async {
    isLoading = true;
    notifyListeners();

    String? response =
    await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items = Network.parsePostList(response);
    } else {
      items = [];
    }
    isLoading = false;
    notifyListeners();
  }
  Future<bool> apiPostDelete(Post post) async {
    isLoading = true;
    notifyListeners();
    String? response = await Network.DEL(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());
    isLoading = false;
    notifyListeners();
    return response != null;

  }
}