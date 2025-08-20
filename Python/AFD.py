def cargar_afd(conf_file):
    with open(conf_file, 'r') as f:
        lines = [line.strip() for line in f if line.strip()]

    estados = set()
    alfabeto = set()
    transiciones = {}
    inicial = None
    finales = set()

    for line in lines:
        if line.startswith('estados='):
            estados = set(line.split('=')[1].split(','))
        elif line.startswith('alfabeto='):
            alfabeto = set(line.split('=')[1].split(','))
        elif line.startswith('inicial='):
            inicial = line.split('=')[1]
        elif line.startswith('finales='):
            finales = set(line.split('=')[1].split(','))
        elif line.startswith('transiciones='):
            continue
        else:
            partes = line.split(',')
            if len(partes) == 3:
                origen, simbolo, destino = partes
                transiciones[(origen.strip(), simbolo.strip())] = destino.strip()

    return estados, alfabeto, inicial, finales, transiciones


def evaluar_cadena(afd, cadena):
    estados, alfabeto, estado_actual, finales, transiciones = afd

    for simbolo in cadena:
        if simbolo not in alfabeto:
            return False  # símbolo inválido
        if (estado_actual, simbolo) in transiciones:
            estado_actual = transiciones[(estado_actual, simbolo)]
        else:
            return False  # transición no definida

    return estado_actual in finales


def main():
    afd = cargar_afd('conf.txt')

    with open('cadenas.txt', 'r') as f:
        cadenas = [line.strip() for line in f if line.strip()]

    print("Resultados de evaluación:\n")
    for cadena in cadenas:
        resultado = evaluar_cadena(afd, cadena)
        print(f"{cadena} -> {'ACEPTADA' if resultado else 'RECHAZADA'}")

main()


