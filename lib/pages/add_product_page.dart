// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecp_admin/controller/home_controller.dart';
import 'package:ecp_admin/widgets/drop_down_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Add Product',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add Product',
                  style: TextStyle(fontSize: 30, color: Colors.blue),
                ),
                TextField(
                  controller: ctrl.productNameCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Product Name'),
                      hintText: 'Enter Your Product Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productDescriptionCtrl,
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Product Description'),
                      hintText: 'Enter Your Product Name'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productImgCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Image Url'),
                      hintText: 'Enter'),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productPriceCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: Text('Product Price'),
                      hintText: 'Enter Your Product Price'),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                        child: DropDownBtn(
                      items: ['goods', 'wear', 'need', 'healthcare', 'abcde'],
                      selectedItemText: ctrl.category,
                      onSelected: (selectedValue) {
                        ctrl.category = selectedValue ?? 'general';
                        ctrl.update();
                      },
                    )),
                    Flexible(
                        child: DropDownBtn(
                      items: ['Shopno', 'AponBazar', 'brand3'],
                      selectedItemText: ctrl.brand,
                      onSelected: (selectedValue) {
                        ctrl.brand = selectedValue ?? 'un brand';
                        ctrl.update();
                      },
                    )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Offer Product ?'),
                SizedBox(
                  height: 10,
                ),
                DropDownBtn(
                  items: ['true', 'false'],
                  selectedItemText: ctrl.offer.toString(),
                  onSelected: (selectedValue) {
                    ctrl.offer =
                        bool.tryParse(selectedValue ?? 'false') ?? false;
                    ctrl.update();
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      ctrl.addProduct();
                    },
                    child: Text('Add Product'))
              ],
            ),
          ),
        ),
      );
    });
  }
}
