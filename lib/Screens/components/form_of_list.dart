import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lbz/commen_models/models.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FormOfList extends StatefulWidget {
  const FormOfList({Key? key, required this.images}) : super(key: key);
  final List<Images> images;
  @override
  _FormOfListState createState() => _FormOfListState();
}

class _FormOfListState extends State<FormOfList> {
  int activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          items: widget.images
              .map((e) => Image(
                    image: NetworkImage(e.url.toString()),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset('assets/image/lbz.png',fit: BoxFit.contain,),
            loadingBuilder: (context, child, loadingProgress) {
              if(loadingProgress == null) {
                return child;
              }
              return Center(child: CircularProgressIndicator(value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded/loadingProgress.expectedTotalBytes!:null,),);
            },
                  ))
              .toList(),
          options: CarouselOptions(
            height: 225,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: false,
            autoPlay: false,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                activePage = index;
              });
            },
          ),
        ),
        if (widget.images.length > 1)
          AnimatedSmoothIndicator(
            activeIndex: activePage,
            count: widget.images.length,
            effect: const ScrollingDotsEffect(
                activeDotColor: Colors.white,
                dotColor: Color(0xffaeaeae),
                dotHeight: 8,
                dotWidth: 8),
          ),
      ],
    );
  }
}
