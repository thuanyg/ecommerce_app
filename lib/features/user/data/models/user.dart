class User {
  String? id;
  String? email;
  String? username;
  String? password;
  Name? name;
  Address? address;
  String? phone;

  User(
      {this.id,
        this.email,
        this.username,
        this.password,
        this.name,
        this.address,
        this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['phone'] = this.phone;
    return data;
  }
}

class Name {
  String? firstname;
  String? lastname;

  Name({this.firstname, this.lastname});

  Name.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}

class Address {
  String? city;
  String? street;
  int? number;
  String? zipcode;
  Geolocation? geolocation;

  Address(
      {this.city, this.street, this.number, this.zipcode, this.geolocation});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    street = json['street'];
    number = json['number'];
    zipcode = json['zipcode'];
    geolocation = json['geolocation'] != null
        ? new Geolocation.fromJson(json['geolocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['street'] = this.street;
    data['number'] = this.number;
    data['zipcode'] = this.zipcode;
    if (this.geolocation != null) {
      data['geolocation'] = this.geolocation!.toJson();
    }
    return data;
  }
}

class Geolocation {
  String? lat;
  String? long;

  Geolocation({this.lat, this.long});

  Geolocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
