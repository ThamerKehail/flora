import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/models/all_business_rate.dart';
import 'package:ward/view/pages/rate_all_business_screen/rate_all_business_view_model.dart';

import '../../../utils/language_constant.dart';
import '../../../utils/theme.dart';
import '../../widget/all_business_rate/card_business.dart';
import '../../widget/order_history_widget/card_history_widget.dart';

class RateAllBusiness extends StatefulWidget {
  const RateAllBusiness({Key? key}) : super(key: key);

  @override
  State<RateAllBusiness> createState() => _RateAllBusinessState();
}

class _RateAllBusinessState extends State<RateAllBusiness> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => context.read<RateAllBusinessViewModel>().getAllOrders());
  }

  @override
  Widget build(BuildContext context) {
    final business = context.watch<RateAllBusinessViewModel>();
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
            const Spacer(),
            Text(
              translation(context).rateBusiness,
              style: const TextStyle(
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
        padding: EdgeInsets.all(8),
        child: FutureBuilder<List<AllBusinessRate>>(
            future: business.business,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                print(snapshot.error);
              } else if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No Data Available"),
                );
              }
              return (snapshot.hasData)
                  ? ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return CardBusinessWidget(
                            allBusinessRate: snapshot.data![index]);
                      })
                  : const SizedBox();
            }),
      ),
    );
  }
}
