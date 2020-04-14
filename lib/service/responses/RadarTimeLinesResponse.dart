class RadarTimeLinesResponse {
    List<Elemento> elementos;
    List<String> lineaTiempo;
    String producto; // PPI.Z_005_240
    String region; // penbal

    RadarTimeLinesResponse({this.elementos, this.lineaTiempo, this.producto, this.region});

    factory RadarTimeLinesResponse.fromJson(Map<String, dynamic> json) {
        return RadarTimeLinesResponse(
            elementos: json['Elementos'] != null ? (json['Elementos'] as List).map((i) => Elemento.fromJson(i)).toList() : null,
            lineaTiempo: json['lineaTiempo'] != null ? new List<String>.from(json['lineaTiempo']) : null,
            producto: json['Producto'],
            region: json['Region'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['Producto'] = this.producto;
        data['Region'] = this.region;
        if (this.elementos != null) {
            data['Elementos'] = this.elementos.map((v) => v.toJson()).toList();
        }
        if (this.lineaTiempo != null) {
            data['lineaTiempo'] = this.lineaTiempo;
        }
        return data;
    }
}

class Elemento {
    String fecha; // 2020-04-09T13:00:00+02:00
    String fichero; // ZAR200409110000.PPI.Z_005_240.png
    String producto; // PPI
    String radar; // ZAR
    String subproducto; // Z_005_240

    Elemento({this.fecha, this.fichero, this.producto, this.radar, this.subproducto});

    factory Elemento.fromJson(Map<String, dynamic> json) {
        return Elemento(
            fecha: json['Fecha'],
            fichero: json['Nombre fichero'],
            producto: json['producto'],
            radar: json['Nombre radar'],
            subproducto: json['subproducto'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['Fecha'] = this.fecha;
        data['Nombre fichero'] = this.fichero;
        data['producto'] = this.producto;
        data['Nombre radar'] = this.radar;
        data['subproducto'] = this.subproducto;
        return data;
    }
}