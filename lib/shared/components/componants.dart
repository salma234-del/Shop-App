import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        _launchUrl(Uri.parse('${article['url']}'));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: SizedBox(
                height: 120,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xffADC5CF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget divider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 1,
        color: defaultColor,
      ),
    );

Widget articleBuilder(articles, context, {search = false}) =>
    ConditionalBuilder(
      condition: articles.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            buildArticleItem(articles[index], context),
        separatorBuilder: (context, index) => divider(),
        itemCount: articles.length,
      ),
      fallback: (context) => search
          ? Container()
          : const Center(child: CircularProgressIndicator()),
    );

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(text.toUpperCase()),
    );

Widget defaultButton({
  double width = double.infinity,
  double height = 40,
  Color bgColor = Colors.blue,
  double radius = 0,
  bool upper = true,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          upper ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextField(
        {required TextEditingController controller,
        required TextInputType type,
        required String? Function(String?) validate,
        Function? onSubmit,
        Function? onChange,
        bool password = false,
        required String label,
        required IconData preIcon,
        IconData? suffIcon,
        Function? suffPressed,
        double radius = 0,
        Color borderCol = Colors.black}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      onChanged: (value) {
        onChange!(value);
      },
      obscureText: password,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        labelText: label,
        prefixIcon: Icon(preIcon),
        suffixIcon: IconButton(
          icon: Icon(suffIcon),
          onPressed: () {
            suffPressed!();
          },
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: borderCol),
        ),
      ),
    );

void navigateTo(context, widget) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ));
}

void navigateToAndReplace(context, widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (route) => false);
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

void showToast({
  required String text,
  required ToastStates state,
}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color col;
  switch (state) {
    case ToastStates.SUCCESS:
      col = Colors.green;
      break;
    case ToastStates.ERROR:
      col = Colors.red;
      break;
    case ToastStates.WARNING:
      col = Colors.amber;
      break;
  }
  return col;
}
