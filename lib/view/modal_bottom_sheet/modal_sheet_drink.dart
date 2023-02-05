import 'package:drink_app/option1/test/test_drinks/providers/test_drinks_upload_provider.dart';
import 'package:drink_app/option1/typedefs/user_id.dart';
import 'package:drink_app/view/modal_bottom_sheet/provider/modal_change_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

@immutable
class ModalSheetDrinkDialog<T> {
  const ModalSheetDrinkDialog();
}

extension Present<T> on ModalSheetDrinkDialog<T> {
  Future<T?> present(
    BuildContext context,
    String drinkType,
    UserId userId,
  ) async {
    final _formKey = GlobalKey<FormBuilderState>();

    List<String> tonnageOptions = ['cl', 'dl', 'l'];

    var data = {
      'name': '',
      'tonnage': 'cl',
      'currency': 'Ft',
      'type': drinkType,
      'data': {},
    };

    final _size = MediaQuery.of(context).size;

    return await showMaterialModalBottomSheet(
      expand: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 32, 14, 50),
      context: context,
      builder: (context) {
        return HookConsumer(
          builder: (context, ref, ch) {
            final nameController = useTextEditingController();
            final tonnageController = useTextEditingController();
            final priceController = useTextEditingController();

            final tonnageValue = ref.watch(modalChangeProvider).tonnage;

            final tonnageList = ref.watch(modalChangeProvider).exactTonnage;
            final priceList = ref.watch(modalChangeProvider).exactPrice;

            useEffect(
              () {
                data['name'] = nameController.text;

                return () {};
              },
              [
                nameController,
              ],
            );

            return Consumer(
              builder: (ctx, ref, ch) => SingleChildScrollView(
                controller: ModalScrollController.of(context),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'name',
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.center,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (val) {
                            if (val == null || val == "") {
                              return 'Add meg az ital nevét';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                            labelText: 'Ital neve',
                          ),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 237, 50, 55),
                          ),
                          onSaved: (_) {
                            data['name'] = nameController.text;
                          },
                        ),
                        SizedBox(
                          height: _size.height * 0.03,
                        ),
                        FormBuilderDropdown<String>(
                          name: 'tonnage',
                          initialValue: 'cl',
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                            labelText: 'Mérték',
                            suffix: IconButton(
                              iconSize: 20.0,
                              color: Colors.white,
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                _formKey.currentState!.fields['tonnage']
                                    ?.reset();
                              },
                            ),
                          ),
                          alignment: Alignment.center,
                          items: tonnageOptions
                              .map(
                                (e) => DropdownMenuItem(
                                  alignment: Alignment.center,
                                  value: e,
                                  child: Text(
                                    e,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 237, 50, 55),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            ref
                                .read(modalChangeProvider.notifier)
                                .setTonnage(val!);
                          },
                          onSaved: (val) {
                            data['tonnage'] = val ?? '';
                          },
                        ),
                        SizedBox(
                          height: _size.height * 0.03,
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: _size.width * 0.25,
                                    child: FormBuilderTextField(
                                      name: 'tonnage0',
                                      controller: tonnageController,
                                      textAlign: TextAlign.center,
                                      validator: (_) {
                                        final tonnage = ref
                                            .watch(modalChangeProvider)
                                            .exactTonnage;
                                        if (tonnage.isEmpty) {
                                          return 'Adj meg legalább 1 mérték-ár adatot';
                                        }

                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Mérték',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 237, 50, 55),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Container(
                                    width: _size.width * 0.04,
                                    child: Text(
                                      tonnageValue,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _size.width * 0.2,
                                  ),
                                  Container(
                                    width: _size.width * 0.25,
                                    child: FormBuilderTextField(
                                      name: 'price0',
                                      controller: priceController,
                                      textAlign: TextAlign.center,
                                      validator: (_) {
                                        final price = ref
                                            .watch(modalChangeProvider)
                                            .exactPrice;
                                        if (price.isEmpty) {
                                          return 'Adj meg legalább 1 mérték-ár adatot';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        labelText: 'Ár',
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 237, 50, 55),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  Container(
                                    width: _size.width * 0.04,
                                    child: Text(
                                      '${data['currency']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          color: Colors.white,
                          onPressed: () {
                            if (tonnageController.text.isEmpty ||
                                tonnageController.text == '' ||
                                priceController.text.isEmpty ||
                                priceController.text == '') {
                              return;
                            }

                            final tonnage =
                                ref.watch(modalChangeProvider).tonnage;
                            ref
                                .read(modalChangeProvider.notifier)
                                .addExactTonnage(
                                  tonnageController.text.trim() + ' ' + tonnage,
                                );

                            ref
                                .read(modalChangeProvider.notifier)
                                .addExactPrice(
                                  '${priceController.text.trim()} ${data['currency']}',
                                );

                            _formKey.currentState?.fields['tonnage0']
                                ?.validate();
                            _formKey.currentState?.fields['price0']?.validate();

                            tonnageController.text = '';
                            priceController.text = '';

                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          icon: const Icon(
                            Icons.add,
                          ),
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          height: _size.height * 0.1,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: tonnageList.length,
                            itemBuilder: (ctx, i) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                color: const Color.fromARGB(255, 237, 50, 55),
                                elevation: 8,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        tonnageList[i],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: _size.width * 0.02,
                                      ),
                                      Text(
                                        priceList[i],
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: _size.width * 0.06),
                                      IconButton(
                                        onPressed: () {
                                          ref
                                              .read(
                                                  modalChangeProvider.notifier)
                                              .delete(i);
                                        },
                                        icon: const Icon(
                                          Icons.delete_outlined,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: _size.height * 0.04,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 237, 50, 55),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 237, 50, 55),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            final isValid = _formKey.currentState?.validate();

                            if (isValid!) {
                              _formKey.currentState?.save();

                              final exactTonnageList =
                                  ref.watch(modalChangeProvider).exactTonnage;

                              final exactPriceList =
                                  ref.watch(modalChangeProvider).exactPrice;

                              Map<String, String> priceEachTonnage = new Map();

                              for (var i = 0; i < exactPriceList.length; i++) {
                                priceEachTonnage[exactTonnageList[i]] =
                                    exactPriceList[i];
                              }

                              data['data'] = priceEachTonnage;

                              ref
                                  .read(drinksTestUploadProvider.notifier)
                                  .upload(
                                    userId: userId,
                                    drinkName: data['name'].toString(),
                                    drinkTonnage: data['tonnage'].toString(),
                                    drinkCurrency: data['currency'].toString(),
                                    drinkType: drinkType,
                                    drinkPriceList: priceEachTonnage,
                                  );

                              ref
                                  .read(modalChangeProvider.notifier)
                                  .clearList();

                              Navigator.of(context).pop();
                            } else {
                              //TODO: alertDialog, snackbar sg went wrong fill all the gaps
                            }
                          },
                          child: const Text('Feltöltés a bárba'),
                        ),
                        SizedBox(
                          height: _size.height * 0.08,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
