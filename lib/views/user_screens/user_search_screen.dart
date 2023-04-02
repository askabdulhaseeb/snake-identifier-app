import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/auth_methods.dart';
import '../../enum/user_role.dart';
import '../../models/app_user.dart';
import '../../providers/user_provider.dart';
import '../../widgets/custom_widgets/custom_profile_image.dart';
import '../../widgets/custom_widgets/custom_shadow_bg_widget.dart';
import '../../widgets/custom_widgets/text_tag_widget.dart';

class UserSearchScreen extends StatelessWidget {
  const UserSearchScreen({super.key});
  static const String routeName = '/user-search';

  @override
  Widget build(BuildContext context) {
    final UserProvider userPro = Provider.of<UserProvider>(context);
    final List<AppUser> users = userPro.filterUser();
    final AppUser me =
        userPro.user(AuthMethods.uid) ?? AppUser(uid: '', email: '');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        title: CupertinoSearchTextField(
          autofocus: true,
          onChanged: (String? value) => userPro.onSearch(value),
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) => _UserTile(
          user: users[index],
          myRole: me.role,
        ),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({required this.user, required this.myRole});
  final AppUser user;
  final UserRole myRole;

  @override
  Widget build(BuildContext context) {
    return CustomShadowBgWidget(
      child: Row(
        children: <Widget>[
          CustomProfileImage(imageURL: user.imageURL),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  user.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (myRole == UserRole.superAdmin)
                  SelectableText(
                    user.email,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.grey),
                  ),
              ],
            ),
          ),
          myRole == UserRole.superAdmin
              ? ElevatedButton(
                  onPressed: () {},
                  child: Text(user.role == UserRole.superAdmin ||
                          user.role == UserRole.user
                      ? 'Make user Admin'
                      : 'Make him User'),
                )
              : TextTagWidget(text: user.role.title)
        ],
      ),
    );
  }
}
