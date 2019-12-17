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
  double credito;
  double debito;

  Concorrente(Map<String, dynamic> map) {
    this.name = map['name'];
    this.credito = map['credito'];
    this.debito = map['debito'];
  }

}
