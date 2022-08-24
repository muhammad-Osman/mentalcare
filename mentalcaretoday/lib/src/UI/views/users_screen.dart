import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalcaretoday/src/UI/widgets/buttons.dart';
import 'package:mentalcaretoday/src/UI/widgets/input_field.dart';
import 'package:mentalcaretoday/src/UI/widgets/text.dart';
import 'package:mentalcaretoday/src/UI/widgets/users_list_tile.dart';
import 'package:mentalcaretoday/src/utils/constants.dart';
import 'package:mentalcaretoday/src/utils/helper_method.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/user.dart';
import '../../services/auth_services.dart';
import 'chat_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<User>? userList;
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

  final AuthService _authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchUser();
  }

  bool isLoading = false;
  void fetchUser() async {
    setState(() {
      isLoading = true;
    });
    userList = await _authService.getAllUser(context);
    setState(() {
      isLoading = false;
    });
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
                        left: Helper.dynamicWidth(context, 40),
                        child: const AppBarTextHeadLine(
                          text: "Users",
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
                            onChanged: ((p0) {}),
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
                isLoading
                    ? UserShimmerEffect(userList: userList)
                    : userList!.isEmpty
                        ? const Center(child: Text("No User Found"))
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: userList!.length,
                            itemBuilder: (context, index) {
                              return UsersListTile(
                                name: userList![index].firstName,
                                city: userList![index].city,
                                imageUrl: userList![index].image!,
                                index: 1,
                                buttonHeight: 5,
                                buttonWidth: 5,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                        recieverUserId:
                                            userList![index].id.toString(),
                                      ),
                                    ),
                                  );
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

class UserShimmerEffect extends StatelessWidget {
  const UserShimmerEffect({
    Key? key,
    required this.userList,
  }) : super(key: key);

  final List<User>? userList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: Helper.dynamicHeight(context, 1),
            horizontal: Helper.dynamicWidth(context, 2),
          ),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  color: Colors.black87.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(2, 2),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                Helper.dynamicFont(context, 1),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: Helper.dynamicHeight(context, 2),
                  horizontal: Helper.dynamicWidth(context, 4),
                ),
                decoration: BoxDecoration(
                  color: R.color.userTileColor,
                  borderRadius: BorderRadius.circular(
                    Helper.dynamicFont(context, 1),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade300,
                      child: Container(
                        width: Helper.dynamicWidth(context, 10),
                        height: Helper.dynamicHeight(context, 10),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle),
                      ),
                    ),
                    SizedBox(
                      width: Helper.dynamicWidth(context, 5),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade300,
                          child: Container(
                            width: Helper.dynamicWidth(context, 20),
                            height: Helper.dynamicHeight(context, 1),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, .5),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade300,
                          child: Container(
                            width: Helper.dynamicWidth(context, 20),
                            height: Helper.dynamicHeight(context, 1),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Helper.dynamicHeight(context, .5),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            right: Helper.dynamicWidth(context, 5),
                          ),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.grey.shade300,
                            child: Container(
                              width: Helper.dynamicWidth(context, 55),
                              height: Helper.dynamicHeight(context, 3),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade400,
                      highlightColor: Colors.grey.shade300,
                      child: Container(
                        width: Helper.dynamicWidth(context, 10),
                        height: Helper.dynamicHeight(context, 2),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
