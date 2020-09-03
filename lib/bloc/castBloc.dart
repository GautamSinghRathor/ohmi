import 'package:flutter/foundation.dart';
import 'package:ohmi/modals/cast_response.dart';
import 'package:ohmi/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class CastBloc {
  MovieRepository _repository = MovieRepository();
  BehaviorSubject<CastResponse> _subject = BehaviorSubject<CastResponse>();

  Future<CastBloc> getCast(int id) async {
    final response = await _repository.getCast(id);
    _subject.sink.add(response);
  }

  void drain() {
    _subject.value = null;
  }

  @mustCallSuper
  Future<void> dispons() async {
    await _subject.drain();
    await _subject.close();
  }

  Stream<CastResponse> get subject => _subject.stream;
}

final castBloc = CastBloc();
