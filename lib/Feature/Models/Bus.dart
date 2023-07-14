class Bus {
  int? id;
  String? name;
  String? number;
  int? companyId;
  Company? company;
  String? imgPath;

  Bus(
      {this.id,
        this.name,
        this.number,
        this.companyId,
        this.company,
        this.imgPath});

  Bus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    companyId = json['companyId'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    imgPath = json['imgPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['number'] = this.number;
    data['companyId'] = this.companyId;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['imgPath'] = this.imgPath;
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? logo;
  String? address;
  String? phoneNumber;
  String? facebook;
  int? cityId;
  City? city;

  Company(
      {this.id,
        this.name,
        this.logo,
        this.address,
        this.phoneNumber,
        this.facebook,
        this.cityId,
        this.city});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    facebook = json['facebook'];
    cityId = json['cityId'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['address'] = this.address;
    data['phoneNumber'] = this.phoneNumber;
    data['facebook'] = this.facebook;
    data['cityId'] = this.cityId;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
