import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:thorchain_explorer/_classes/midgard_endpoint.dart';
import 'package:thorchain_explorer/_enums/networks.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';
import 'package:thorchain_explorer/_widgets/fluid_container.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

Future<String> midgardApi(MidgardEndpoint endpoint, Networks net) async {
  print('path is ${endpoint.path}');
  String path = createNavigatorPath(endpoint);

  final response = await http.get(Uri.https(
      (net == Networks.Testnet)
          ? 'testnet.midgard.thorchain.info'
          : 'midgard.thorchain.info',
      "v2/$path",

      // handle query parmas if they exist
      (endpoint.queryParams != null && endpoint.queryParams.length > 0)
          ? endpoint.queryParams.fold({}, (map, param) {
              if (param.value != null && param.value.length > 0) {
                map[param.key] = param.value;
              }
              return map;
            })
          : {}));

  if (response.statusCode == 200) {
    var object = jsonDecode(response.body);
    var prettyString = JsonEncoder.withIndent('  ').convert(object);
    return prettyString;
  } else {
    print('oh nooo');
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load endpoint');
  }
}

class MidgardEndpointController {
  TextEditingController controller;
  MidgardParam param;

  MidgardEndpointController({this.controller, this.param});
}

class EndpointDetails extends HookWidget {
  final MidgardEndpoint endpoint;

  EndpointDetails({this.endpoint});

  @override
  Widget build(BuildContext context) {
    Future<String> futureEndpoint;

    final midgardPath = (selectNetwork(net) == Networks.Testnet)
        ? "https://testnet.midgard.thorchain.info/v2${createNavigatorPath(endpoint)}"
        : "https://midgard.thorchain.info/v2${createNavigatorPath(endpoint)}";

    ThemeMode mode = useProvider(userThemeProvider.state);

    // final pathParams = useState([]);
    final pathParams = useState<List<MidgardEndpointController>>(
        (endpoint.pathParams != null)
            ? endpoint.pathParams
                .map((param) => MidgardEndpointController(
                    controller: useTextEditingController(text: param.value),
                    param: param))
                .toList()
            : []);

    final queryPathParams = useState<List<MidgardEndpointController>>(
        (endpoint.queryParams != null)
            ? endpoint.queryParams
                .map((param) => MidgardEndpointController(
                    controller: useTextEditingController(text: param.value),
                    param: param))
                .toList()
            : []);
    final padding = 12.toDouble();

    useEffect(() {
      futureEndpoint = midgardApi(endpoint, selectNetwork(net));
      return;
    }, const []);

    return FutureBuilder<String>(
      future: futureEndpoint,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
              child: FluidContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text(endpoint.name,
                          style: Theme.of(context).textTheme.headline1),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: GestureDetector(
                            onTap: () => html.window
                                .open(midgardPath, "Midgard ${endpoint.name}"),
                            child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: RichText(
                                            text: TextSpan(
                                                children: [
                                              TextSpan(text: midgardPath),
                                              WidgetSpan(
                                                  child: Icon(
                                                Icons.open_in_new,
                                                size: 16,
                                                color: Colors.grey,
                                              ))
                                            ],
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .hintColor))),
                                      )
                                    ],
                                  ),
                                ))),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(4.0),
                  child: Container(
                    decoration: containerBoxDecoration(context, mode),
                    // padding: EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: pathParams.value.length < 1
                              ? [Container()]
                              : [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      "Path Params",
                                      style: TextStyle(
                                          color: Theme.of(context).hintColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: padding,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  SizedBox(
                                    height: padding,
                                  ),
                                  ...buildParamsForm(
                                      context, pathParams.value, mode),
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: queryPathParams.value.length < 1
                              ? [Container()]
                              : [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      "Query Params",
                                      style: TextStyle(
                                          color: Theme.of(context).hintColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: padding,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  SizedBox(
                                    height: padding,
                                  ),
                                  ...buildParamsForm(
                                      context, queryPathParams.value, mode),
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                        ),
                        (queryPathParams.value.length < 1 &&
                                pathParams.value.length < 1)
                            ? Container()
                            : Column(
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: TextButton(
                                              onPressed: () {
                                                final path = buildPath(
                                                    endpoint,
                                                    pathParams.value,
                                                    queryPathParams.value);
                                                Navigator.pushNamed(
                                                    context, "/midgard$path");
                                              },
                                              child: Text("Search")),
                                        )
                                      ]),
                                  SizedBox(
                                    height: 48,
                                  ),
                                ],
                              ),
                        Container(
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                          child: Text(
                            "Result",
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                        ),
                        SizedBox(
                          height: padding,
                        ),
                        Divider(
                          height: 1,
                          color: Theme.of(context).hintColor,
                        ),
                        SizedBox(
                          height: padding,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                child: SelectableText(
                                  snapshot.data,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

List<Container> buildParamsForm(BuildContext context,
    List<MidgardEndpointController> paramControllers, ThemeMode mode) {
  return (paramControllers != null && paramControllers.length > 0)
      ? paramControllers
          .map((e) => Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                          child: Text(e.param.name,
                              style: TextStyle(
                                  color: Theme.of(context).hintColor)),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        (e.param.required != null && e.param.required == true)
                            ? Text(
                                "*Required",
                                style: TextStyle(color: Colors.red[300]),
                              )
                            : Text("")
                      ],
                    ),
                    (e.param.valueOptions != null &&
                            e.param.valueOptions.length > 0)
                        ? Container(
                            padding: EdgeInsets.only(bottom: 4),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text("Options: ",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).hintColor)),
                                  ),
                                  ...e.param.valueOptions
                                      .map((option) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: 6, top: 6),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: MediaQuery.of(context)
                                                            .platformBrightness ==
                                                        Brightness.dark
                                                    ? Color.fromRGBO(
                                                        255, 255, 255, 0.075)
                                                    : Color.fromRGBO(
                                                        0, 0, 0, 0.075),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4,
                                                      horizontal: 8),
                                              child: SelectableText(option,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .hintColor)),
                                            ),
                                          ))
                                      .toList()
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 4, 16, 32),
                      child: TextField(
                        controller: e.controller,
                        decoration: InputDecoration(
                          fillColor: mode == ThemeMode.dark
                              ? Color.fromRGBO(255, 255, 255, 0.075)
                              : Color.fromRGBO(0, 0, 0, 0.075),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).hintColor, width: 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
          .toList()
      : Container();
}

String buildPath(
    MidgardEndpoint e,
    List<MidgardEndpointController> pathParamControllers,
    List<MidgardEndpointController> queryParamControllers) {
  String path = e.path;
  String queryParams = '';

  for (var i = 0; i < pathParamControllers.length; i++) {
    if (path.contains("{${pathParamControllers[i].param.key}}")) {
      path = path.replaceAll("{${pathParamControllers[i].param.key}}",
          pathParamControllers[i].controller.value.text);
    }
  }

  if (queryParamControllers.isNotEmpty) {
    for (var i = 0; i < queryParamControllers.length; i++) {
      final qpController = queryParamControllers[i];
      if (qpController.controller.value.text != "") {
        final leadingSymbol = (i == 0) ? '?' : '&';

        queryParams +=
            "$leadingSymbol${qpController.param.key}=${qpController.controller.value.text}";
      }
    }

    path += queryParams;
  }

  return path;
}
