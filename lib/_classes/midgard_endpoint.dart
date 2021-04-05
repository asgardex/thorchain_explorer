class MidgardParam {
  String name;
  String key;
  String value;
  List<String> valueOptions;
  bool required;

  MidgardParam(
      {this.name, this.key, this.value, this.valueOptions, this.required});
}

class MidgardEndpoint {
  String path;
  String name;
  List<MidgardParam> pathParams;
  List<MidgardParam> queryParams;
  bool active;

  MidgardEndpoint(
      {this.path,
      this.name,
      this.pathParams,
      this.queryParams,
      this.active = false});
}

String createNavigatorPath(MidgardEndpoint e) {
  String path = e.path;
  if (e.pathParams != null && e.pathParams.length > 0) {
    for (var i = 0; i < e.pathParams.length; i++) {
      path = path.replaceAll("{${e.pathParams[i].key}}", e.pathParams[i].value);
    }
  }

  return path;
}

String appendQueryParams(String path, MidgardEndpoint e) {
  String queryParams = '';
  if (e.queryParams != null && e.queryParams.length > 0) {
    List<MidgardParam> requiredQueryParams = [];

    for (var i = 0; i < e.queryParams.length; i++) {
      if (e.queryParams[i].required == true) {
        print('VALUE ${e.queryParams[i].value}');
        print('root -> ${e.queryParams[i].key} is ${e.queryParams[i].value}');
        requiredQueryParams.add(e.queryParams[i]);
      }
    }

    if (requiredQueryParams.length > 0) {
      for (var i = 0; i < requiredQueryParams.length; i++) {
        String leadingSymbol = (i == 0) ? '?' : '&';

        queryParams +=
            '$leadingSymbol${requiredQueryParams[i].key}=${requiredQueryParams[i].value}';
      }
      path += queryParams;
    }
  }

  return path;
}

int matchParam(String key, List<MidgardParam> params) {
  for (var i = 0; i < params.length; i++) {
    if (params[i].key == key) {
      return i;
    }
  }
  return -1;
}
