import 'package:flutter/material.dart';
import 'package:libozzle/assets/flaticon_icons.dart';
import 'package:libozzle/shared/styles/colors.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerListItem() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    clipBehavior: Clip.antiAlias,
    elevation: 2,
    child: SizedBox(
      width: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              color: Colors.grey,
              width: 160,
              height: 100,
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                color: Colors.grey,
                height: 5,
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                color: Colors.grey,
                height: 5,
                width: 100,
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[300]!,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                color: Colors.grey,
                height: 5,
                width: 50,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget shimmerGridItem() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    elevation: 1,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[300]!,
          direction: ShimmerDirection.rtl,
          child: const Icon(
            FlatIcon.user,
            color: Colors.grey,
            size: 50,
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[300]!,
          child: const Text(
            'Loading!',
            style: TextStyle(
              fontSize: 19,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget shimmerPostForm() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: const Image(
          image: AssetImage('assets/image/libozzle.png'),
          width: double.infinity,
          height: 225,
          fit: BoxFit.contain,
        ),
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          height: 10,
          width: 100,
        ),
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          height: 10,
          width: double.infinity,
        ),
      ),
      SizedBox(
        height: 30,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[300]!,
              child: Row(
                children: const [
                  Icon(
                    Icons.bed_outlined,
                    size: 25,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    'Text is loading',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            width: 15,
          ),
        ),
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Row(
          children: const [
            Icon(
              Icons.location_on,
              size: 18,
              color: darkGrayDefaultColor,
            ),
            Text(
              'Loading location',
              style: TextStyle(color: darkGrayDefaultColor),
            ),
          ],
        ),
      ),
    ],
  );
}
