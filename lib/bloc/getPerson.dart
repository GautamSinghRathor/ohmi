import 'package:ohmi/modals/personResponse.dart';
import 'package:ohmi/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class PersonBloc {
  BehaviorSubject<PersonResponse> _subject = BehaviorSubject<PersonResponse>();
  MovieRepository repository = MovieRepository();

  Future<void> getPersons() async {
    final response = await repository.getPersons();
    _subject.sink.add(response);
  }

  void dispose() async {
    await _subject.close();
  }

  Stream<PersonResponse> get subject => _subject.stream;
}

final personBloc = PersonBloc();
