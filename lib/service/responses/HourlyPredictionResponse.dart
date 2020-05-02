class HourlyPredictionResponse {
    String elaborado; // 2020-04-17T12:45:03
    String id; // 47186
    String nombre; // Valladolid
    Origen origen;
    Prediccion prediccion;
    String provincia; // Valladolid
    String version; // 1.0

    HourlyPredictionResponse({this.elaborado, this.id, this.nombre, this.origen, this.prediccion, this.provincia, this.version});

    factory HourlyPredictionResponse.fromJson(Map<String, dynamic> json) {
        return HourlyPredictionResponse(
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
    String enlace; // http://www.aemet.es/es/eltiempo/prediccion/municipios/horas/valladolid-id47186
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
    List<EstadoCielo> estadoCielo;
    String fecha; // 2020-04-19T00:00:00
    List<HumedadRelativa> humedadRelativa;
    List<Nieve> nieve;
    String ocaso; // 21:04
    String orto; // 07:31
    List<Precipitacion> precipitacion;
    List<ProbNieve> probNieve;
    List<ProbPrecipitacion> probPrecipitacion;
    List<ProbTormenta> probTormenta;
    List<SensTermica> sensTermica;
    List<Temperatura> temperatura;
    List<VientoAndRachaMax> vientoAndRachaMax;

    Dia({this.estadoCielo, this.fecha, this.humedadRelativa, this.nieve, this.ocaso, this.orto, this.precipitacion, this.probNieve, this.probPrecipitacion, this.probTormenta, this.sensTermica, this.temperatura, this.vientoAndRachaMax});

    factory Dia.fromJson(Map<String, dynamic> json) {
        return Dia(
            estadoCielo: json['estadoCielo'] != null ? (json['estadoCielo'] as List).map((i) => EstadoCielo.fromJson(i)).toList() : null,
            fecha: json['fecha'],
            humedadRelativa: json['humedadRelativa'] != null ? (json['humedadRelativa'] as List).map((i) => HumedadRelativa.fromJson(i)).toList() : null,
            nieve: json['nieve'] != null ? (json['nieve'] as List).map((i) => Nieve.fromJson(i)).toList() : null,
            ocaso: json['ocaso'],
            orto: json['orto'],
            precipitacion: json['precipitacion'] != null ? (json['precipitacion'] as List).map((i) => Precipitacion.fromJson(i)).toList() : null,
            probNieve: json['probNieve'] != null ? (json['probNieve'] as List).map((i) => ProbNieve.fromJson(i)).toList() : null,
            probPrecipitacion: json['probPrecipitacion'] != null ? (json['probPrecipitacion'] as List).map((i) => ProbPrecipitacion.fromJson(i)).toList() : null,
            probTormenta: json['probTormenta'] != null ? (json['probTormenta'] as List).map((i) => ProbTormenta.fromJson(i)).toList() : null,
            sensTermica: json['sensTermica'] != null ? (json['sensTermica'] as List).map((i) => SensTermica.fromJson(i)).toList() : null,
            temperatura: json['temperatura'] != null ? (json['temperatura'] as List).map((i) => Temperatura.fromJson(i)).toList() : null,
            vientoAndRachaMax: json['vientoAndRachaMax'] != null ? (json['vientoAndRachaMax'] as List).map((i) => VientoAndRachaMax.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['fecha'] = this.fecha;
        data['ocaso'] = this.ocaso;
        data['orto'] = this.orto;
        if (this.estadoCielo != null) {
            data['estadoCielo'] = this.estadoCielo.map((v) => v.toJson()).toList();
        }
        if (this.humedadRelativa != null) {
            data['humedadRelativa'] = this.humedadRelativa.map((v) => v.toJson()).toList();
        }
        if (this.nieve != null) {
            data['nieve'] = this.nieve.map((v) => v.toJson()).toList();
        }
        if (this.precipitacion != null) {
            data['precipitacion'] = this.precipitacion.map((v) => v.toJson()).toList();
        }
        if (this.probNieve != null) {
            data['probNieve'] = this.probNieve.map((v) => v.toJson()).toList();
        }
        if (this.probPrecipitacion != null) {
            data['probPrecipitacion'] = this.probPrecipitacion.map((v) => v.toJson()).toList();
        }
        if (this.probTormenta != null) {
            data['probTormenta'] = this.probTormenta.map((v) => v.toJson()).toList();
        }
        if (this.sensTermica != null) {
            data['sensTermica'] = this.sensTermica.map((v) => v.toJson()).toList();
        }
        if (this.temperatura != null) {
            data['temperatura'] = this.temperatura.map((v) => v.toJson()).toList();
        }
        if (this.vientoAndRachaMax != null) {
            data['vientoAndRachaMax'] = this.vientoAndRachaMax.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class HumedadRelativa {
    String periodo; // 07
    String value; // 100

    HumedadRelativa({this.periodo, this.value});

    factory HumedadRelativa.fromJson(Map<String, dynamic> json) {
        return HumedadRelativa(
            periodo: json['periodo'],
            value: json['value'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['periodo'] = this.periodo;
        data['value'] = this.value;
        return data;
    }
}

class Nieve {
    String periodo; // 07
    String value; // 0

    Nieve({this.periodo, this.value});

    factory Nieve.fromJson(Map<String, dynamic> json) {
        return Nieve(
            periodo: json['periodo'],
            value: json['value'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['periodo'] = this.periodo;
        data['value'] = this.value;
        return data;
    }
}

class Temperatura {
    String periodo; // 07
    String value; // 9

    Temperatura({this.periodo, this.value});

    factory Temperatura.fromJson(Map<String, dynamic> json) {
        return Temperatura(
            periodo: json['periodo'],
            value: json['value'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['periodo'] = this.periodo;
        data['value'] = this.value;
        return data;
    }
}

class ProbTormenta {
    String periodo; // 2002
    String value;

    ProbTormenta({this.periodo, this.value});

    factory ProbTormenta.fromJson(Map<String, dynamic> json) {
        return ProbTormenta(
            periodo: json['periodo'],
            value: json['value'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['periodo'] = this.periodo;
        data['value'] = this.value;
        return data;
    }
}

class EstadoCielo {
    String descripcion; // Muy nuboso
    String periodo; // 07
    String value; // 15n

    EstadoCielo({this.descripcion, this.periodo, this.value});

    factory EstadoCielo.fromJson(Map<String, dynamic> json) {
        return EstadoCielo(
            descripcion: json['descripcion'],
            periodo: json['periodo'],
            value: json['value'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['descripcion'] = this.descripcion;
        data['periodo'] = this.periodo;
        data['value'] = this.value;
        return data;
    }
}

class SensTermica {
    String periodo; // 07
    String value; // 8

    SensTermica({this.periodo, this.value});

    factory SensTermica.fromJson(Map<String, dynamic> json) {
        return SensTermica(
            periodo: json['periodo'],
            value: json['value'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['periodo'] = this.periodo;
        data['value'] = this.value;
        return data;
    }
}

class Precipitacion {
    String periodo; // 07
    String value; // 0

    Precipitacion({this.periodo, this.value});

    factory Precipitacion.fromJson(Map<String, dynamic> json) {
        return Precipitacion(
            periodo: json['periodo'],
            value: json['value'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['periodo'] = this.periodo;
        data['value'] = this.value;
        return data;
    }
}

class ProbNieve {
    String periodo; // 2002
    String value;

    ProbNieve({this.periodo, this.value});

    factory ProbNieve.fromJson(Map<String, dynamic> json) {
        return ProbNieve(
            periodo: json['periodo'],
            value: json['value'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['periodo'] = this.periodo;
        data['value'] = this.value;
        return data;
    }
}

class ProbPrecipitacion {
    String periodo; // 2002
    String value;

    ProbPrecipitacion({this.periodo, this.value});

    factory ProbPrecipitacion.fromJson(Map<String, dynamic> json) {
        return ProbPrecipitacion(
            periodo: json['periodo'],
            value: json['value'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['periodo'] = this.periodo;
        data['value'] = this.value;
        return data;
    }
}

class VientoAndRachaMax {
    List<String> direccion;
    String periodo; // 07
    String value; // 11
    List<String> velocidad;

    VientoAndRachaMax({this.direccion, this.periodo, this.value, this.velocidad});

    factory VientoAndRachaMax.fromJson(Map<String, dynamic> json) {
        return VientoAndRachaMax(
            direccion: json['direccion'] != null ? new List<String>.from(json['direccion']) : null,
            periodo: json['periodo'],
            value: json['value'],
            velocidad: json['velocidad'] != null ? new List<String>.from(json['velocidad']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['periodo'] = this.periodo;
        data['value'] = this.value;
        if (this.direccion != null) {
            data['direccion'] = this.direccion;
        }
        if (this.velocidad != null) {
            data['velocidad'] = this.velocidad;
        }
        return data;
    }
}