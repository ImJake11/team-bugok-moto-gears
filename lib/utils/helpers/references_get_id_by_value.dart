

int referenceGetIdByValue(List<(int, String)> reference, String value){

  final query = reference.where((e)=> e.$2 == value);

  if(query.isEmpty) return 0;

  return query.first.$1;
}
