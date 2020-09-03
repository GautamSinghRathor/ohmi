class YoutubeResponse {
  final String key;
  final String error;

  YoutubeResponse({
    this.key,
    this.error,
  });

  YoutubeResponse.fromJson(Map<String, dynamic> json)
      : key = json['results'][0]['key'],
        error = '';

  YoutubeResponse.withError(erroValue)
      : key = '',
        error = '';
}
