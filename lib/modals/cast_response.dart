import 'package:ohmi/modals/cast.dart';

class CastResponse {
  final List<Cast> cast;
  final String error;

  CastResponse({
    this.cast,
    this.error,
  });

  CastResponse.fromJson(Map<String, dynamic> json)
      : cast = (json['cast'] as List)
            .map(
              (c) => Cast.fromJson(c),
            )
            .toList(),
        error = '';

  CastResponse.withError(String errorValue)
      : cast = List(),
        error = errorValue;
}
