import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/api/getArticles.dart';
import 'package:pet/common/component/appbars/appbar.dart';
import 'package:pet/const/models/articles.dart';
import 'package:pet/pages/community/post_list.dart';
import 'package:pet/pages/community/posting_page.dart';
import 'package:pet/style/colors.dart';

//ListView.builder 활용해서 무한스크롤 구현?
class Community extends ConsumerWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        appBar: Appbar(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40, bottom: 20, left: 10, right: 10),
              decoration: BoxDecoration(
                color: WHITE,
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.2))
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Category(categoryName: '일상'),
                Category(categoryName: '도움'),
                Category(categoryName: 'QnA'),
                Category(categoryName: '정보&후기'),
              ],),
            ),
            Expanded(
              child: Stack(
                children: [
                  FutureBuilder(
                      future: GetArticles.getArticles(),
                      builder:(context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          // 로딩 중....
                        }
                        if(snapshot.hasData){
                          return PostList(length: snapshot.data!.length , comments: snapshot.data!);
                        }
                        else{
                          //에러 처리
                          return Text('로딩 중');
                        }
                      }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 20),
                      width: 150,
                      height: 60,
                      child: PostButton()
                    ),
                  )
                ],
              )
            )
          ],
        )
      ),
    );
  }
}



class Category extends StatelessWidget {
  final String categoryName;
  const Category({
    super.key,
    required this.categoryName
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: (){
          print('Category Pessed');},
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: GREY2,
                shape: BoxShape.circle
              ),
            ),
            Text(categoryName, style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
      ),
    );
  }
}
class PostButton extends StatelessWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          backgroundColor: PRIMARY_COLOR,
          splashFactory: NoSplash.splashFactory,
          foregroundColor: BLACK,

        ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const PostingPage()));
        },
        child: Text('글쓰기', style: Theme.of(context).textTheme.bodyMedium,));
  }
}



