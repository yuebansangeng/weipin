class UserModel {
  int? memberId; // 用户id
  String? username;
  String? tel;
  int? role;
  int? dataCompletionB; //0 未补全 1 已补全
  int? dataCompletionC; //0 未补全 1 已补全
  int? identityB; // 0否 1是
  int? identityC; // 0否 1是
  int? registerState; //0 未登录 1已登录
  String? ticket; //用户登录凭证
  int? createdStime;
  int? modifiedStime;

  UserModel(
      {this.memberId,
      this.username,
      this.tel,
      this.role,
      this.dataCompletionB,
      this.dataCompletionC,
      this.identityB,
      this.identityC,
      this.registerState,
      this.ticket,
      this.createdStime,
      this.modifiedStime});

  UserModel.fromJson(Map<String, dynamic> json) {
    memberId = json['memberId'];
    username = json['username'];
    tel = json['tel'];
    role = json['role'];
    dataCompletionB = json['dataCompletionB'];
    dataCompletionC = json['dataCompletionC'];
    identityB = json['identityB'];
    identityC = json['identityC'];
    registerState = json['registerState'];
    ticket = json['ticket'];
    createdStime = json['createdStime'];
    modifiedStime = json['modifiedStime'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['memberId'] = memberId;
    _data['username'] = username;
    _data['tel'] = tel;
    _data['role'] = role;
    _data['dataCompletionB'] = dataCompletionB;
    _data['dataCompletionC'] = dataCompletionC;
    _data['identityB'] = identityB;
    _data['identityC'] = identityC;
    _data['registerState'] = registerState;
    _data['ticket'] = ticket;
    _data['createdStime'] = createdStime;
    _data['modifiedStime'] = modifiedStime;
    return _data;
  }
}
