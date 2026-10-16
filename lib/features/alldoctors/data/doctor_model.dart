import 'package:flutter/material.dart';

class DoctorsModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? code;

  DoctorsModel({this.message, this.data, this.status, this.code});

  DoctorsModel.fromJson(Map<String, dynamic>? json) {
    if(json==null){
    DoctorsModel();
    }
    message = json?['message'];
    if (json?['data'] != null) {
      data = <Data>[];
      json?['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    status = json?['status'];
    code = json?['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['code'] = code;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? photo;
  String? gender;
  String? address;
  String? description;
  String? degree;
  Specialization? specialization;
  City? city;
  int? appointPrice;
  String? startTime;
  String? endTime;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.photo,
        this.gender,
        this.address,
        this.description,
        this.degree,
        this.specialization,
        this.city,
        this.appointPrice,
        this.startTime,
        this.endTime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    gender = json['gender'];
    address = json['address'];
    description = json['description'];
    degree = json['degree'];
    specialization = json['specialization'] != null
        ? Specialization.fromJson(json['specialization'])
        : null;
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    appointPrice = json['appoint_price'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['photo'] = photo;
    data['gender'] = gender;
    data['address'] = address;
    data['description'] = description;
    data['degree'] = degree;
    if (specialization != null) {
      data['specialization'] = specialization!.toJson();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['appoint_price'] = appointPrice;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}

class Specialization {
  int? id;
  String? name;

  Specialization({this.id, this.name});

  Specialization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class City {
  int? id;
  String? name;
  Specialization? governrate;

  City({this.id, this.name, this.governrate});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    governrate = json['governrate'] != null
        ? Specialization.fromJson(json['governrate'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (governrate != null) {
      data['governrate'] = governrate!.toJson();
    }
    return data;
  }
}