import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = 'edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _descriptionFocusNode = FocusNode();
  final _originAddressFocusNode = FocusNode();
  final _destinationAddressFocusNode = FocusNode();
  final _weightFocusNode = FocusNode();
  final _heightFocusNode = FocusNode();
  final _longitudeFocusNode = FocusNode();
  // final _imageUrlController = TextEditingController();
  // final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    originAddress: '',
    destinationAddress: '',
    description: '',
    weight: 0,
    height: 0,
    longitude: 0,
  );
  var _initValues = {
    'title': '',
    'description': '',
    'originAddress': '',
    'destinationAddress': '',
    'weight': '',
    'height': '',
    'longitude': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    //_imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'originAddress': _editedProduct.originAddress,
          'destinationAddress': _editedProduct.destinationAddress,
          'weight': _editedProduct.weight.toString(),
          'height': _editedProduct.height.toString(),
          'longitude': _editedProduct.longitude.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
        };
        //_imageUrlController.text = _editedProduct.imageUrl;
      }
      ;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _originAddressFocusNode.dispose();
    _destinationAddressFocusNode.dispose();
    _weightFocusNode.dispose();
    _heightFocusNode.dispose();
    _longitudeFocusNode.dispose();

    super.dispose();
  }

  // void _updateImageUrl() {
  //   if (!_imageUrlFocusNode.hasFocus) {
  //     if (_imageUrlController.text.isEmpty) {
  //       return;
  //     }
  //     if (!_imageUrlController.text.startsWith('http') &&
  //         !_imageUrlController.text.startsWith('https')) {
  //       return;
  //     }
  //     if (!_imageUrlController.text.endsWith('.png') &&
  //         !_imageUrlController.text.endsWith('.jpg') &&
  //         !_imageUrlController.text.endsWith('.jpeg')) {
  //       return;
  //     }
  //     setState(() {});
  //   }
  // }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProducts(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        await showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error ocurred'),
            content: Text('Something went wrong'),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = true;
      //   });
      //   Navigator.of(context).pop();
      // }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    //TITLE TEXTFIELD
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: value,
                          description: _editedProduct.description,
                          originAddress: _editedProduct.originAddress,
                          destinationAddress: _editedProduct.destinationAddress,
                          weight: _editedProduct.weight,
                          height: _editedProduct.height,
                          longitude: _editedProduct.longitude,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    //DESCRIPTION TEXTFIELD
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: _originAddressFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a description';
                        }
                        if (value.length < 10) {
                          return 'Enter a longer description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: value,
                          originAddress: _editedProduct.originAddress,
                          destinationAddress: _editedProduct.destinationAddress,
                          weight: _editedProduct.weight,
                          height: _editedProduct.height,
                          longitude: _editedProduct.longitude,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    //ORIGIN ADDRESS TEXTFIELD
                    TextFormField(
                      initialValue: _initValues['originAddress'],
                      decoration: InputDecoration(
                        labelText: 'Origin Address',
                      ),
                      keyboardType: TextInputType.streetAddress,
                      focusNode: _destinationAddressFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a description';
                        }
                        if (value.length < 10) {
                          return 'Enter a longer description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          originAddress: value,
                          destinationAddress: _editedProduct.destinationAddress,
                          weight: _editedProduct.weight,
                          height: _editedProduct.height,
                          longitude: _editedProduct.longitude,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    //DESTINATION ADDRESS TEXTFIELD
                    TextFormField(
                      initialValue: _initValues['destinationAddress'],
                      decoration: InputDecoration(
                        labelText: 'Destination Address',
                      ),
                      keyboardType: TextInputType.streetAddress,
                      focusNode: _weightFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a description';
                        }
                        if (value.length < 10) {
                          return 'Enter a longer description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          originAddress: _editedProduct.originAddress,
                          destinationAddress: value,
                          weight: _editedProduct.weight,
                          height: _editedProduct.height,
                          longitude: _editedProduct.longitude,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    //WEIGHT TEXTFIELD
                    TextFormField(
                      initialValue: _initValues['weight'],
                      decoration: InputDecoration(
                        labelText: 'Weight',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _heightFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_heightFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than 0';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          originAddress: _editedProduct.originAddress,
                          destinationAddress: _editedProduct.destinationAddress,
                          weight: double.parse(value),
                          height: _editedProduct.height,
                          longitude: _editedProduct.longitude,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    //HEIGHT TEXTFIELD
                    TextFormField(
                      initialValue: _initValues['height'],
                      decoration: InputDecoration(
                        labelText: 'Height',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _longitudeFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_longitudeFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than 0';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          originAddress: _editedProduct.originAddress,
                          destinationAddress: _editedProduct.destinationAddress,
                          weight: _editedProduct.weight,
                          height: double.parse(value),
                          longitude: _editedProduct.longitude,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    //LONGITUDE TEXTFIELD
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than 0';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          originAddress: _editedProduct.originAddress,
                          destinationAddress: _editedProduct.destinationAddress,
                          weight: _editedProduct.weight,
                          height: _editedProduct.height,
                          longitude: double.parse(value),
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
