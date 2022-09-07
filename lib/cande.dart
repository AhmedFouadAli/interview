import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewquestion/cubit/statecande_cubit.dart';
import 'package:interviewquestion/data.dart';

class Candy extends StatefulWidget {
  const Candy({Key? key}) : super(key: key);

  @override
  State<Candy> createState() => _CandyState();
}

class _CandyState extends State<Candy> {
  @override
  Widget build(BuildContext context) {
    var userName = StoreData.singlePerson[0]["userName"];
    return Scaffold(
        appBar: AppBar(
          title: Text("Candy ${userName}"),
        ),
        body: BlocBuilder<StatecandeCubit, StatecandeState>(
          builder: (context, state) {
            return Column(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                        initialDate: DateTime.now());

                    // setState(()=>{StoreData.addAvalibility(picked.toString())});
                    StatecandeCubit.getInstance(context)
                        .addAvalibility(picked.toString());
                  },
                  child: Text('Add time picker'),
                ),
                Container(
                  height: 200,
                  child: StoreData.pickerTime[userName] == null
                      ? Text("No data")
                      : ListView.builder(
                          itemCount: StoreData.pickerTime[userName].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Text(
                                    StoreData.pickerTime[userName][index]
                                        ["time"],
                                    style: StoreData.pickerTime[userName][index]
                                            ["reserved"]
                                        ? TextStyle(
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          )
                                        : TextStyle(
                                            color: Colors.blue,
                                          )),
                                Spacer(),
                                TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                  ),
                                  onPressed: () {
                                    StoreData.pickerTime[userName][index]
                                        ["reserved"] = true;
                                    StatecandeCubit.getInstance(context)
                                        .reserved();
                                  },
                                  child: Text('Reserved'),
                                ),
                              ],
                            );
                          }),
                )
              ],
            );
          },
        ));
  }
}
