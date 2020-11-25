class ObjetoLista {
  int id;
  int idLista;
  String nombre;
  String descripcion;
  bool loBusca;

  ObjetoLista(
      {this.id = 0,
      this.idLista = 0,
      this.nombre = "",
      this.descripcion = "",
      this.loBusca = true});

  factory ObjetoLista.fromJson(Map<String, dynamic> json) => ObjetoLista(
      id: json["id"],
      idLista: json["idLista"],
      descripcion: json["descripcion"],
      nombre: json["nombre"],
      loBusca: json["loBusca"]);

  Map<String, dynamic> toJson() => {
        "id": this.id ?? 0,
        "idLista": this.idLista ?? 0,
        "descripcion": this.descripcion ?? "",
        "nombre": this.nombre ?? "",
        "loBusca": this.loBusca ?? false
      };
}
