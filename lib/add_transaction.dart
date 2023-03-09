import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  final Function addNew;

  const AddTransaction({super.key, required this.addNew});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final amountcontroller = TextEditingController();
  DateTime? selecteddate;
  final titlecontroller = TextEditingController();

  void check() {
    final enteredtitle = titlecontroller.text;
    final enteredamount = double.parse(amountcontroller.text);

    if (enteredtitle.isEmpty || enteredamount <= 0 || selecteddate == null) {
      return;
    }
    widget.addNew(enteredtitle, enteredamount, selecteddate);
    Navigator.of(context).pop();
  }

  void datepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }

      setState(() {
        selecteddate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              left: 10,
              right: 10),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                controller: titlecontroller,
                onSubmitted: (_) => check(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: "amount"),
                controller: amountcontroller,
                onSubmitted: (_) => check(),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: FittedBox(
                          child: Text(
                        selecteddate == null
                            ? "no date choosen"
                            : "Choosen date $selecteddate",
                        style: const TextStyle(fontSize: 15),
                      ))),
                  Expanded(
                    child: TextButton(
                        onPressed: datepicker,
                        child: const Text(
                          "Pick Date",
                          style: TextStyle(fontSize: 15, color: Colors.amber),
                        )),
                  ),
                ],
              ),
              TextButton(
                onPressed: check,
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 238, 107, 7)),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
