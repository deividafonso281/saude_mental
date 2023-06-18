import 'package:frontend/models/base_model.dart';

import 'convertos/map_converter_interface.dart';

class HealthServiceModelConverter implements MapConverter<HealthServiceModel> {
  @override
  HealthServiceModel fromMap(Map<String, dynamic> json, String id) {
    return HealthServiceModel(
      id: id,
      availableTimes: json["avaibleTimes"],
    );
  }

  @override
  Map<String, dynamic> toMap(HealthServiceModel model) {
    return {
      'avaibleTimes': model.availableTimes,
    };
  }
}

class HealthServiceModel extends BaseModel {
  DateTime availableTimes;

  HealthServiceModel({required super.id, required this.availableTimes});
}
