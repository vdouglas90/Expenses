import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double,DateTime) onSubmit;
  const TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _tittleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectDate = DateTime.now();

  _submitForm(){
    final tittle = _tittleController.text;
    final value = double.tryParse(_valueController.text) ?? 0;

    if(tittle.isEmpty || value <= 0 || _selectDate == null){
      return;
    }
    widget.onSubmit(tittle,value,_selectDate!);
  }

  _showDataPicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now()
    ).then((pickedDate){
      if(pickedDate == null){
        return;
      }
      setState((){
        _selectDate = pickedDate;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _tittleController,
              onSubmitted: (_)=> _submitForm(),
              decoration: InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
            ),
            SizedBox(height: 70,
            child:Row(
              children: [
                Expanded(
                  child: Text(
                    _selectDate == null
                        ? 'Nenhuma data selecionada'
                        : 'Data Selecionada: ${DateFormat('dd/MMy').format(_selectDate!)}',
                  ),
                ),
                TextButton(onPressed: _showDataPicker, child: Text('Selecionar Data',style: TextStyle(fontWeight: FontWeight.bold),))
              ],
            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(onPressed: _submitForm, child: Text('Nova Transação',style: TextStyle(color: Theme.of(context).textTheme.button?.color),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
