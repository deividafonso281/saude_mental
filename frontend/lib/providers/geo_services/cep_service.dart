import 'package:search_cep/search_cep.dart';

class CepService {
  static final PostmonSearchCep _postmonSearchCep = PostmonSearchCep();

  static Future<CepInfo> getAddressByCep(String cep) async {
    var dataReceived = await _postmonSearchCep.searchInfoByCep(cep: cep);

    SearchCepError? error;
    PostmonCepInfo? postmonCepInfo;

    dataReceived.fold((l) => error = l, (r) => postmonCepInfo = r);

    return error != null && postmonCepInfo == null
        ? CepInfo(hasData: false, errorMessage: error!.errorMessage)
        : CepInfo(
            hasData: true,
            bairro: postmonCepInfo!.bairro,
            cidade: postmonCepInfo!.cidade,
            cep: postmonCepInfo!.cep,
            logradouro: postmonCepInfo!.logradouro,
            estado: postmonCepInfo!.estado,
          );
  }
}

class CepInfo {
  String? bairro;
  String? cidade;
  String? estado;
  String? logradouro;
  String? cep;
  bool hasData = false;
  String? errorMessage;

  CepInfo(
      {required this.hasData,
      this.bairro,
      this.cidade,
      this.cep,
      this.logradouro,
      this.estado,
      this.errorMessage});
}
