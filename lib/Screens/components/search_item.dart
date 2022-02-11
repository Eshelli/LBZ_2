import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:libozzle/Logics/app_logic/app_controller.dart';
import 'package:libozzle/Logics/profile_logic/models/search_model.dart';
import 'package:libozzle/Logics/profile_logic/profile_controller.dart';
import 'package:libozzle/Screens/components/components.dart';
import 'package:libozzle/assets/flaticon_icons.dart';
import 'package:libozzle/shared/components/constans.dart';
import 'package:libozzle/shared/components/varibales_combonents.dart';
import 'package:libozzle/shared/styles/colors.dart';

import '../ads_list.dart';

class SearchItem extends StatefulWidget {
  final DataSearch search;

  const SearchItem({Key? key, required this.search}) : super(key: key);

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  bool isChecked = false;
  var profileController = Get.find<ProfileController>();
  var appController = Get.find<AppController>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        filter.clear();
        taxonomySlug = widget.search.parameters.taxonomy;
        categorySlug = widget.search.parameters.category;
        appController.getAds(
          taxonomy: widget.search.parameters.taxonomy,
          category: widget.search.parameters.category,
          city: widget.search.parameters.city,
          priceFrom: widget.search.parameters.priceFrom,
          priceTo: widget.search.parameters.priceTo,
          keywords: widget.search.parameters.keywords,
          attb: widget.search.parameters.att,
        );
        Get.to(AdsList());
      },
      child: item(context),
    );
  }
  Widget item(BuildContext context){
    var size = MediaQuery.of(context).size;
    return Card(
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          // dismissible: DismissiblePane(onDismissed: () {
          //
          // }),

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {
                dialog([
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Are you sure you want to delete this search',
                        style: Theme.of(context).textTheme.subtitle1!,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 4),
                            child: MaterialButton(
                              onPressed: () {
                                Get.back();
                              },
                              splashColor: redDefaultColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: redDefaultColor)),
                              child: const Text('Don\'t Delete',
                                  style: TextStyle(fontSize: 18)),
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4, right: 10),
                            child: MaterialButton(
                              onPressed: () {
                                profileController.deleteSavedSearch(widget.search.id);
                                Get.back();
                              },
                              splashColor: Colors.white.withOpacity(.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: redDefaultColor,
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ))
                    ],
                  )
                ]);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              onPressed: (context)
              {
                dialog([
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'please enter a title!',
                        style: Theme.of(context).textTheme.subtitle1!,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Form(
                        key: formKey,
                        child: defualtTextForm(context,
                            controler: titleController,
                            type: TextInputType.text, validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your title';
                              }
                              return null;
                            }, radius: 3)),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: Text(
                        'you want to be notified when new ads match your search',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontSize: 19),
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 4),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  profileController.updateSavedSearch(widget.search.id.toString(),titleController.text, false);
                                  Get.back();
                                }
                              },
                              splashColor: redDefaultColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(color: redDefaultColor)),
                              child: const Text('I\'am ok',
                                  style: TextStyle(fontSize: 18)),
                            ),
                          )),
                      Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4, right: 10),
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  profileController.updateSavedSearch(widget.search.id.toString(),titleController.text, true);
                                  Get.back();
                                }
                              },
                              splashColor: Colors.white.withOpacity(.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: redDefaultColor,
                              child: const Text(
                                'get notified',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ))
                    ],
                  )
                ]);
              },
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              icon: FlatIcon.edit,
              label: 'Edit',
            ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width * .94,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.search.title,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontSize: 30, height: 0.6),
                ),
                if (widget.search.parameters.keywords != null)
                  Text(
                    widget.search.parameters.keywords.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 17),
                  ),
                if (widget.search.parameters.priceTo != null &&
                    widget.search.parameters.priceFrom != null)
                  Text(
                    'Price Range : ${widget.search.parameters.priceFrom} To ${widget.search.parameters.priceTo}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 17),
                  ),
                if (widget.search.date != null)
                  Text(
                    widget.search.date.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
