import 'package:algo_test/model/meme_model.dart';

import 'api.dart';

class Repository{
  final api = Api();

  Future<MemeModel?> getMeme() => api.fetchMeme();
}