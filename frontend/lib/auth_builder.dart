import 'package:flutter/material.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/models/especialist_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/providers/auth/auth_provider.dart';
import 'package:frontend/providers/database/firebase/firestore_general%20_dao.dart';
import 'package:provider/provider.dart';

/*
* This class is mainly to help with creating user dependent object that
* need to be available by all downstream widgets.
* Thus, this widget builder is a must to live above [MaterialApp].
* As we rely on uid to decide which main screen to display (eg: Home or Sign In),
* this class will helps to create all providers needed that depends on
* the user logged data uid.
 */
class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({required Key key, required this.builder})
      : super(key: key);

  final Widget Function(BuildContext, AsyncSnapshot<AuthModel>) builder;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context, listen: false);

    return StreamBuilder<AuthModel>(
      stream: authService.user,
      builder: (BuildContext context, AsyncSnapshot<AuthModel> snapshot) {
        final AuthModel? user = snapshot.data;
        print(user);
        if (user != null) {
          return StreamBuilder<UserModel>(
              stream: FirestoreDao<UserModel>().dataStream(todoId: user.uid),
              builder: (BuildContext userModelContext,
                  AsyncSnapshot<UserModel> userModelSnapshot) {
                final UserModel? userModel = userModelSnapshot.data;

                if (userModel != null) {
                  user.userData = userModel;

                  return MultiProvider(
                    providers: [
                      Provider<AuthModel>.value(value: user),
                    ],
                    child: builder(userModelContext, snapshot),
                  );
                }

                return StreamBuilder<EspecialistModel>(
                    stream: FirestoreDao<EspecialistModel>()
                        .dataStream(todoId: user.uid),
                    builder: (BuildContext especialistContext,
                        AsyncSnapshot<EspecialistModel> especialistSnapshot) {
                      final EspecialistModel? especialistModel =
                          especialistSnapshot.data;

                      if (especialistModel != null) {
                        user.userData = especialistModel;

                        return MultiProvider(providers: [
                          Provider<AuthModel>.value(value: user),
                        ], child: builder(especialistContext, snapshot));
                      }

                      return builder(especialistContext, snapshot);
                    });
              });
        }
        return builder(context, snapshot);
      },
    );
  }
}
