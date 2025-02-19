class PreferencesModel {
  Software? software;
  Interest? interest;

  PreferencesModel({this.software, this.interest});

  factory PreferencesModel.fromJson(Map<String, dynamic> json) {
    return PreferencesModel(
      software:
          json['software'] != null ? Software.fromJson(json['software']) : null,
      interest:
          json['interest'] != null ? Interest.fromJson(json['interest']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'software': software?.toJson(),
      'interest': interest?.toJson(),
    };
  }
}

class Software {
  Model2D? model2D;
  Model3D? model3D;

  Software({this.model2D, this.model3D});

  factory Software.fromJson(Map<String, dynamic> json) {
    return Software(
      model2D:
          json['model2D'] != null ? Model2D.fromJson(json['model2D']) : null,
      model3D:
          json['model3D'] != null ? Model3D.fromJson(json['model3D']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model2D': model2D?.toJson(),
      'model3D': model3D?.toJson(),
    };
  }
}

class Interest {
  Model2D? model2D;
  Model3D? model3D;

  Interest({this.model2D, this.model3D});

  factory Interest.fromJson(Map<String, dynamic> json) {
    return Interest(
      model2D:
          json['model2D'] != null ? Model2D.fromJson(json['model2D']) : null,
      model3D:
          json['model3D'] != null ? Model3D.fromJson(json['model3D']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'model2D': model2D?.toJson(),
      'model3D': model3D?.toJson(),
    };
  }
}

class Model2D {
  List<Map<String, bool>>? options;

  Model2D({this.options});

  factory Model2D.fromJson(Map<String, dynamic> json) {
    return Model2D(
      options: json['options'] != null
          ? List<Map<String, bool>>.from(json['options'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'options': options,
    };
  }
}

class Model3D {
  List<Map<String, bool>>? options;

  Model3D({this.options});

  factory Model3D.fromJson(Map<String, dynamic> json) {
    return Model3D(
      options: json['options'] != null
          ? List<Map<String, bool>>.from(json['options'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'options': options,
    };
  }
}
