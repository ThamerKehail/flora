import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/models/order_history.dart';
import 'package:ward/utils/language_constant.dart';
import 'package:ward/utils/theme.dart';
import 'package:ward/view/widget/order_history_widget/card_history_widget.dart';

import 'order_history_view_model.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => context.read<OrdersHistoryViewModel>().getAllOrders());
  }

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrdersHistoryViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(),
            Text(
              "${translation(context).order} ${translation(context).history}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Spacer(),
          ],
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Orders>>(
              future: orders.orders,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                } else if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Image.asset('assets/images/nproduct.png'),
                  );
                }

                return (snapshot.hasData)
                    ? ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return CardHistoryWidget(
                            orders: snapshot.data![index],
                          );
                        })
                    : SizedBox();
              })),
    );
  }
}
