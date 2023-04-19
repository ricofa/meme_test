import 'package:algo_test/model/meme_model.dart';
import 'package:rxdart/rxdart.dart';

import '../provider/provider.dart';

class MemeBloc {
  final _repo = Repository();
  final _meme = BehaviorSubject<MemeModel>();

  Stream<MemeModel> get memeStream => _meme.stream;

  fetchMeme() async {
    MemeModel? model = await _repo.getMeme();
    _meme.sink.add(model!);
  }

  refresh() async{
    await fetchMeme();
  }

  dispose() {
    _meme.close();
  }
}

final bloc = MemeBloc();