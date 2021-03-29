import 'package:NoHunger/screens/addLocationDetail.dart';
import 'package:flutter/material.dart';

class AddFoodDetails extends StatefulWidget {
  @override
  _AddFoodDetailsState createState() => _AddFoodDetailsState();
}

class _AddFoodDetailsState extends State<AddFoodDetails> {
  var _foodType;
  var _formKey = GlobalKey<FormState>();
  TextEditingController time = TextEditingController();
  var _foodItemEntries = [];
  var _foodItemMap = {};
  var havePackets = 'No';
  var foodTypeMap = {
    'Cooked Food': {
      'validateStr': 'Amount cannot be empty',
      'hintText': 'Enter approximate amount of people can eat'
    },
    'Raw Food': {
      'validateStr': 'Weight cannot be empty',
      'hintText': 'Enter approximate weight of item in Kg'
    }
  };
  var rFoodMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Food details"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropdownButton(
                      isExpanded: true,
                      value: _foodType,
                      items: ['Cooked Food', 'Raw Food']
                          .map((value) => DropdownMenuItem(
                                child: Text(value),
                                value: value,
                              ))
                          .toList(),
                      hint: Text('Select Food type'),
                      onChanged: (value) {
                        setState(() {
                          _foodType = value;
                          _foodItemEntries = [];
                          _foodItemMap = {};
                          _foodItemEntries.addAll(foodItemWidget(1, _foodType));
                          _foodItemMap.putIfAbsent(
                              1, () => {'name': '', 'amount': 0});
                        });
                      }),
                  if (_foodType != null) ...[
                    for (Widget widget in _buildUI()) widget
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildUI() {
    return [
      if (_foodType == 'Cooked Food')
        TextFormField(
          readOnly: true,
          showCursor: true,
          controller: time,
          validator: (value) {
            if (value.isEmpty) {
              return "Cooking time cannot be empty";
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            hintText: 'Time of cooking',
          ),
          onTap: () async {
            var selectedTime = await showTimePicker(
                context: context, initialTime: TimeOfDay.now());
            setState(() {
              time.text = _formatTime(selectedTime);
            });
          },
        ),
      for (Widget item in _foodItemEntries) item,
      TextButton(
          onPressed: () {
            setState(() {
              _foodItemMap.putIfAbsent(_foodItemEntries.length ~/ 3 + 1,
                  () => {'name': '', 'amount': 0});
              _foodItemEntries.addAll(
                  foodItemWidget(_foodItemEntries.length ~/ 3 + 1, _foodType));
            });
          },
          child: Text(
            'Add more food item detail +',
            style: TextStyle(color: Colors.grey),
          )),
      Row(
        children: [
          Expanded(child: Text('Do you have packets to pack?')),
          Text('Yes'),
          Radio(
              value: 'Yes',
              groupValue: havePackets,
              onChanged: (value) {
                setState(() {
                  havePackets = value;
                });
              }),
          Text('No'),
          Radio(
              value: 'No',
              groupValue: havePackets,
              onChanged: (value) {
                setState(() {
                  havePackets = value;
                });
              }),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddLocationDetail()));
              }
            },
            child: Text('Next')),
      ),
    ];
  }

  List<Widget> foodItemWidget(int index, String foodType) {
    return [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('Item $index'),
      ),
      TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "Item name cannot be empty";
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          hintText: 'Food item name',
        ),
        onChanged: (value) {
          _foodItemMap[index]['name'] = value;
        },
      ),
      TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return foodTypeMap[foodType]['validateStr'];
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: foodTypeMap[foodType]['hintText'],
        ),
        onChanged: (value) {
          _foodItemMap[index]['amount'] = value;
        },
      ),
    ];
  }

  ///Function to format TimeOfDay to hh:mm AM/PM string format
  String _formatTime(TimeOfDay time) {
    var hour = time.hour == 12 ? time.hour : time.hour - time.periodOffset;
    return "${time.replacing(hour: hour).hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")} ${time.hour < 12 ? "AM" : "PM"}";
  }
}
