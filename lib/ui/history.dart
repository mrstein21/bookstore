import 'package:bookstore/bloc/transaction_list_bloc/transaction_list_bloc.dart';
import 'package:bookstore/bloc/transaction_list_bloc/transaction_list_event.dart';
import 'package:bookstore/bloc/transaction_list_bloc/transaction_list_state.dart';
import 'package:bookstore/models/transaction.dart';
import 'package:bookstore/ui/detail_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  TransactionListBloc transactionListBloc;
  ScrollController controller = ScrollController();
  String id = "";

  void onScroll() {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroller = controller.position.pixels;
    if (maxScroll == currentScroller) {
      transactionListBloc.add(FetchTransaction(id: id));
    }
  }

  void init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString("id");
      transactionListBloc = BlocProvider.of<TransactionListBloc>(context);
      transactionListBloc.add(FetchTransaction(id: id));
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    transactionListBloc.add(RefreshState());
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(onScroll);
    // TODO: implement build
    return Container(child:
        BlocBuilder<TransactionListBloc, TransactionListState>(
            builder: (context, state) {
      print(state.toString());

      if (state is TransactionErrorState) {
        return _buildErrorUi("Network problem",
            Icons.signal_cellular_connected_no_internet_4_bar);
      } else if (state is TransactionLoadingState) {
        return _buildLoading();
      } else if (state is LoadedTransactionList) {
        print(state.hasReachMax);
        print(state.list.length);
        return _buildListUI(state.hasReachMax, state.list);
      } else if (state is TransactionEmptyState) {
        return _buildErrorUi("No Transaction ", Icons.payment);
      }
    }));
  }

  Widget _buildListUI(bool hasReachMax, List<Transaction> data) {
    return ListView.separated(
      controller: controller,
      itemCount: (hasReachMax) ? data.length : data.length + 1,
      itemBuilder: (context, index) {
        if (index < data.length) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailTransaction(
                            trans_id: data[index].trans_id,
                          )));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.payment,
                    size: 40,
                    color: Colors.grey,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data[index].trans_id,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        data[index].date,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "Rp." + data[index].total,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.navigate_next,
                        color: Colors.grey,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return _buildLoading();
        }
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildErrorUi(String message, IconData iconData) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.grey,
              size: 70,
            ),
            Text(
              message,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
