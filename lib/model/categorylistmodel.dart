import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) => CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) => json.encode(data.toJson());

class CategoryListModel {
    bool? status;
    String? message;
    String? messageIos;
    List<Datum>? data;

    CategoryListModel({
        this.status,
        this.message,
        this.messageIos,
        this.data,
    });

    factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
        status: json["status"],
        message: json["message"],
        messageIos: json["message_ios"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "message_ios": messageIos,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? name;
    String? icon;

    Datum({
        this.id,
        this.name,
        this.icon,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
    };
}
