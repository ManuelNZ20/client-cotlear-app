class OrderBuy {
  final int idlastorderbuy; /* integer not null */
  final String idorderbuy; /* character varying(10) not null, */
  final String dateorder; /* timestamp without time zone not null, */
  final String datedelivery; /* timestamp without time zone null, */
  final String dateconfirm; /*  timestamp without time zone null */
  final String stateorder; /* character varying(20) not null */
  final double total; /* double precision not null, */
  final String idpaymentmethod; /* integer null default 1, */

  OrderBuy({
    required this.idlastorderbuy,
    required this.idorderbuy,
    required this.dateorder,
    required this.datedelivery,
    required this.dateconfirm,
    required this.stateorder,
    required this.total,
    required this.idpaymentmethod,
  });
}
