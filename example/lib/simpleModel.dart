import 'package:flutter_gridnine/gridnine_model.dart';

class SimpleModel extends GNModel{
  final String url;
  final String iconUrl;
  final String title;
  final String description;

  SimpleModel({this.url,this.iconUrl,this.title,this.description});

  @override
  String getTitle() => title;

  @override
  String getIconUrl() => iconUrl;

  @override
  String getSubTitle() => description;

  @override
  String getUrl() => url;
}