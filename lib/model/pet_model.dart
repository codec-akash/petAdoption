class Pet {
  Weight? weight;
  Weight? height;
  int? id;
  String? name;
  String? bredFor;
  String? breedGroup;
  String? lifeSpan;
  String? temperament;
  String? origin;
  String? referenceImageId;
  PetImage? image;
  late bool isAdopted;
  String? adoptedDate;

  Pet(
      {this.weight,
      this.height,
      this.id,
      this.name,
      this.bredFor,
      this.breedGroup,
      this.lifeSpan,
      this.temperament,
      this.origin,
      this.referenceImageId,
      this.image,
      this.isAdopted = false,
      this.adoptedDate});

  Pet.fromJson(Map<dynamic, dynamic> json) {
    weight =
        json['weight'] != null ? new Weight.fromJson(json['weight']) : null;
    height =
        json['height'] != null ? new Weight.fromJson(json['height']) : null;
    id = json['id'];
    name = json['name'];
    bredFor = json['bred_for'];
    breedGroup = json['breed_group'];
    lifeSpan = json['life_span'];
    temperament = json['temperament'];
    origin = json['origin'];
    referenceImageId = json['reference_image_id'];
    image = json['image'] != null ? new PetImage.fromJson(json['image']) : null;
    isAdopted = json['isAdopted'] ?? false;
    adoptedDate = json['adoptedDate'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    if (this.weight != null) {
      data['weight'] = this.weight!.toJson();
    }
    if (this.height != null) {
      data['height'] = this.height!.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['bred_for'] = this.bredFor;
    data['breed_group'] = this.breedGroup;
    data['life_span'] = this.lifeSpan;
    data['temperament'] = this.temperament;
    data['origin'] = this.origin;
    data['reference_image_id'] = this.referenceImageId;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['isAdopted'] = this.isAdopted;
    data['adoptedDate'] = this.adoptedDate;
    return data;
  }
}

class Weight {
  String? imperial;
  String? metric;

  Weight({this.imperial, this.metric});

  Weight.fromJson(Map<dynamic, dynamic> json) {
    imperial = json['imperial'];
    metric = json['metric'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['imperial'] = this.imperial;
    data['metric'] = this.metric;
    return data;
  }
}

class PetImage {
  String? id;
  int? width;
  int? height;
  String? url;

  PetImage({this.id, this.width, this.height, this.url});

  PetImage.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    return data;
  }
}
