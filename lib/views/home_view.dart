import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _listItem('いよいよ寿命？ 40年以上の使用に耐えたエアコン「霧ヶ峰」が懐かしすぎると話題に',
            const Icon(Icons.settings));
      },
    );
  }

  Widget _listItem(String title, Icon icon) {
    return GestureDetector(
      onTap: () {
        print('onTap');
      },
      child: Container(
          height: 120,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(0),
                child: Image.network('http://placehold.jp/200x200.png'),
              ),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          )),
    );
  }
}
