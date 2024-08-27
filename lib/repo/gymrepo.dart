import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fluttergym/model/categorylistmodel.dart';
import 'package:fluttergym/model/gymlistcategorymodel.dart';

class CategoryRepository {
  final Dio _dio = Dio();
  final String _url = "https://gymwise.in/api/v1/partner/categories/list";

  Future<CategoryListModel?> fetchCategories() async {
    try {
      final response = await _dio.post(_url, data: {'user_id': "0"});
      if (response.statusCode == 200) {
        return categoryListModelFromJson(jsonEncode(response.data));
      } else {
        // Handle error
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Handle exception
      print("Exception: $e");
      return null;
    }
  }
}


class GymLisrRepo {
  final Dio _dio = Dio();
  final String _url = "https://gymwise.in/api/v1/customer/gymListByCategory";

  Future<GymListCategoryModel?> gymlistRepo(int? categoryId) async {
    try {
      final response = await _dio.post(_url, data: {"category_id" : categoryId});
      if (response.statusCode == 200) {
        return gymListCategoryModelFromJson(jsonEncode(response.data));
      } else {
        // Handle error
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // Handle exception
      print("Exception: $e");
      return null;
    }
  }
}

