import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_project/shared/colors/colors.dart';


Widget logo() => Image(
  image: AssetImage('assets/images/fast-food.png'),
  fit: BoxFit.cover,
  height: 150,
  width: 150,
);

Widget defaultButton({
  Color background = defaultColor,
  double radius = 25.0,
  double width = double.infinity,
  @required Function function,
  @required String text,
  bool toUpper = true,
}) => Container(
  width: width,
  height: 40.0,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  child: FlatButton(
    onPressed: function,
    child: Text(
      toUpper ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);


void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
        (Route<dynamic> route) => false);

Widget defaultTextBox({
  String title,
  String hint = ' ',
  bool isPassword = false,
  @required TextEditingController controller,
  @required TextInputType type,
}) => Container(
  padding: EdgeInsetsDirectional.only(
    start: 15,
    end: 10,
    top: 10,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.0),
    color: Colors.white,
  ),
  width: double.infinity,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != null) detailsText(title),
      TextFormField(
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
        controller: controller,
        keyboardType: type,
      ),
    ],
  ),
);

Widget headText(String text) => Text(
  text,
  style: TextStyle(
    fontSize: 25,
  ),
);

Widget captionText(String text) => Text(
  text,
  style: TextStyle(
    fontSize: 16,
  ),
);

Widget detailsText(String text) => Text(
  text,
  style: TextStyle(
    fontSize: 14,
  ),
);

void showToast({@required text, @required error}) => Fluttertoast.showToast(
    msg: text.toString(),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: error ? Colors.red : Colors.green,
    textColor: Colors.white,
    fontSize: 16.0);


void buildProgress({context, text, bool error = false}) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            if (!error) CircularProgressIndicator(),
            if (!error)
              SizedBox(
                width: 20,
              ),
            Expanded(child: Text(text)),
          ],
        ),
        if (error) SizedBox(height: 20),
        if (error)
          defaultButton(
            function: () {
              Navigator.pop(context);
            },
            text: "Cancel",
          ),
      ],
    ),
  ),
);