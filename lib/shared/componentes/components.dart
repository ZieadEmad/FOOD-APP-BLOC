import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
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

Widget buildCategoryItem(imagePath, title, context, function) => GestureDetector(
      onTap: function,
      child: Container(
        height: 150.0,
        width: 300.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.white,
              child: Image.asset('$imagePath'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );

Widget buildPopularItem(category, imageUrl, title, price, function) => GestureDetector(
      onTap: function,
      child: Container(
        height: 300.0,
        width: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6, top: 3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    category,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 80.0,
                backgroundColor: Colors.white,
                child: Center(
                    child: Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: Image.network('$imageUrl'))),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Expanded(
                child: Text(
                  price,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget buildCard(imageUrl, title, price, function ,dec,buttonFunction) {
  return GestureDetector(
    onTap: function,
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Image.network('$imageUrl'),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 1,
                child: Container(
                  color: Colors.grey[350],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              buildCardExt(title, price,dec,buttonFunction),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildCardExt(title, price,dec,buttonFunction) => ExpansionTileCard(
      baseColor: Colors.white,
      expandedColor: Colors.white,
      elevation: 0.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$title",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              height: 1,
              color: Colors.grey.shade900,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            '$price',
            style: TextStyle(
              fontSize: 16,
              height: 1,
              color: Colors.grey.shade900,
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
      onExpansionChanged: (value) {},
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '$dec',
            textAlign: TextAlign.center,
          ),

        ),
        SizedBox(height: 5,),
        Center(
         child: defaultButton(function: buttonFunction, text: 'Add To Cart',width: 160),
       ),
        SizedBox(height: 5,),

      ],
    );


Widget buildMealItems({imageUrl,title,price,dec,buttonFunction}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20.0,),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0,),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0,),
      child: ExpansionTileCard(
        baseColor: Colors.white,
        expandedColor: Colors.white,
        elevation: 0.0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:defaultColor,
                image: DecorationImage(
                    image: NetworkImage('$imageUrl'),
                    fit: BoxFit.cover,
                ),
              ),
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$title',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '$price L.E',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        onExpansionChanged: (value) {},
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$dec',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18
              ),
            ),
          ),
          SizedBox(height: 8,),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Image.network('$imageUrl'),
         ),
          SizedBox(height: 20,),
          defaultButton(function: buttonFunction, text: 'Add To Cart',width: 160),
        ],
      ),
    ),
  );
}