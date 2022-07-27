import 'dart:math';
import 'package:flutter/material.dart';

import 'menu_tab.dart';

class Surprise extends StatefulWidget {
  const Surprise({Key? key}) : super(key: key);
  static const routeName = '/test3';
  @override
  State<Surprise> createState() => _SurpriseState();
}

class _SurpriseState extends State<Surprise> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor:const Color(0xFFfafafa),
        body:CustomScrollView(
          slivers: <Widget>[
            _buildBanner(),
            _buildStickyBar(),
            _buildList(),
          ],
        )
    );
  }

  Widget _buildBanner() {
    return SliverToBoxAdapter(
        child:SizedBox(
          height: 200,
          child:Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.network(
                  "https://img30.360buyimg.com/img/jfs/t1/92581/29/20454/374562/61de544fE1d5e1e34/f69d41d732f3fe81.jpg",
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                  bottom: -1,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    height: 10,
                    decoration:const BoxDecoration(
                        color:Color(0xFFfafafa),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        )
                    ),
                  )
              )
            ],
          ),
        )
    );
  }

  Widget _buildStickyBar() {
    return SliverPersistentHeader(
      pinned: true, //是否固定在顶部
      floating: true,
      delegate: _SliverAppBarDelegate(
          minHeight: 50, //收起的高度
          maxHeight: 50, //展开的最大高度
          child: Container(
            padding: const EdgeInsets.only(left: 16),
            color:const Color(0xFFfafafa),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: const Text("精选", style: TextStyle(fontSize: 18)),
                ),
                Expanded(
                    child:MenuTab(
                      menuList:const [
                        {"value":"1","text":"京喜自营"},
                        {"value":"2","text":"母婴玩具"},
                        {"value":"3","text":"生活百货"},
                        {"value":"4","text":"酒水饮料"},
                        {"value":"5","text":"家清纸品"},
                        {"value":"6","text":"米面粮油"},
                        {"value":"7","text":"数码配件"},
                        {"value":"8","text":"大小家电"},
                        {"value":"9","text":"服饰鞋靴"},
                        {"value":"10","text":"美妆个护"},
                        {"value":"11","text":"休闲零食"},
                      ],
                      onPress: (e){
                        setState(() {
                        });
                      },
                    )
                )
              ],
            ),
          )),
    );
  }

  Widget _buildList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {

            return Container(
              height: 100,
              alignment: Alignment.center,
              child: Text("$index,Container"),
            );
          },
          childCount:10,
        ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

