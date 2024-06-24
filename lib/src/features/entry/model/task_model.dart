class TaskModel {
  final String id;
  final String title;
  final double amount;
  final int coins;
  final String type;
  final int v;
  final bool status;

  TaskModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.coins,
    required this.type,
    required this.v,
    required this.status,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['_id'],
      title: json['title'],
      amount: json['amt'].toDouble(),
      coins: json['coins'],
      type: json['type'],
      v: json['__v'],
      status: json['status'],
    );
  }
}

class ApiResponseModel {
  final String type;
  final String message;
  final List<TaskModel> task;

  ApiResponseModel({
    required this.type,
    required this.message,
    required this.task,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      type: json['type'],
      message: json['message'],
      task: (json['tasks'] as List)
          .map((item) => TaskModel.fromJson(item))
          .toList(),
    );
  }
}
