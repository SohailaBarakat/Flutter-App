import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/service_details_response.dart';

import '../widgets/service_details.dart';
import '../models/all_services_response.dart';

class ServicDetailScreen extends StatefulWidget {
  const ServicDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/service-detail';

  @override
  State<ServicDetailScreen> createState() => _ServicDetailScreenState();
}

class _ServicDetailScreenState extends State<ServicDetailScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final serviceId = ModalRoute.of(context)!.settings.arguments;
      Provider.of<ServiceDetails>(context)
          .fetchAndSetDetails(serviceId)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final serviceId = ModalRoute.of(context)!.settings.arguments;
    final loadedService = Provider.of<Services>(
      context,
      listen: false,
    ).items.firstWhere((serv) => serv.id == serviceId);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            toolbarHeight: 70,
            title: Container(
              margin: EdgeInsets.only(
                right: 15,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  loadedService.name!,
                  textAlign: TextAlign.right,
                ),
              ),
            )),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ServiceDetailsBody(),
      ),
    );
  }
}
