const ramos_atividade = [
  'Clínicas, laboratórios e serviços de saúde',
  'Companhias aéreas',
  'Cultura e entretenimento',
  'Escolas e universidades',
  'Farmácias',
  'Hotéis',
  'Joalherias',
  'Locadoras',
  'Lojas de artigos eletrônicos',
  'Lojas de departamento',
  'Lojas de materiais de construção',
  'Lojas de móveis e decoração',
  'Lojas de vestuário',
  'Operadoras de turismo',
  'Padarias, mercados de alimentos e bebidas',
  'Postos de combustível',
  'Restaurantes',
  'Serviços automotivos',
  'Serviços de transporte',
  'Serviços diversos',
  'Supermercados',
  'Varejistas'
];
const concorrentes = [
  'SumUp',
  'Mercado Pago',
  'Pop Credicard',
  'Stone',
  'PagSeguro',
  'Cielo',
  'Stelo',
  'iZettle'
];

class Concorrente {
  String name;
  String ramo;
  double credito;
  double debito;
  double minCredito;
  double minDebito;

  Concorrente(Map<String, dynamic> map) {
    this.name = map['name'];
    this.ramo = map['ramo'];
    this.credito = map['credito'];
    this.debito = map['debito'];
    this.minCredito = map['minCredito'];
    this.minDebito = map['minDebito'];
  }
}

class Proposta_aceita {
  double debito;
  double credito;
  double descontoDebito;
  double descontoCredito;
  double porcentagemDebito;
  double porcentagemCredito;
  String ramo, cpf, phone, email, concorrente, timestamp;

  Proposta_aceita(Map<String, dynamic> map) {
    this.cpf = map['cpf'];
    this.email = map['email'];
    this.phone = map['phone'];
    this.ramo = map['ramo'];
    this.concorrente = map['concorrente'];
    this.debito = map['debito'];
    this.credito = map['credito'];
    this.porcentagemDebito = map['porcentagemDebito'];
    this.porcentagemCredito = map['porcentagemCredito'];
    this.descontoDebito = map['descontoDebito'];
    this.descontoCredito = map['descontoCredito'];
    this.timestamp = map['timestamp'];
  }
}
