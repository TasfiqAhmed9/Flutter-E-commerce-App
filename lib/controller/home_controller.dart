// import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecp_admin/model/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;

  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImgCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();

  String category = 'General';
  String brand = 'Non brand';
  bool offer = false;

  List<Product> products = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    await fetchProducts();
    // TODO: implement onInit
    super.onInit();
  }

  addProduct() {
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
          id: doc.id,
          name: productNameCtrl.text,
          category: category,
          description: productDescriptionCtrl.text,
          price: double.tryParse(productPriceCtrl.text),
          brand: brand,
          image: productImgCtrl.text,
          offer: offer);
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Success', 'Product added Successfully',
          colorText: Colors.green);
      setValueDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.green);
      print(e);
    }
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      Get.snackbar('Success', 'Product fetch successfully',
          colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  deleteProduct(String id) async {
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }

  setValueDefault() {
    productNameCtrl.clear();
    productDescriptionCtrl.clear();
    productImgCtrl.clear();
    productPriceCtrl.clear();

    category = 'Generral';
    brand = 'Non brand';
    offer = false;
    update();
  }
}
