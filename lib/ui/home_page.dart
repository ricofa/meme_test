import 'package:algo_test/bloc/meme_bloc.dart';
import 'package:algo_test/model/meme_model.dart';
import 'package:algo_test/ui/detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    bloc.fetchMeme();
  }

  Future<dynamic> _refresh() async {
    await bloc.fetchMeme();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meme Generator"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(10),
        child: StreamBuilder<MemeModel>(
          stream: bloc.memeStream,
            builder: (context, AsyncSnapshot<MemeModel> snapshot){
              if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                      itemCount: snapshot.data!.data!.memes!.length,
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(imageUrl: snapshot.data!.data!.memes![index].url!))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              snapshot.data!.data!.memes![index].url!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
