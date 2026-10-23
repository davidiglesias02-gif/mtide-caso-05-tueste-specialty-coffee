# Memo para la dirección de Tueste Specialty Coffee

## Qué hemos visto

- **La bebida que menos deja es el {{ pregunta_1.bebida[0] }}**: {{ pregunta_1.ingreso_taza[0] }} € por taza sin IVA, frente a {{ pregunta_1.ingreso_taza[7] }} € del {{ pregunta_1.bebida[7] }}.
- **{{ pregunta_2.barista[0] }} gasta más café por taza que nadie**: {{ pregunta_2.g_taza[0] }} g, cuando el siguiente del equipo usa {{ pregunta_2.g_taza[1] }} g.
- **La cafetera {{ pregunta_3.cafetera[0] }} es la que más falla**: {{ pregunta_3.incidencias_100tazas[0] }} incidencias por cada 100 tazas, casi el triple que la siguiente ({{ pregunta_3.cafetera[1] }}, {{ pregunta_3.incidencias_100tazas[1] }}).
- **Faltan baristas en la hora punta de la mañana**: a las {{ pregunta_4.hora[0] }} entran {{ pregunta_4.tazas[0] }} tazas y harían falta {{ pregunta_4.baristas_necesarios[0] }} baristas, pero el turno tiene {{ pregunta_4.baristas_turno[0] }}. A las {{ pregunta_4.hora[1] }} faltan {{ pregunta_4.baristas_que_faltan[1] }} y a las {{ pregunta_4.hora[2] }}, {{ pregunta_4.baristas_que_faltan[2] }}.

## Qué recomendamos

1. **Reforzar la barra de 8:00 a 10:00 y de 13:00 a 14:00.** Es donde se pasa de {{ pregunta_4.baristas_turno[0] }} baristas a necesitar hasta {{ pregunta_4.baristas_necesarios[0] }}. En el resto del día ninguna hora pasa de {{ pregunta_4.tazas[3] }} tazas, así que los turnos actuales llegan, también los de un solo barista.
2. **Revisar el precio o el coste del {{ pregunta_1.bebida[0] }}.** Con {{ pregunta_1.ingreso_taza[0] }} € por taza es la bebida que menos aporta; conviene comprobar si cubre el café y la mano de obra que lleva.
3. **Hablar con {{ pregunta_2.barista[0] }} sobre la dosis.** Usa {{ pregunta_2.g_taza[0] }} g por taza frente a los {{ pregunta_2.g_taza[1] }} g del siguiente: una receta común ahorra café sin cambiar la bebida.
4. **Revisar o sustituir la cafetera {{ pregunta_3.cafetera[0] }}.** Acumula {{ pregunta_3.incidencias[0] }} incidencias en {{ pregunta_3.tazas[0] }} tazas.

## Qué no sabemos todavía

- La pregunta 4 sale de **un solo día** de tickets del TPV (el 2 de abril, {{ stg_eventos.filas }} tickets). Necesitamos varias semanas para saber si la ráfaga de la mañana se repite cada día o depende del día de la semana.
- Suponemos que **un barista prepara 30 tazas por hora**, sea cual sea la bebida. Un V60 o un matcha llevan más tiempo que un espresso: si la cifra real es otra, cambia cuántos baristas faltan.
- **Hemos corregido datos del parte**: desde el {{ calidad_parte.primer_dia_con_iva[0] }}, el TPV nuevo apunta los importes con IVA, y los hemos pasado a sin IVA dividiendo entre 1,21 ({{ calidad_parte.filas_importe_con_iva[0] }} pedidos). Si alguno de esos productos llevara otro tipo de IVA, el ingreso por taza cambiaría ligeramente. También se corrigieron {{ calidad_parte.filas_tazas_corregidas[1] }} pedidos con un número de tazas imposible.
- No sabemos el **coste** de cada bebida, solo lo que se cobra: para hablar de margen, y no solo de ingreso, haría falta.

## Cómo se ha hecho

Los datos se guardan en tres capas: bronce (lo que llega, sin tocar), plata (limpio) y oro (las respuestas), y se reconstruyen solos con cada entrega. En la última entrega del parte, el cambio de TPV hizo que los importes llegaran con IVA desde el 26 de marzo, algo que ningún control básico detectaba porque los números parecían válidos. Lo descubrió y lo vigila desde ahora el test `precio_cuadra_con_carta`: comprueba que el precio medio por taza de cada bebida cuadra con la carta (±2 %). Si el TPV vuelve a cambiar de criterio, la carga se pondrá en rojo antes de que el dato llegue a este memo.
