import 'package:ohmi/modals/person.dart';

class PersonResponse {
  final List<Person> persons;
  final String error;

  PersonResponse({
    this.persons,
    this.error,
  });

  PersonResponse.fromJson(Map<String, dynamic> json)
      : persons = (json['results'] as List)
            .map(
              (data) => Person.fromJson(data),
            )
            .toList(),
        error = '';

  PersonResponse.withError(String error)
      : persons = List(),
        error = error;
}
