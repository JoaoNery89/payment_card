class CepModel {

  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String unidade;
  final String ibge;
  final String gia;

  CepModel({
    this.cep,
    this.logradouro,
    this.complemento,
    this.bairro,
    this.localidade,
    this.uf,
    this.unidade,
    this.ibge,
    this.gia,
  });

  factory CepModel.fromJson(Map<String, dynamic> json) => CepModel(
    cep: json["cep"],
    logradouro: json["logradouro"],
    complemento: json["complemento"],
    bairro: json["bairro"],
    localidade: json["localidade"],
    uf: json["uf"],
    unidade: json["unidade"],
    ibge: json["ibge"],
    gia: json["gia"],
  );

  static Map<String, dynamic> toJson(CepModel cepLogradouro) => {
    "cep": cepLogradouro.cep,
    "logradouro": cepLogradouro.logradouro,
    "complemento": cepLogradouro.complemento,
    "bairro": cepLogradouro.bairro,
    "localidade": cepLogradouro.localidade,
    "uf": cepLogradouro.uf,
    "unidade": cepLogradouro.unidade,
    "ibge": cepLogradouro.ibge,
    "gia": cepLogradouro.gia,
  };
}

class CepResponse {
  final CepModel results;
  final String error;

  CepResponse(this.results, this.error);

  CepResponse.fromJson(Map<String, dynamic> json)
    : results = new CepModel.fromJson(json),
      error = "";

  CepResponse.withError(String errorValue)
    : results = CepModel(),
      error = errorValue;
}
