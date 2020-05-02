class OpenDataBaseResponse {
    String datos; // https://opendata.aemet.es/opendata/sh/323b774a
    String descripcion; // exito
    int estado; // 200
    String metadatos; // https://opendata.aemet.es/opendata/sh/93a7c63d

    OpenDataBaseResponse({this.datos, this.descripcion, this.estado, this.metadatos});

    factory OpenDataBaseResponse.fromJson(Map<String, dynamic> json) {
        return OpenDataBaseResponse(
            datos: json['datos'],
            descripcion: json['descripcion'],
            estado: json['estado'],
            metadatos: json['metadatos'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['datos'] = this.datos;
        data['descripcion'] = this.descripcion;
        data['estado'] = this.estado;
        data['metadatos'] = this.metadatos;
        return data;
    }
}