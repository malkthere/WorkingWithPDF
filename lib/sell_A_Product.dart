import 'package:filemanagment/PdfPreviewPage.dart';
import 'package:flutter/material.dart';
class Sellproducts extends StatefulWidget {
  const Sellproducts({super.key});

  @override
  State<Sellproducts> createState() => SellproductsState();
}
class Product {
  final String costname;
  final String proname;
  final String quantaty;
  final String price;
  final int total;

  Product(this.costname, this.proname, this.quantaty, this.price, this.total);


}
class SellproductsState extends  State<Sellproducts> {
 // SellproductsState({Key? key}) ;
 // SellproductsState({Key? key});//, required this.item}) : super(key: key);

  var _formKey = GlobalKey<FormState>();
  var isLoading = false;
  var bill;

  void _submit() {
    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }else{
      print("information is Validated");
    }
    _formKey.currentState?.save();
  }
TextEditingController costname=new TextEditingController();
TextEditingController productname=new TextEditingController();
TextEditingController quantaty=new TextEditingController();
TextEditingController price=new TextEditingController();
  List<Product> items = <Product>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Sell a product"),
                      ),
    body:  Padding(
          padding: const EdgeInsets.all(16.0),
          //form
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "إضافة منتجات للفاتورة ",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  "إضافة منتجات للفاتورة ",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                //styling
                TextFormField(
                  controller: costname,
                  decoration: InputDecoration(labelText: 'اسم العميل'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {

                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: productname,
                  decoration: InputDecoration(labelText: 'اسم المنتج'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    //Validator
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: quantaty,
                  decoration: InputDecoration(labelText: 'الكمية'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    //Validator
                  },
                  validator: (value) {
                    if (value!.isEmpty)
                            {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                ),
                //box styling
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                //text input
                TextFormField(
                  controller: price,
                  decoration: InputDecoration(labelText: 'سعر الوحدة'),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {},
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a valid password!';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                FittedBox(
                  child: Row(
                    children: [
                      ElevatedButton(

                        child: Text(
                          "اضافة لفاتورة",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        onPressed: () {
                         // _submit();
                          items.add(
                              Product(
                                  costname.text,
                                  productname.text,
                                  quantaty.text,
                                  price.text,
                                  int.parse(quantaty.text)*int.parse(price.text)//int.parse(price)*int.parse(quantaty)
                              )
                          );
                          for(var i in items){
                            print(i.proname.toString());

                          }
                          //costname.text="";
                          productname.text="";
                          quantaty.text="";
                          price.text="";

                        }
                      ),
                      ElevatedButton(

                          child: Text(
                            "الغاء لفاتورة",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          onPressed: () {
                            // _submit();
                            items.clear();
                          }
                      ),
                      ElevatedButton(

                        child: Text(
                          "طباعة الفاتورة",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        onPressed: () {
                          int total2=0;
                          for(var it in items){
                            total2=total2+it.total;
                          }
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return  PdfPreviewPage(items,total2);
                          }));

                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )


    );
  }
}
