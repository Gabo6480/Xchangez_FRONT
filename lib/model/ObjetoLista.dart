class ObjetoLista {
  int id;
  int idLista;
  String contenido;
  String descripcion;
  bool loBusca;

  ObjetoLista(
      {this.id,
      this.idLista,
      this.contenido,
      this.descripcion,
      this.contenido,
      this.loBusca});

  factory ObjetoLista.fromJson(Map<String, dynamic> json) => ObjetoLista(
      id: json["id"],
      idLista: json["idLista"],
      descripcion: json["descripcion"],
      contenido: json["contenido"],
      loBusca: json["loBusca"]);

  Map<String, dynamic> toJson() => {
        "id": this.id != null ? this.id : 0,
        "idLista": this.idLista != null ? this.idLista : 0,
        "descripcion": this.descripcion != null ? this.descripcion : "",
        "contenido": this.contenido != null ? this.contenido : "",
        "loBusca": this.loBusca != null ? this.loBusca : false
      };
}
