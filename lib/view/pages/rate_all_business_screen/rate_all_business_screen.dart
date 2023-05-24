import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ward/models/all_business_rate.dart';
import 'package:ward/view/pages/rate_all_business_screen/rate_all_business_view_model.dart';

import '../../../utils/language_constant.dart';
import '../../../utils/theme.dart';
import '../../widget/all_business_rate/card_business.dart';

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
        title: Text(
          translation(context).rateBusiness,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 4,
                    offset: Offset(4, 8), // Shadow position
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
                color: mainColor,
              ),
              child: Center(
                child: Text(
                  translation(context).ratting,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<List<AllBusinessRate>>(
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
                      ? Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                return CardBusinessWidget(
                                    allBusinessRate: snapshot.data![index]);
                              }),
                        )
                      : const SizedBox();
                }),
          ],
        ),
      ),
    );
  }
}
