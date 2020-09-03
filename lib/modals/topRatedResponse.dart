import 'package:ohmi/modals/topRated.dart';

class TopRatedResponse {
  final List<TopRated> topRateds;
  final String error;

  TopRatedResponse({
    this.topRateds,
    this.error,
  });

  TopRatedResponse.fromJson(Map<String, dynamic> json)
      : topRateds = (json['results'] as List)
            .map(
              (data) => TopRated.fromJson(data),
            )
            .toList(),
        error = '';

  TopRatedResponse.withError(String error)
      : topRateds = List(),
        error = error;
}
