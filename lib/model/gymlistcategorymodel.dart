
import 'dart:convert';

GymListCategoryModel gymListCategoryModelFromJson(String str) => GymListCategoryModel.fromJson(json.decode(str));

String gymListCategoryModelToJson(GymListCategoryModel data) => json.encode(data.toJson());

class GymListCategoryModel {
    bool? status;
    String? message;
    List<Datum>? data;

    GymListCategoryModel({
        this.status,
        this.message,
        this.data,
    });

    factory GymListCategoryModel.fromJson(Map<String, dynamic> json) => GymListCategoryModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? gymId;
    String? gymName;
    String? gymLogo;
    List<String>? gymImages;
    String? address;
    String? description;
    String? howToGet;
    String? partnerName;
    String? partnerEmail;
    String? partnerPhone;
    String? phoneCode;
    String? avaliableSlots;
    List<Amenity>? amenities;
    List<String>? gymImages2;
    String? open;
    String? rating;
    List<Category>? categories;
    Distance? distance;
    String? imgPath;

    Datum({
        this.gymId,
        this.gymName,
        this.gymLogo,
        this.gymImages,
        this.address,
        this.description,
        this.howToGet,
        this.partnerName,
        this.partnerEmail,
        this.partnerPhone,
        this.phoneCode,
        this.avaliableSlots,
        this.amenities,
        this.gymImages2,
        this.open,
        this.rating,
        this.categories,
        this.distance,
        this.imgPath,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        gymId: json["gym_id"],
        gymName: json["gym_name"],
        gymLogo: json["gym_logo"],
        gymImages: json["gym_images"] == null ? [] : List<String>.from(json["gym_images"]!.map((x) => x)),
        address: json["address"],
        description: json["description"],
        howToGet: json["how_to_get"],
        partnerName: json["partner_name"],
        partnerEmail: json["partner_email"],
        partnerPhone: json["partner_phone"],
        phoneCode: json["phone_code"],
        avaliableSlots: json["avaliable_slots"],
        amenities: json["amenities"] == null ? [] : List<Amenity>.from(json["amenities"]!.map((x) => Amenity.fromJson(x))),
        gymImages2: json["gym_images2"] == null ? [] : List<String>.from(json["gym_images2"]!.map((x) => x)),
        open: json["open"],
        rating: json["rating"]!,
        categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
        distance: distanceValues.map[json["distance"]]!,
        imgPath: json["img_path"],
    );

    Map<String, dynamic> toJson() => {
        "gym_id": gymId,
        "gym_name": gymName,
        "gym_logo": gymLogo,
        "gym_images": gymImages == null ? [] : List<dynamic>.from(gymImages!.map((x) => x)),
        "address": address,
        "description": description,
        "how_to_get": howToGet,
        "partner_name": partnerName,
        "partner_email": partnerEmail,
        "partner_phone": partnerPhone,
        "phone_code": phoneCode,
        "avaliable_slots": avaliableSlots,
        "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
        "gym_images2": gymImages2 == null ? [] : List<dynamic>.from(gymImages2!.map((x) => x)),
        "open": open,
        "rating": rating,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "distance": distanceValues.reverse[distance],
        "img_path": imgPath,
    };
}

class Amenity {
    int? id;
    String? name; // Change from Name? to String?
    String? icon;

    Amenity({
        this.id,
        this.name,
        this.icon,
    });

    factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        id: json["id"],
        name: json["name"], // Directly assign the name as a string.
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name, // No conversion needed here
        "icon": icon,
    };
}
class Category {
    int? pricingId;
    CategoryName? categoryName;
    int? categoryId;
    List<Price>? price;

    Category({
        this.pricingId,
        this.categoryName,
        this.categoryId,
        this.price,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        pricingId: json["pricing_id"],
        categoryName: categoryNameValues.map[json["category_name"]]!,
        categoryId: json["category_id"],
        price: json["price"] == null ? [] : List<Price>.from(json["price"]!.map((x) => Price.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "pricing_id": pricingId,
        "category_name": categoryNameValues.reverse[categoryName],
        "category_id": categoryId,
        "price": price == null ? [] : List<dynamic>.from(price!.map((x) => x.toJson())),
    };
}

enum CategoryName {
    AEROBIC_EXERCISE,
    BOXING,
    CARDIO,
    CROSS_FIT,
    DANCE,
    HYPERTROPHY,
    JIU_JITSU,
    KARATE_TRAINING,
    KICKBOXING,
    MIXED_MARTIAL_ARTS_MMA,
    MUAY_THAI,
    PAIN_MANAGEMENT,
    PILATE,
    POWERLIFTING,
    REGULAR_GYM_EXERCISE,
    SELF_DEFENCE_CLASS,
    SOUND_HEALING_THERAPY,
    STRENGTHENING,
    STRENGTH_TRAINING,
    STRESS_MANAGEMENT,
    STRETCHING,
    SWIMMING,
    WEIGHT_TRAINING,
    YOGA,
    ZUMBA
}

final categoryNameValues = EnumValues({
    "Aerobic exercise": CategoryName.AEROBIC_EXERCISE,
    "Boxing": CategoryName.BOXING,
    "Cardio": CategoryName.CARDIO,
    "CrossFit": CategoryName.CROSS_FIT,
    "Dance": CategoryName.DANCE,
    "Hypertrophy": CategoryName.HYPERTROPHY,
    "jiu-jitsu": CategoryName.JIU_JITSU,
    "Karate Training": CategoryName.KARATE_TRAINING,
    "Kickboxing": CategoryName.KICKBOXING,
    "Mixed Martial Arts (MMA)": CategoryName.MIXED_MARTIAL_ARTS_MMA,
    "Muay Thai": CategoryName.MUAY_THAI,
    "Pain Management": CategoryName.PAIN_MANAGEMENT,
    "Pilate": CategoryName.PILATE,
    "Powerlifting": CategoryName.POWERLIFTING,
    "Regular Gym Exercise": CategoryName.REGULAR_GYM_EXERCISE,
    "Self Defence Class": CategoryName.SELF_DEFENCE_CLASS,
    "Sound Healing Therapy": CategoryName.SOUND_HEALING_THERAPY,
    "Strengthening": CategoryName.STRENGTHENING,
    "Strength training": CategoryName.STRENGTH_TRAINING,
    "Stress Management": CategoryName.STRESS_MANAGEMENT,
    "Stretching": CategoryName.STRETCHING,
    "Swimming": CategoryName.SWIMMING,
    "Weight Training": CategoryName.WEIGHT_TRAINING,
    "Yoga": CategoryName.YOGA,
    "Zumba": CategoryName.ZUMBA
});

class Price {
    int? hour;
    int? rate;

    Price({
        this.hour,
        this.rate,
    });

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        hour: json["hour"],
        rate: json["rate"],
    );

    Map<String, dynamic> toJson() => {
        "hour": hour,
        "rate": rate,
    };
}

enum Distance {
    THE_0_KM
}

final distanceValues = EnumValues({
    "0 km": Distance.THE_0_KM
});

enum Rating {
    THE_050_REVIEW
}

final ratingValues = EnumValues({
    "0/5 (0 Review)": Rating.THE_050_REVIEW
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
