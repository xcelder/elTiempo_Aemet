class DailyPredictionResponse {
    String elaborado; // 2020-05-01T10:57:37
    int id; // -18350
    String nombre; // Valladolid
    Origen origen;
    Prediccion prediccion;
    String provincia; // Valladolid
    double version; // 1.0

    DailyPredictionResponse({this.elaborado, this.id, this.nombre, this.origen, this.prediccion, this.provincia, this.version});

    factory DailyPredictionResponse.fromJson(Map<String, dynamic> json) {
        return DailyPredictionResponse(
            elaborado: json['elaborado'],
            id: json['id'],
            nombre: json['nombre'],
            origen: json['origen'] != null ? Origen.fromJson(json['origen']) : null,
            prediccion: json['prediccion'] != null ? Prediccion.fromJson(json['prediccion']) : null,
            provincia: json['provincia'],
            version: json['version'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['elaborado'] = this.elaborado;
        data['id'] = this.id;
        data['nombre'] = this.nombre;
        data['provincia'] = this.provincia;
        data['version'] = this.version;
        if (this.origen != null) {
            data['origen'] = this.origen.toJson();
        }
        if (this.prediccion != null) {
            data['prediccion'] = this.prediccion.toJson();
        }
        return data;
    }
}

class Origen {
    String copyright; // © AEMET. Autorizado el uso de la información y su reproducción citando a AEMET como autora de la misma.
    String enlace; // http://www.aemet.es/es/eltiempo/prediccion/municipios/valladolid-id47186
    String language; // es
    String notaLegal; // http://www.aemet.es/es/nota_legal
    String productor; // Agencia Estatal de Meteorología - AEMET. Gobierno de España
    String web; // http://www.aemet.es

    Origen({this.copyright, this.enlace, this.language, this.notaLegal, this.productor, this.web});

    factory Origen.fromJson(Map<String, dynamic> json) {
        return Origen(
            copyright: json['copyright'],
            enlace: json['enlace'],
            language: json['language'],
            notaLegal: json['notaLegal'],
            productor: json['productor'],
            web: json['web'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['copyright'] = this.copyright;
        data['enlace'] = this.enlace;
        data['language'] = this.language;
        data['notaLegal'] = this.notaLegal;
        data['productor'] = this.productor;
        data['web'] = this.web;
        return data;
    }
}

class Prediccion {
    List<Dia> dia;

    Prediccion({this.dia});

    factory Prediccion.fromJson(Map<String, dynamic> json) {
        return Prediccion(
            dia: json['dia'] != null ? (json['dia'] as List).map((i) => Dia.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.dia != null) {
            data['dia'] = this.dia.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Dia {
    List<CotaNieveProv> cotaNieveProv;
    List<EstadoCielo> estadoCielo;
    String fecha; // 2020-05-07T00:00:00
    HumedadRelativa humedadRelativa;
    List<ProbPrecipitacion> probPrecipitacion;
    List<RachaMax> rachaMax;
    SensTermica sensTermica;
    Temperatura temperatura;
    int uvMax; // 7
    List<Viento> viento;

    Dia({this.cotaNieveProv, this.estadoCielo, this.fecha, this.humedadRelativa, this.probPrecipitacion, this.rachaMax, this.sensTermica, this.temperatura, this.uvMax, this.viento});

    factory Dia.fromJson(Map<String, dynamic> json) {
        return Dia(
            cotaNieveProv: json['cotaNieveProv'] != null ? (json['cotaNieveProv'] as List).map((i) => CotaNieveProv.fromJson(i)).toList() : null,
            estadoCielo: json['estadoCielo'] != null ? (json['estadoCielo'] as List).map((i) => EstadoCielo.fromJson(i)).toList() : null,
            fecha: json['fecha'],
            humedadRelativa: json['humedadRelativa'] != null ? HumedadRelativa.fromJson(json['humedadRelativa']) : null,
            probPrecipitacion: json['probPrecipitacion'] != null ? (json['probPrecipitacion'] as List).map((i) => ProbPrecipitacion.fromJson(i)).toList() : null,
            rachaMax: json['rachaMax'] != null ? (json['rachaMax'] as List).map((i) => RachaMax.fromJson(i)).toList() : null,
            sensTermica: json['sensTermica'] != null ? SensTermica.fromJson(json['sensTermica']) : null,
            temperatura: json['temperatura'] != null ? Temperatura.fromJson(json['temperatura']) : null,
            uvMax: json['uvMax'],
            viento: json['viento'] != null ? (json['viento'] as List).map((i) => Viento.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['fecha'] = this.fecha;
        data['uvMax'] = this.uvMax;
        if (this.cotaNieveProv != null) {
            data['cotaNieveProv'] = this.cotaNieveProv.map((v) => v.toJson()).toList();
        }
        if (this.estadoCielo != null) {
            data['estadoCielo'] = this.estadoCielo.map((v) => v.toJson()).toList();
        }
        if (this.humedadRelativa != null) {
            data['humedadRelativa'] = this.humedadRelativa.toJson();
        }
        if (this.probPrecipitacion != null) {
            data['probPrecipitacion'] = this.probPrecipitacion.map((v) => v.toJson()).toList();
        }
        if (this.rachaMax != null) {
            data['rachaMax'] = this.rachaMax.map((v) => v.toJson()).toList();
        }
        if (this.sensTermica != null) {
            data['sensTermica'] = this.sensTermica.toJson();
        }
        if (this.temperatura != null) {
            data['temperatura'] = this.temperatura.toJson();
        }
        if (this.viento != null) {
            data['viento'] = this.viento.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class CotaNieveProv {
    String value;
    String periodo;

    CotaNieveProv({this.value, this.periodo});

    factory CotaNieveProv.fromJson(Map<String, dynamic> json) {
        return CotaNieveProv(
            value: json['value'],
            periodo: json['periodo'] != null ? json['periodo'] : null
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['value'] = this.value;
        return data;
    }
}

class Temperatura {
    List<Dato> dato;
    int maxima; // 24
    int minima; // 12

    Temperatura({this.dato, this.maxima, this.minima});

    factory Temperatura.fromJson(Map<String, dynamic> json) {
        return Temperatura(
            dato: json['dato'] != null ? (json['dato'] as List).map((i) => Dato.fromJson(i)).toList() : null,
            maxima: json['maxima'],
            minima: json['minima'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['maxima'] = this.maxima;
        data['minima'] = this.minima;
        if (this.dato != null) {
            data['dato'] = this.dato.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class ProbPrecipitacion {
    int value; // 0
    String periodo;

    ProbPrecipitacion({this.value, this.periodo});

    factory ProbPrecipitacion.fromJson(Map<String, dynamic> json) {
        return ProbPrecipitacion(
            value: json['value'],
            periodo: json['periodo'] != null ? json['periodo'] : null
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['value'] = this.value;
        if (periodo != null) {
            data['periodo'] = this.periodo;
        }

        return data;
    }
}

class SensTermica {
    List<Dato> dato;
    int maxima; // 24
    int minima; // 12

    SensTermica({this.dato, this.maxima, this.minima});

    factory SensTermica.fromJson(Map<String, dynamic> json) {
        return SensTermica(
            dato: json['dato'] != null ? (json['dato'] as List).map((i) => Dato.fromJson(i)).toList() : null,
            maxima: json['maxima'],
            minima: json['minima'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['maxima'] = this.maxima;
        data['minima'] = this.minima;
        if (this.dato != null) {
            data['dato'] = this.dato.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class HumedadRelativa {
    List<Dato> dato;
    int maxima; // 75
    int minima; // 40

    HumedadRelativa({this.dato, this.maxima, this.minima});

    factory HumedadRelativa.fromJson(Map<String, dynamic> json) {
        return HumedadRelativa(
            dato: json['dato'] != null ? (json['dato'] as List).map((i) => Dato.fromJson(i)).toList() : null,
            maxima: json['maxima'],
            minima: json['minima'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['maxima'] = this.maxima;
        data['minima'] = this.minima;
        if (this.dato != null) {
            data['dato'] = this.dato.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Dato {
    int value;
    int hora;

    Dato({this.value, this.hora});

    factory Dato.fromJson(Map<String, dynamic> json) {
        return Dato(
          value: json["value"] != null ? json["value"] : null,
            hora: json["hora"] != null ? json["hora"] : null
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (value != null) {
            data["value"] = this.value;
        }
        if (hora != null) {
            data["hora"] = this.hora;
        }
        return data;
    }
}

class RachaMax {
    String value;
    String periodo;

    RachaMax({this.value, this.periodo});

    factory RachaMax.fromJson(Map<String, dynamic> json) {
        return RachaMax(
            value: json['value'],
            periodo: json['periodo'] != null ? json['periodo'] : null
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['value'] = this.value;
        if (periodo != null) {
            data['periodo'] = this.periodo;
        }

        return data;
    }
}

class EstadoCielo {
    String descripcion; // Nuboso
    String value; // 14
    String periodo;

    EstadoCielo({this.descripcion, this.value, this.periodo});

    factory EstadoCielo.fromJson(Map<String, dynamic> json) {
        return EstadoCielo(
            descripcion: json['descripcion'],
            value: json['value'],
            periodo: json['periodo'] != null ? json['periodo'] : null
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['descripcion'] = this.descripcion;
        data['value'] = this.value;
        if (periodo != null) {
            data['periodo'] = this.periodo;
        }

        return data;
    }
}

class Viento {
    String direccion; // NE
    int velocidad; // 15
    String periodo;

    Viento({this.direccion, this.velocidad, this.periodo});

    factory Viento.fromJson(Map<String, dynamic> json) {
        return Viento(
            direccion: json['direccion'],
            velocidad: json['velocidad'],
            periodo: json['periodo'] != null ? json['periodo'] : null
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['direccion'] = this.direccion;
        data['velocidad'] = this.velocidad;
        if (periodo != null) {
            data['periodo'] = this.periodo;
        }

        return data;
    }
}