import 'package:flutter/material.dart';

class RecommendedForYouCardUI extends StatelessWidget {
  String title;
  String subtitle;
  String imgUrl;

  RecommendedForYouCardUI({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              offset: Offset(1, 1),
              spreadRadius: 0.0,
            )
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
            child: Image.network(
              imgUrl,
              width: MediaQuery.of(context).size.width,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        style: theme.textTheme.headline6,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        subtitle,
                        maxLines: 1,
                        style: theme.textTheme.subtitle2!.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Color(0xFF7B7B80),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
