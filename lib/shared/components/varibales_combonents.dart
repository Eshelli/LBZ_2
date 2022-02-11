// import 'dart:ffi';
//
// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:udemy_bmi/modules/BMI/bmi_result_screen.dart';
// import 'package:udemy_bmi/modules/Cubit/counter_cubit.dart';
// import 'package:udemy_bmi/modules/news_app/wepview.dart';
//
// Widget defaultButton({
//   required double width ,
//   required Color  bachground ,
//   required  press,
//   required String text,
//   double redius = 0.0,
// }) =>   Container(
//   width: width,
//   height: 40,
//   decoration: BoxDecoration(
//     color: bachground,
//     borderRadius: BorderRadius.circular(redius)
//   ),
//   child: MaterialButton(
//
//     onPressed: press,
//     child: Text(
//       text.toUpperCase(),
//       style:  TextStyle(
//           color: Colors.white
//       ),
//     ),
//   ),
// );
// Widget defualtTextform({
//   required var Controler,
//   required TextInputType type,
//   required String label,
//   required IconData prefixicon,
//    IconData? suffixicon,
// Function? tab()?,
//   Function? onTap()?,
//   bool readOnly = false,
//   required  validator,
//
//   Function? onSubmitted(String value)?,
//   Function? onChanged(String value)?,
//   bool obscure = false,
//
// }) => TextFormField(
//   obscureText: obscure,
//   readOnly: readOnly,
//   controller: Controler,
//   keyboardType: type,
//   validator: validator,
//   onFieldSubmitted: onSubmitted,
//   onTap: onTap,
//   onChanged: onChanged,
//   decoration: InputDecoration(
//     // hintText: 'Email address',
//     labelText: label,
//     labelStyle: TextStyle(
//       color: Colors.grey[300]
//     ),
//     border: OutlineInputBorder( ),
//     prefixIcon: Icon(prefixicon),
//     suffixIcon: suffixicon != null ? IconButton(onPressed: tab,icon:  Icon(suffixicon)) : null,
//   ),
// );
// Widget getdata(Map model,context)=>Dismissible(
//   key: Key(model['id'].toString()),
//   child:   Padding(
//     padding: const EdgeInsets.all(20),
//     child: Row(
//       children: [
//         CircleAvatar(
//           radius: 40,
//           child: Text(
//               '${model['time']}'
//           ),
//         ),
//         SizedBox(width: 10,),
//         Expanded(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//           '${model['title']}',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               SizedBox(height: 5,),
//               Text(
//                   '${model['date']}',
//                 style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.grey[600]
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(width: 10,),
//         Column(
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                     onPressed: (){
//                       DatabaseCubit.get(context).updateDatabase(status: 'Done',id: model['id']);
//                     },
//                     icon: Icon(
//                       Icons.check_circle_outline,
//                       color: Colors.green[300],
//                     )
//                 ),
//                 SizedBox(width: 5,),
//                 IconButton(
//                     onPressed: (){
//                       DatabaseCubit.get(context).updateDatabase(status: 'Archived',id: model['id']);
//                     },
//                     icon: Icon(
//                       Icons.archive,
//                       color: Colors.grey[300],
//
//                     )
//                 ),
//               ],
//             ),
//
//           ],
//         )
//       ],
//     ),
//   ),
//   onDismissed: (direction){
//     DatabaseCubit.get(context).deleteDatabase(id: model['id']);
//   },
// );
// Widget fallback()=> Center(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Icon(
//         Icons.menu,
//         size: 60,
//         color: Colors.grey,
//       ),
//       Text(
//         'No Tasks To Show',
//         style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//             color: Colors.grey
//         ),
//       )
//
//     ],
//   ),
// );
// Widget conbuilder(List<Map> tasks)=> ConditionalBuilder(
//   condition: tasks.length>0,
//   builder: (context) => ListView.separated(
//       itemBuilder: (context, index) => getdata(tasks[index], context),
//       separatorBuilder: (context, index) => Padding(
//         padding: EdgeInsetsDirectional.only(start: 20),
//         child: Container(
//           width: double.infinity,
//           height: 1,
//           color: Colors.grey[300],
//         ),
//       ),
//       itemCount: tasks.length),
//   fallback: (context) => fallback(),
// );
// Widget newsRow(Map article,context)=>InkWell(
//   onTap: (){
//    navigatto(context, WepViewScreen(article['url']));
//   },
//   child:   Padding(
//
//     padding: const EdgeInsets.all(15),
//
//     child: Row(
//
//       children: [
//
//         Container(
//
//           width: 120,
//
//           height: 120,
//
//           decoration: BoxDecoration(
//
//               borderRadius: BorderRadius.circular(10),
//
//               image: DecorationImage(
//
//                   image: NetworkImage('${article['urlToImage']}'),
//
//                   fit: BoxFit.cover
//
//               )
//
//           ),
//
//         ),
//
//         SizedBox(
//
//           width: 20,
//
//         ),
//
//         Expanded(
//
//           child: Container(
//
//             height: 120,
//
//             child: Column(
//
//               mainAxisSize: MainAxisSize.max,
//
//               mainAxisAlignment: MainAxisAlignment.start,
//
//               crossAxisAlignment: CrossAxisAlignment.start,
//
//               children:
//
//               [
//
//                 Expanded(
//
//                   child: Text(
//
//                     '${article['title']}',
//
//                     overflow: TextOverflow.ellipsis,
//
//                     textAlign: TextAlign.end,
//
//                     style: Theme.of(context).textTheme.subtitle1,
//
//                     maxLines: 3,
//
//                   ),
//
//                 ),
//
//                 Text(
//
//                   '${article['publishedAt']}',
//
//                   overflow: TextOverflow.ellipsis,
//
//                   style: TextStyle(
//
//                       color: Colors.grey,
//
//                       fontSize: 18,
//
//                       fontWeight: FontWeight.w600
//
//                   ),
//
//                   maxLines: 1,
//
//                 )
//
//
//
//               ],
//
//             ),
//
//           ),
//
//         )
//
//       ],
//
//     ),
//
//   ),
// );
// Widget newsRowSeparator()=>Padding(
//   padding: const EdgeInsetsDirectional.only(start: 15),
//   child: Container(
//     width: double.infinity,
//     height: 1.0,
//     color: Colors.grey[300],
//   ),
// );
// Widget articelBuilder(list,{isSearch = false})=>ConditionalBuilder(
//   condition: list.length>0,
//   builder: (context) {
//     return ListView.separated(
//         physics:  BouncingScrollPhysics(),
//         itemBuilder: (context, index) => newsRow(list[index],context),
//         separatorBuilder: (context, index) => newsRowSeparator(),
//         itemCount: list.length
//     );
//   },
//   fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator()),
//
// );
//
// void navigatto(context,widget)=>Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => widget,),
// );

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lbz/shared/styles/colors.dart';

var width;
var height;
bool? newAd;

Future dialog(List<Widget> content) {
  return Get.dialog(
    SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      children: content,
    ),
  );
}

