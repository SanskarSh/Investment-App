class QuizModel {
  final String question;
  final List<String> options;
  final int answer;
  final String explain;

  QuizModel({
    required this.question,
    required this.options,
    required this.answer,
    required this.explain,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      question: json['question'],
      options: List<String>.from(json['options']),
      answer: json['answer'],
      explain: json['explain'],
    );
  }
}

class ModuleModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final String content;
  final List<QuizModel> quiz;
  final int coins;
  final int version;
  final bool completed;

  ModuleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.content,
    required this.quiz,
    required this.coins,
    required this.version,
    required this.completed,
  });

  factory ModuleModel.fromJson(Map<String, dynamic> json) {
    return ModuleModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      content: json['content'],
      quiz: (json['quiz'] as List)
          .map((item) => QuizModel.fromJson(item))
          .toList(),
      coins: json['coins'],
      version: json['__v'],
      completed: json['completed'],
    );
  }
}

class ApiResponseModel {
  final String type;
  final String message;
  final List<ModuleModel> data;

  ApiResponseModel({
    required this.type,
    required this.message,
    required this.data,
  });

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) {
    return ApiResponseModel(
      type: json['type'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => ModuleModel.fromJson(item))
          .toList(),
    );
  }
}
