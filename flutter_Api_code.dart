import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  Controller().getControllerFunc();
}

class Controller {
  int codeNo = 2;
  getControllerFunc() async {
    try {
      var data = await Services(code: codeNo).getDataFunc();
      if (codeNo == 1) {
        print(data[0].title);
      } else {
        print(data[0].name);
      }
    } catch (e) {
      print(e);
    }
  }
}

class Services {
  int code;
  Services({required this.code});

  Future getDataFunc() async {
    try {
      var url = Uri.parse(code == 1
          ? 'https://jsonplaceholder.typicode.com/posts'
          : 'https://jsonplaceholder.typicode.com/users');
      var responseString = await http.get(url);
      if (responseString.statusCode == 200) {
        var jsonResponse = await json.decode(responseString.body);

        if (jsonResponse[1]['title'] == "qui est esse") {
          final jsonPlaceHolder = jsonPlaceHolderFromJson(responseString.body);
          return jsonPlaceHolder;
        } else if (jsonResponse[0]['username'] == "Bret") {
          final jsonPlaceHolderUsers =
              jsonPlaceHolderUsersFromJson(responseString.body);
          return jsonPlaceHolderUsers;
        }
      } else {
        print('Some Error');
      }
    } catch (e) {
      print(e);
    }
  }
}

// To parse this JSON data, do
//
//     final jsonPlaceHolder = jsonPlaceHolderFromJson(jsonString);

List<JsonPlaceHolder> jsonPlaceHolderFromJson(String str) =>
    List<JsonPlaceHolder>.from(
        json.decode(str).map((x) => JsonPlaceHolder.fromJson(x)));

String jsonPlaceHolderToJson(List<JsonPlaceHolder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JsonPlaceHolder {
  JsonPlaceHolder({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  int? userId;
  int? id;
  String? title;
  String? body;

  factory JsonPlaceHolder.fromJson(Map<String, dynamic> json) =>
      JsonPlaceHolder(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}

// To parse this JSON data, do
//
//     final jsonPlaceHolderUsers = jsonPlaceHolderUsersFromJson(jsonString);

List<JsonPlaceHolderUsers> jsonPlaceHolderUsersFromJson(String str) =>
    List<JsonPlaceHolderUsers>.from(
        json.decode(str).map((x) => JsonPlaceHolderUsers.fromJson(x)));

String jsonPlaceHolderUsersToJson(List<JsonPlaceHolderUsers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JsonPlaceHolderUsers {
  JsonPlaceHolderUsers({
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  });

  int? id;
  String? name;
  String? username;
  String? email;
  Address? address;
  String? phone;
  String? website;
  Company? company;

  factory JsonPlaceHolderUsers.fromJson(Map<String, dynamic> json) =>
      JsonPlaceHolderUsers(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address: Address.fromJson(json["address"]),
        phone: json["phone"],
        website: json["website"],
        company: Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address?.toJson(),
        "phone": phone,
        "website": website,
        "company": company?.toJson(),
      };
}

class Address {
  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: Geo.fromJson(json["geo"]),
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "suite": suite,
        "city": city,
        "zipcode": zipcode,
        "geo": geo?.toJson(),
      };
}

class Geo {
  Geo({
    this.lat,
    this.lng,
  });

  String? lat;
  String? lng;

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Company {
  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  String? name;
  String? catchPhrase;
  String? bs;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "catchPhrase": catchPhrase,
        "bs": bs,
      };
}
