import 'package:flutter/material.dart';
import 'package:flutter_app/Article.dart';

/// https://www.jianshu.com/p/3b105658728e

class ArticleListScreen extends StatelessWidget {

  final List<Article> articles = List.generate(10, (i) => Article(
    title: 'Article $i',
    content: 'Article $i: The quick brown fox jumps over the lazy dog.',
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article List"),
      ),
      body: ListView.builder(
          itemBuilder: (context, index){
              return ListTile(
                title: Text(articles[index].title),
                onTap: () async {
                  String result = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 1000),
                      pageBuilder: (context, _, __) => ContentScreen(articles[index]),
                      transitionsBuilder: (context, Animation<double> animation, __, Widget child) =>
                          FadeTransition(
                            opacity: animation,
                            child: RotationTransition(
                              turns: Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(animation),
                              child: child,
                            ),
                          )
                    )
                  );
                  if (result != null) {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text("$result"),
                        duration: const Duration(seconds: 1),
                      )
                    );
                  }
                },
              );
          },
        itemCount: articles.length,
      ),
    );
  }
}

class ContentScreen extends StatelessWidget {
  final Article article;

  ContentScreen(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${article.title}"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Text("${article.content}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: Text("Like"),
                  onPressed: () {
                    Navigator.pop(context, "Like");
                  },
                ),
                RaisedButton(
                  child: Text("Unlike"),
                  onPressed: () {
                    Navigator.pop(context, "Unlike");
                  },
                )
              ],
            )
          ],
        )
      ),
    );
  }
}