import 'package:flutter/material.dart';
import 'package:palmail_project/provider/search_provider.dart';
import 'package:palmail_project/provider/single_mail_provider.dart';
import 'package:palmail_project/provider/statuses_provider.dart';
import 'package:palmail_project/services/mange_language.dart';

import 'package:provider/provider.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'provider/all_role.dart';
import 'provider/all_users_provider.dart';
import 'provider/categories_provider.dart';
import 'provider/category_Provider.dart';
import 'provider/image_upload.dart';
import 'provider/mail_provider.dart';
import 'provider/mail_tags.dart';
import 'provider/sender_mails_provider.dart';
import 'provider/sender_provider.dart';
import 'provider/statues_Provider.dart';
import 'provider/tag_provider.dart';
import 'provider/tags_provider.dart';
import 'provider/user_provider.dart';
import 'views/ArchiveMail/archive_mail_view.dart';
import 'views/auth/auth.dart';
import 'views/details_feature/details_screen.dart';
import 'views/home/change_password.dart';
import 'views/home/home_screen.dart';
import 'views/home/manage_user.dart';
import 'views/home/profile_screen.dart';
import 'views/home/sender_mails/all_sender.dart';
import 'views/home/sender_mails/sender_mails.dart';
import 'views/search/search_screen.dart';
import 'views/splah/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
      path: ASSET_PATH_LOCALISATIONS,
      child: Phoenix(child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StatusesProvider>(
          create: (context) => StatusesProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider<SingleMailProvider>(
          create: (context) => SingleMailProvider(),
        ),
        ChangeNotifierProvider<TagsProvider>(
          create: (_) => TagsProvider(),
        ),
        ChangeNotifierProvider<ImageUploadProvider>(
          create: (context) => ImageUploadProvider(),
        ),
        ChangeNotifierProvider<StatusesProvider>(
          create: (context) => StatusesProvider(),
        ),
        ChangeNotifierProvider<TagProvider>(
          create: (context) => TagProvider(),
        ),
        ChangeNotifierProvider<CategoriesProvider>(
          create: (context) => CategoriesProvider(),
        ),
        ChangeNotifierProvider<MailsProvider>(
          create: (context) => MailsProvider(),
        ),
        ChangeNotifierProvider<MailTagsProvider>(
          create: (context) => MailTagsProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<AllUserProvider>(
          create: (context) => AllUserProvider(),
        ),
        ChangeNotifierProvider<CategoreyProvider>(
          create: (context) => CategoreyProvider(),
        ),
        ChangeNotifierProvider<TagProvider>(
          create: (context) => TagProvider(),
        ),
        ChangeNotifierProvider<StatueProvider>(
          create: (context) => StatueProvider(),
        ),
        ChangeNotifierProvider<SendersProvider>(
          create: (context) => SendersProvider(),
        ),
        ChangeNotifierProvider<RoleProvider>(
          create: (context) => RoleProvider(),
        ),
        ChangeNotifierProvider<SenderMailsProvider>(
          create: (context) => SenderMailsProvider(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          AuthScreen.id: (context) => const AuthScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          DetailsScreen.id: (context) =>const  DetailsScreen(),
          SearchScreen.id: (context) => const SearchScreen(),
          ProfileScreen.id: (context) => const ProfileScreen(),
          ArchivedMailScreen.id: (context) => const ArchivedMailScreen(),
          sendersView.id: (context) => const sendersView(),
          senderMailsScreen.id: (context) => senderMailsScreen(),
          ManageSceen.id: (context) => const ManageSceen(),
          ChanagePassword.id: (context) => const ChanagePassword(),
          // TestPage.id: (context) => const TestPage(),
        },
      ),
    );
  }
}
