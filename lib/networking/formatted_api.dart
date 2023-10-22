class VaccineObject {
  List<Sessions>? sessions;

  VaccineObject({this.sessions});

  VaccineObject.fromJson(Map<String, dynamic> json) {
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(new Sessions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sessions != null) {
      data['sessions'] = this.sessions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sessions {
  int? centerId;
  String? name;
  String? address;
  String? stateName;
  String? districtName;
  String? blockName;
  int? pincode;
  String? from;
  String? to;
  int? lat;
  int? long;
  String? feeType;
  String? sessionId;
  String? date;
  int? availableCapacityDose1;
  int? availableCapacityDose2;
  int? availableCapacity;
  String? fee;
  int? minAgeLimit;
  String? vaccine;
  List<dynamic>? slots;

  Sessions(
      {this.centerId,
        this.name,
        this.address,
        this.stateName,
        this.districtName,
        this.blockName,
        this.pincode,
        this.from,
        this.to,
        this.lat,
        this.long,
        this.feeType,
        this.sessionId,
        this.date,
        this.availableCapacityDose1,
        this.availableCapacityDose2,
        this.availableCapacity,
        this.fee,
        this.minAgeLimit,
        this.vaccine,
        this.slots});

  Sessions.fromJson(Map<String, dynamic> json) {
    centerId = json['center_id'];
    name = json['name'];
    address = json['address'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    blockName = json['block_name'];
    pincode = json['pincode'];
    from = json['from'];
    to = json['to'];
    lat = json['lat'];
    long = json['long'];
    feeType = json['fee_type'];
    sessionId = json['session_id'];
    date = json['date'];
    availableCapacityDose1 = json['available_capacity_dose1'];
    availableCapacityDose2 = json['available_capacity_dose2'];
    availableCapacity = json['available_capacity'];
    fee = json['fee'];
    minAgeLimit = json['min_age_limit'];
    vaccine = json['vaccine'];
    slots = json['slots'];
    print(slots);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['center_id'] = this.centerId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['state_name'] = this.stateName;
    data['district_name'] = this.districtName;
    data['block_name'] = this.blockName;
    data['pincode'] = this.pincode;
    data['from'] = this.from;
    data['to'] = this.to;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['fee_type'] = this.feeType;
    data['session_id'] = this.sessionId;
    data['date'] = this.date;
    data['available_capacity_dose1'] = this.availableCapacityDose1;
    data['available_capacity_dose2'] = this.availableCapacityDose2;
    data['available_capacity'] = this.availableCapacity;
    data['fee'] = this.fee;
    data['min_age_limit'] = this.minAgeLimit;
    data['vaccine'] = this.vaccine;
    data['slots'] = this.slots;
    return data;
  }
}