class ResumeModel {
  String? name;
  String? sex;
  String? birth;
  int? idenity; //0 职场人 1学生
  int? role; //0 离职-随时到岗 1 在职-月内到岗 2 在职-考虑机会 3 在职-暂不考虑
  String? workday; //参加工作时间
  String? lastwork; //最近一次工作
  String? lastcompany; //最近就职公司
  String? daterange; //最近就职公司入职时间段
  String? content; //工作内容
  String? education; //学历
  String? education_type; // 0 全日制 1非全日制
  String? school; //毕业院校
  String? major; //专业
  String? education_range; //就读时间段
  String? expectation_city; //期望城市
  String? expectation_position; //期望职位
  String? expectation_min; //期望薪资最低
  String? expectation_max; //期望薪资最高
  String? advantage; //个人优势

  ResumeModel({
    this.name,
    this.sex,
    this.birth,
    this.idenity,
    this.role,
    this.workday,
    this.lastwork,
    this.lastcompany,
    this.daterange,
    this.content,
    this.education,
    this.education_type,
    this.school,
    this.major,
    this.education_range,
    this.expectation_city,
    this.expectation_position,
    this.expectation_min,
    this.expectation_max,
    this.advantage,
  });

  ResumeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    sex = json['sex'];
    birth = json['birth'];
    idenity = json['idenity'];
    role = json['role'];
    workday = json['workday'];
    lastwork = json['lastwork'];
    lastcompany = json['lastcompany'];
    daterange = json['daterange'];
    content = json['content'];
    education = json['education'];
    education_type = json['education_type'];
    school = json['school'];
    major = json['major'];
    education_range = json['education_range'];
    expectation_city = json['expectation_city'];
    expectation_position = json['expectation_position'];
    expectation_min = json['expectation_min'];
    expectation_max = json['expectation_max'];
    advantage = json['advantage'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['sex'] = sex;
    _data['birth'] = birth;
    _data['idenity'] = idenity;
    _data['role'] = role;
    _data['workday'] = workday;
    _data['lastwork'] = lastwork;
    _data['lastcompany'] = lastcompany;
    _data['daterange'] = daterange;
    _data['content'] = content;
    _data['education'] = education;
    _data['education_type'] = education_type;
    _data['school'] = school;
    _data['major'] = major;
    _data['education_range'] = education_range;
    _data['expectation_city'] = expectation_city;
    _data['expectation_position'] = expectation_position;
    _data['expectation_min'] = expectation_min;
    _data['expectation_max'] = expectation_max;
    _data['advantage'] = advantage;
    return _data;
  }
}
