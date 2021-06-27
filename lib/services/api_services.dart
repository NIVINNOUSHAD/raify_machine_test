import 'dart:convert';

import 'package:riafymachinetest/services/api/api.dart';
import 'package:riafymachinetest/services/api_constants.dart';


class APIServices {

  //get vehicle type api service
  Future<dynamic> getallpostdata() async {
    return await Api.getData(URLS.postlist);
  }

  Future<dynamic> getcomments() async {
    return await Api.getData(URLS.comments);
  }



}
