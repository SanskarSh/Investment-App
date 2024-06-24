class LeaderBoardModel {
  final String id;
  final int coins;
  final String name;
  final bool isCurrentUser;

  LeaderBoardModel({
    required this.id,
    required this.coins,
    required this.name,
    required this.isCurrentUser,
  });

  factory LeaderBoardModel.fromJson(Map<String, dynamic> json) {
    return LeaderBoardModel(
      id: json['_id'] ?? "",
      coins: json['coins'] is int ? json['coins'] : 0,
      name: json['name'] ?? "",
      isCurrentUser: json['currentUser'] is bool ? json['currentUser'] : false,
    );
  }
}

class ApiResponseModel {
  final String type;
  final String message;
  final List<LeaderBoardModel> leaderBoardUsers;

  ApiResponseModel({
    required this.type,
    required this.message,
    required this.leaderBoardUsers,
  });

  factory ApiResponseModel.from(Map<String, dynamic> json) {
    return ApiResponseModel(
      type: json['type'] ?? "",
      message: json['message'] ?? "",
      leaderBoardUsers: json['data'] != null
          ? List<LeaderBoardModel>.from(
              json['data'].map((x) => LeaderBoardModel.fromJson(x)))
          : [],
    );
  }
}