Widget defualtTextForm(
  context, {
  required var controler,
  required TextInputType type,
  String label = 'Title',
  IconData? prefixicon,
  Color clr = darkGrayDefaultColor,
  IconData? suffixicon,
  int maxLine = 1,
  Color background = Colors.white,
  Function? tab()?,
  Function? onTap()?,
  bool readOnly = false,
  validator,
  Function? onSubmitted(String value)?,
  Function? onChanged(String value)?,
  bool obscure = false,
  required double radius,
  var textDirection = TextDirection.rtl,
}) =>
    TextFormField(
      textDirection: textDirection,
      obscureText: obscure,
      readOnly: readOnly,
      controller: controler,
      keyboardType: type,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      onChanged: onChanged,
      maxLines: maxLine,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        // hintText: 'Email address',
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,

        labelStyle: TextStyle(color: clr),
        alignLabelWithHint: false,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: clr),
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: blackDefaultColor),
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
        prefixIcon: prefixicon != null
            ? Icon(
                prefixicon,
                color: clr,
              )
            : null,
        suffixIcon: suffixicon != null
            ? IconButton(
                onPressed: tab,
                icon: Icon(
                  suffixicon,
                  color: clr,
                ))
            : null,
      ),
    );

Widget defualtTextForm2(
  context, {
  required var controler,
  required TextInputType type,
  String label = 'Title',
  IconData? prefixicon,
  Color clr = darkGrayDefaultColor,
  IconData? suffixicon,
  int maxLine = 1,
  Color background = Colors.white,
  Function? tab()?,
  Function? onTap()?,
  bool readOnly = false,
  validator,
  Function? onSubmitted(String value)?,
  Function? onChanged(String value)?,
  bool obscure = false,
  required double radius,
  var textDirection = TextDirection.rtl,
}) =>
    TextFormField(
      textDirection: textDirection,
      obscureText: obscure,
      readOnly: readOnly,
      controller: controler,
      keyboardType: type,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      onChanged: onChanged,
      maxLines: maxLine,
      textAlignVertical: TextAlignVertical.top,
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        // hintText: 'Email address',
        labelText: label,

        labelStyle: TextStyle(color: clr),
        alignLabelWithHint: false,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: clr),
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: blackDefaultColor),
          borderRadius: BorderRadius.circular(
            radius,
          ),
        ),
        prefixIcon: prefixicon != null
            ? Icon(
                prefixicon,
                color: clr,
              )
            : null,
        suffixIcon: suffixicon != null
            ? IconButton(
                onPressed: tab,
                icon: Icon(
                  suffixicon,
                  color: clr,
                ))
            : null,
      ),
    );

Widget buttonUserForm(String text, IconData icon, var backColor,
    {var mainAxis = MainAxisAlignment.start,
    txtColor = Colors.black,
    iconColor = redDefaultColor,
    double size = 25,
    onPress}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10),
    child: MaterialButton(
      onPressed: onPress,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: backColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: mainAxis,
          children: [
            Flexible(
              flex: 1,
              child: Icon(
                icon,
                color: iconColor,
                size: size,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Flexible(
                flex: 2,
                child: FittedBox(
                    child: Text(text,
                        style: TextStyle(fontSize: 20, color: txtColor)))),
          ],
        ),
      ),
      height: 50,
    ),
  );
}