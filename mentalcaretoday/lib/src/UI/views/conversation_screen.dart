import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/coversation_list_tile.dart';
import 'package:mentalcaretoday/src/UI/widgets/input_field.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/routes/index.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({Key? key}) : super(key: key);

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _searchController = TextEditingController();

  FocusNode searchNode = FocusNode();

  unfocusTextFields() {
    if (searchNode.hasFocus) {
      searchNode.unfocus();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    searchNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: Helper.dynamicHeight(context, 100),
        width: Helper.dynamicWidth(context, 100),
        child: InkWell(
          onTap: () => unfocusTextFields(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: Helper.dynamicHeight(context, 23),
                  width: Helper.dynamicWidth(context, 100),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: Helper.dynamicHeight(context, 5),
                        top: 0,
                        child: SvgPicture.asset(
                          R.image.curveImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: Helper.dynamicHeight(context, 5),
                        left: Helper.dynamicWidth(context, 3),
                        child: BackArrowButton(
                          ontap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Positioned(
                        top: Helper.dynamicHeight(context, 6),
                        left: Helper.dynamicWidth(context, 35),
                        child: const AppBarTextHeadLine(
                          text: "Messages",
                          fontSize: 2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        top: Helper.dynamicHeight(context, 15),
                        left: Helper.dynamicWidth(context, 6.5),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 3,
                                offset: const Offset(
                                    1, 2), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                                Helper.dynamicFont(context, 2)),
                          ),
                          height: Helper.dynamicHeight(context, 7),
                          width: Helper.dynamicWidth(context, 88),
                          child: TextFieldWithIcon(
                            controller: _searchController,
                            node: searchNode,
                            placeHolder: "Search",
                            isSuffixIcon: true,
                            fillColor: Colors.white,
                            imagePath: R.image.search,
                            imageHeight: 18,
                            imageWidth: 18,
                            borderRadius: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return ConversationListTile(
                      index: 1,
                      buttonHeight: 5,
                      buttonWidth: 5,
                      onPressed: () {
                        unfocusTextFields();
                        Navigator.of(context).pushNamed(chatScreen);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
