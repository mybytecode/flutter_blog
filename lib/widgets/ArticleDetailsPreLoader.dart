
import 'package:flutter/cupertino.dart';
import 'package:flutter_blog/widgets/AppTheme.dart';
import 'package:flutter_blog/widgets/Preloaders.dart';
import 'package:provider/provider.dart';

import 'ThemeProvider.dart';

class ArticleDetailsPreLoader extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => ArticleDetailsPreLoaderState();
}
class ArticleDetailsPreLoaderState extends State<ArticleDetailsPreLoader>
{
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return theme.getTheme() == DarkTheme().dark ? DarkCardPageSkeleton(): CardPageSkeleton();
  }

}