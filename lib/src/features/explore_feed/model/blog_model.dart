class VideoModel {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final int v;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.v,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      v: json['__v'],
    );
  }
}

class ApiResponseModel {
  final String type;
  final String message;
  final List<VideoModel> data;

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
          .map((item) => VideoModel.fromJson(item))
          .toList(),
    );
  }
}
