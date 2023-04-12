class CModel {
  int? age; // 用户id
  DateTime? birthDay;
  DateTime? firstWorkingTime;
  int? companyId;
  String? headPic;
  double? hopeHighSalary; //期望薪资
  double? hopeLowSalary; //期望薪资
  int? hopePositionId; //职位id
  String? hopePositionName; //职位name
  int? identity; // 0职场人 1学生
  String? jobContent; // 0否 1是
  int? jobStatusId; //0 求职状态id
  String? jobStatusName;
  String? locationId; //职位
  String? locationName; //职位名称
  String? nickName;
  String? personalAdvantage;
  int? positionId;
  String? positionName; //职位id
  int? qualificationsId;
  String? qualificationsName;
  int? qualificationsType;
  String? realName;
  String? recentlyCompany;
  DateTime? recentlyCompanyEndTime;
  DateTime? recentlyCompanyStartTime;
  DateTime? schoolEndTime;
  String? schoolName;
  DateTime? schoolStartTime;
  int? sex;
  String? specializedSubject;
  int? specializedId; //专业id
  String? ticket;

  CModel(
      {this.age, // 用户id
      this.birthDay,
      this.firstWorkingTime,
      this.companyId,
      this.headPic,
      this.hopeHighSalary,
      this.hopeLowSalary,
      this.identity,
      this.jobContent,
      this.jobStatusId, //0 求职状态id
      this.jobStatusName, //求职状态名称
      this.locationId,
      this.locationName,
      this.nickName,
      this.personalAdvantage,
      this.positionId, //职位id
      this.positionName, //职位名称
      this.hopePositionId, //期望职位id
      this.hopePositionName, //期望职位名称
      this.qualificationsId,
      this.qualificationsName,
      this.qualificationsType,
      this.realName,
      this.recentlyCompany,
      this.recentlyCompanyEndTime,
      this.recentlyCompanyStartTime,
      this.schoolEndTime,
      this.schoolName,
      this.schoolStartTime,
      this.sex,
      this.specializedSubject,
      this.specializedId,
      this.ticket});

  CModel.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    if (json['birthDay'] != null) {
      birthDay = DateTime.fromMillisecondsSinceEpoch(json['birthDay']);
    } else {
      birthDay = DateTime.parse('19920201');
    }
    if (json['firstWorkingTime'] != null) {
      firstWorkingTime =
          DateTime.fromMillisecondsSinceEpoch(json['firstWorkingTime']);
    } else {
      firstWorkingTime =
          DateTime.parse('${DateTime.now().year.toString()}0101');
    }
    companyId = json['companyId'];
    headPic = json['headPic'];
    hopeHighSalary = json['hopeHighSalary'];
    hopeLowSalary = json['hopeLowSalary'];
    hopePositionId = json['hopePositionId'];
    hopePositionName = json['hopePositionName'];
    identity = json['identity'];
    jobContent = json['jobContent'];
    jobStatusId = json['jobStatusId'];
    jobStatusName = json['jobStatusName'];
    locationId = json['locationId'];
    locationName = json['locationName'];
    nickName = json['nickName'];
    personalAdvantage = json['personalAdvantage'];
    positionId = json['positionId'];
    positionName = json['positionName'];
    qualificationsId = json['qualificationsId'];
    qualificationsType = json['qualificationsType'];
    realName = json['realName'];
    recentlyCompany = json['recentlyCompany'];
    if (json['recentlyCompanyEndTime'] != null) {
      recentlyCompanyEndTime =
          DateTime.fromMillisecondsSinceEpoch(json['recentlyCompanyEndTime']);
    } else {
      recentlyCompanyEndTime =
          DateTime.parse('${DateTime.now().year.toString()}0101');
    }
    if (json['recentlyCompanyStartTime'] != null) {
      recentlyCompanyStartTime =
          DateTime.fromMillisecondsSinceEpoch(json['recentlyCompanyStartTime']);
    } else {
      recentlyCompanyStartTime =
          DateTime.parse('${DateTime.now().year.toString()}0101');
    }
    if (json['schoolEndTime'] != null) {
      schoolEndTime =
          DateTime.fromMillisecondsSinceEpoch(json['schoolEndTime']);
    } else {
      schoolEndTime = DateTime.parse('${DateTime.now().year.toString()}0101');
    }
    if (json['schoolStartTime'] != null) {
      schoolStartTime =
          DateTime.fromMillisecondsSinceEpoch(json['schoolStartTime']);
    } else {
      schoolStartTime = DateTime.parse('${DateTime.now().year.toString()}0101');
    }
    schoolName = json['schoolName'];
    sex = json['sex'];
    specializedSubject = json['specializedSubject'];
    specializedId = json['specializedId'];

    ticket = json['ticket'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['age'] = age;
    _data['birthDay'] = birthDay?.toString().split(' ')[0];
    _data['firstWorkingTime'] = firstWorkingTime?.toString().split(' ')[0];
    _data['companyId'] = companyId;
    _data['headPic'] = headPic;
    _data['hopeHighSalary'] = hopeHighSalary;
    _data['hopeLowSalary'] = hopeLowSalary;
    _data['hopePositionId'] = hopePositionId;
    _data['hopePositionName'] = hopePositionName;
    _data['identity'] = identity;
    _data['jobContent'] = jobContent;
    _data['jobStatusId'] = jobStatusId;
    _data['jobStatusName'] = jobStatusName;
    _data['locationId'] = locationId;
    _data['locationName'] = locationName;
    _data['nickName'] = nickName;
    _data['personalAdvantage'] = personalAdvantage;
    _data['positionId'] = positionId;
    _data['positionName'] = positionName;
    _data['qualificationsId'] = qualificationsId;
    _data['qualificationsType'] = qualificationsType;
    _data['realName'] = realName;
    _data['recentlyCompany'] = recentlyCompany;
    _data['recentlyCompanyEndTime'] =
        recentlyCompanyEndTime?.toString().split(' ')[0];
    _data['recentlyCompanyStartTime'] =
        recentlyCompanyStartTime?.toString().split(' ')[0];
    _data['schoolEndTime'] = schoolEndTime?.toString().split(' ')[0];
    _data['schoolName'] = schoolName;
    _data['schoolStartTime'] = schoolStartTime?.toString().split(' ')[0];
    _data['sex'] = sex;
    _data['specializedSubject'] = specializedSubject;
    _data['specializedId'] = specializedId;
    _data['ticket'] = ticket;
    return _data;
  }
}
