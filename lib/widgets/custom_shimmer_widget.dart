import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ShimmerType {
  shortText,
  longText,
  longLargeText,
  roundedIcon,
  bigRoundedIcon,
  cardIcon,
  undefined,
  instrumentCard,
  none,
}

class CustomShimmerWidget extends StatelessWidget {
  final Widget child;
  final bool enable;
  final ShimmerType shimmerType;

  const CustomShimmerWidget({
    required Key key,
    required this.enable,
    required this.shimmerType,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!enable) {
      return child;
    } else {
      return Shimmer.fromColors(
        baseColor: enable ? Colors.grey.shade300 : Colors.transparent,
        highlightColor: enable ? Colors.grey.shade100 : Colors.transparent,
        child: _buildChild(),
      );
    }
  }

  Widget _buildChild() {
    switch (shimmerType) {
      case ShimmerType.shortText:
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey,
          ),
          child: Container(
            width: 30.0,
            height: 14.0,
            color: Colors.white,
          ),
        );
      case ShimmerType.longText:
        return Container(
          color: Colors.grey,
          child: Container(
            width: 100.0,
            height: 14.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey,
            ),
          ),
        );
      case ShimmerType.longLargeText:
        return Container(
          color: Colors.grey,
          child: Container(
            width: 280,
            height: 14.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey,
            ),
          ),
        );
      case ShimmerType.roundedIcon:
        return CircleAvatar(
          child: SizedBox(
            width: 30,
            height: 30,
          ),
        );
      case ShimmerType.bigRoundedIcon:
        return CircleAvatar(
          child: SizedBox(
            width: 100,
            height: 100,
          ),
        );
      case ShimmerType.cardIcon:
        return Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: 50,
            height: 50,
          ),
        );
      case ShimmerType.instrumentCard:
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.4),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: double.infinity,
            height: 120,
          ),
        );
      case ShimmerType.undefined:
        return Container(color: Colors.grey, child: child);
      default:
        return Container(child: Container());
    }
  }
}
