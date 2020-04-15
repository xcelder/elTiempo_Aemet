class RadarTimeLinesResponse {
    List<String> fechas;
    List<String> imagenes;
    String nombre; // Palencia

    RadarTimeLinesResponse({this.fechas, this.imagenes, this.nombre});

    factory RadarTimeLinesResponse.fromJson(Map<String, dynamic> json) {
        return RadarTimeLinesResponse(
            fechas: json['fechas'] != null ? new List<String>.from(json['fechas']) : null,
            imagenes: json['imagenes'] != null ? new List<String>.from(json['imagenes']) : null,
            nombre: json['nombre'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['nombre'] = this.nombre;
        if (this.fechas != null) {
            data['fechas'] = this.fechas;
        }
        if (this.imagenes != null) {
            data['imagenes'] = this.imagenes;
        }
        return data;
    }
}