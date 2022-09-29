import 'package:flutter/material.dart';
import 'package:flutter_amazon_clone/constants/utils.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:flutter_amazon_clone/provider/user_provider.dart';

import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _addressFormKey = GlobalKey<FormState>();

  final TextEditingController _flatBuildingController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  String addressToBeUsed = "";
  final List<PaymentItem> _paymentItems = [];

  @override
  void initState() {
    super.initState();
    _paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: "Total",
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    super.dispose();
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
  }

  void onApplePayResult(res) {
    if (Provider.of<UserProvider>(context).user.address.isEmpty) {}
  }

  void onGooglePayResult(res) {}

  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";
    bool isForm = _flatBuildingController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _pincodeController.text.isNotEmpty ||
        _cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${_flatBuildingController.text}, ${_areaController.text}, ${_cityController.text} - ${_pincodeController.text}";
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, "Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "OR",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _flatBuildingController,
                      hintText: "Flat, House no, Building",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _areaController,
                      hintText: "Area, Street",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _pincodeController,
                      hintText: "Pincode",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _cityController,
                      hintText: "Town/City",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ApplePayButton(
                margin: const EdgeInsets.only(top: 15),
                width: double.infinity,
                height: 50,
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                paymentConfigurationAsset: "applepay.json",
                onPaymentResult: onApplePayResult,
                paymentItems: _paymentItems,
                onPressed: () => payPressed(address),
              ),
              const SizedBox(height: 10),
              GooglePayButton(
                margin: const EdgeInsets.only(top: 15),
                width: double.infinity,
                height: 50,
                type: GooglePayButtonType.buy,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                paymentConfigurationAsset: "gpay.json",
                onPaymentResult: onGooglePayResult,
                paymentItems: _paymentItems,
                onPressed: () => payPressed(address),
              )
            ],
          ),
        ),
      ),
    );
  }
}
