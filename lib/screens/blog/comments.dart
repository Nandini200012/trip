import 'package:flutter/material.dart';

import '../../api_services/blog_api/get_comments_api.dart';

class HorizontalListViewContainer extends StatefulWidget {
  final List<Comments> comments;

  HorizontalListViewContainer({Key key, this.comments}) : super(key: key);

  @override
  _HorizontalListViewContainerState createState() =>
      _HorizontalListViewContainerState();
}

class _HorizontalListViewContainerState
    extends State<HorizontalListViewContainer> {
  @override
  Widget build(BuildContext context) {
    var sheight = MediaQuery.of(context).size.height;
    var swidth = MediaQuery.of(context).size.width;

    return Container(
      height: sheight * 0.1,
      width: swidth * 0.5,
      // color: Color.fromARGB(255, 222, 221, 218),
      child: Center(
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(width: 8,),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(), 
          itemCount: widget.comments.length>6?6:widget.comments.length,
          itemBuilder: (context, index) {
            var comment = widget.comments[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(width:0.1,color: Colors.grey)
              ),
              // height: 50,
              width: 100,
              child: SizedBox(height: 50,
              width: 100,
                child: Center(child: Text(comment.comment))),
            );
          },
        ),
      ),
    );
  }
}
