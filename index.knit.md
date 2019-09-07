---
title: "Métodos de inferencia causal en el campo de enfermedades neurodegenerativas"
author: "L. Paloma Rojas Saunero"
date: '2019-09-07'
output:
  xaringan::moon_reader:
    lib_dir: libs
    css: xaringan-themer.css
    nature:
      highlightStyle: github
      highlightLines: true
      countIncrementalSlides: false
---








---

# Qué es inferencia causal?

---
background-image: url(http://es.xkcd.com/site_media/strips/correlation.png)

# Correlación no implica causalidad

---

# Ejemplo:

--

## &#x1F575;

--

## &#x26C8;&#xFE0F; <-> &#x2614;

--
## &#x1F31E; + &#x2602;&#xFE0F; = &#x1F937;

--
## &#x1F321;&#xFE0F; -> &#x26C8;&#xFE0F;

## &#x1F321;&#xFE0F; ->  &#x2614;

---


.pull-left[
### Intervenciones en un tiempo específico 

#### &#x1F489;

Cirugía

Un trauma craneo-encefálico

<img src=./time_fixed.png />

]

--

.pull-right[
### Intervenciones sostenidas en el tiempo 

### &#x1F48A; &#x1F957;
### &#x1F6AD; &#x1F3C3; &#x1F6B5;

<img src=./time_varying.png />

]

.footnote[
- A (Exposición), L (Confundidores), Y (Resultado), U (confundidores no medidos).
- DAG from Hernan MA, Robins JM (2019). Causal Inference.]

---
# Ensayos clínicos aleatorizados

.pull-left[


<img src=./rct.png width="400" height="200" />
]

--

.pull-right[
**Análisis por intención de tratar:**

Cuál es el efecto de la aleatorización?



**Análisis por protocolo:**

Cuál es el efecto de la intervención si todos hubiesen seguido la estrategia asignada durante todo el periodo de tiempo?
]

.footnote[
- A (Exposición), L (Confundidores), Y (Resultado), U (confundidores no medidos).
- DAG from Hernan MA, Robins JM (2019). Causal Inference.]
---

# Estudios observacionales

.pull-left[

<img src=./observational.png width="400" height="200"/>]

.pull-right[
- Estudios de cohorte, historias clínicas electrónicas, registros nacionales

- Bajo ciertos supuestos podemos estimar el efecto causal de una exposición como si estuviesemos realizando un ensayo clínico aleatorizado.
]

.footnote[
- A (Exposición), L (Confundidores), Y (Resultado), U (confundidores no medidos).
- DAG from Hernan MA, Robins JM (2019). Causal Inference.]
---
name: title
class: center, middle

## Intervenciones hipotéticas en la Presión Arterial Sistólica y &#x1F6AD; para reducir el riesgo ACV y de demencia

---

## Motivación

- El ACV y demencia son una carga importante en la salud pública y tienen factores de riesgo compartidos. 

- Los ensayos clínicos aleatorizados estudian poblaciones muy específicas, tienen poco tiempo de seguimiento y utilizan análisis por intensión de tratar. 

- Hay poca evidencia del **efecto sostenido** de intervenciones sobre la presión arterial y le cese de fumar


---

## Métodos

- Participantes del **Rotterdam Study**, recrutados entre 1990-1993 y seguidos en 5 oportunidades a lo largo de 20 años (n = 7983)

- Criterios de inclusión:

  + Personas menores a 80 años
  
  + Sin historia de ACV o demencia o deterioro cognitivo al ingreso al estudio
  
  + Información completa al ingreso
  
- Muestra total de **5113** 

---

## Intervenciones hipotéticas 

- Curso natural

--

- Mantener la presión arterial sistólica (PAS) < 120 mmHg

- Mantener la presión arterial sistólica (PAS) < 140 mmHg

- Reducir en un 10% del valor actual si es > a 140 mmHg

--

- &#x1F6AD; (si fuma actualmente)

--

- Intervenciones conjuntas para disminuir la presión arterial y &#x1F6AD;



---
## Variable de resultado

- ACV 

- Demencia

- Seguimiento durante 15 años desde el recrutamiento 

- Pérdida de seguimiento

- Muerte es un evento competitivo

---
## Covariables

.pull-left[
**Covariables al inicio del estudio:** 

- Edad
- Educacion
- Historia de diabetes
- Historia de enfermedad cardiaca
- Presión arterial sistólica
]

--

.pull-right[
**Covariables que cambian en el tiempo:** 

- Proceso de las visitas
- Presión Arterial sistólica
- Indice de masa corporal
- Consumo de cigarrillos
- Ingesta de alcohol (g/dia)
- Colesterol
- Medicación para la presión alta
- Desarrollo de: 
  - Diabetes
  - Enfermedad cardiaca
  - Cancer 
  - ACV/Demencia]
  
---
  
## Analisis

.center[**_Qué pasaría si toda la población hubiese seguido la intervención asignada (g)?_**]

- G-formula paramétrica

- Permite la presencia de covariables que cambian en el tiempo y que dichas variables pudiesen ser afectadas por la exposición en un tiempo previo.

--

.pull-left[<img src=./dag1.PNG width="400" height="200" />]

--

.pull-right[<img src=./dag2.PNG width="400" height="200" />]

--

.footnote[
- A (exposición), L (confundidores), Y (resultado)
- *g=1*: intervención hipotética (ex. mantener la PAS < 140)]
---

## G-formula paramétrica

1. **_Modelamos_** cada variable por separado (A, L, Y, D) utilizando la información de las variables en los tiempos previos.

--

2. Seleccionamos una muestra al azar y **_simulamos_** la cohorte usando los coeficientes que estimamos en el paso 1 utilizando Monte Carlo.

--

3. **_Intervenimos_** asignando el valor de la exposición que corresponde a la intervención hipotética en todos los puntos del tiempo.

--

4. **_Estimamos_** la probabilidad predicha de la variable de resultado basada en los valores actualizados de la exposición.

--

5. **_Calculamos_** el promedio del riesgo específico de cada individuo y estimamos los intervalos de confianza utilizando bootstrap.

--

6. Repetimos los pasos 2 a 5 para cada intervención. **_Comparamos_** cada intervención con el curso natural.

---

# Supuestos

--

- Intercambiabilidad: *Medimos todas las variables que puedan afectar los resultados*

- Positividad: *Pr(Expuesto|Covariables > 0)*

- Consistencia: *Intervención está bien definida*

- Los modelos están correctamente especificados

---
## Resultados: ACV
El riesgo observado en 15 años de seguimiento es **10.7%**. 

<table class="table table-hover table-responsive" style="font-size: 15px; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Intervencion </th>
   <th style="text-align:left;"> Riesgo </th>
   <th style="text-align:left;"> Riesgo Relativo </th>
   <th style="text-align:left;"> Diferencia de Riesgo </th>
   <th style="text-align:right;"> Total Intervenido % </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 0. Curso natural </td>
   <td style="text-align:left;"> 10.6 (9.6,11.8) </td>
   <td style="text-align:left;"> 1 (1, 1) </td>
   <td style="text-align:left;"> 0 (0, 0) </td>
   <td style="text-align:right;"> 0.0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1. Mantener PAS &lt; 120 mmHg </td>
   <td style="text-align:left;"> 9.2 (7.7,11.1) </td>
   <td style="text-align:left;"> 0.9 (0.7, 1) </td>
   <td style="text-align:left;"> -1.4 (-2.8, 0.1) </td>
   <td style="text-align:right;"> 97.9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2. Mantener PAS &lt; 140 mmHg </td>
   <td style="text-align:left;"> 9.5 (8.3,10.7) </td>
   <td style="text-align:left;"> 0.9 (0.8, 1) </td>
   <td style="text-align:left;"> -1.1 (-2, -0.5) </td>
   <td style="text-align:right;"> 83.5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3. Reducir PAS en 10% si &gt; 140 mmHg </td>
   <td style="text-align:left;"> 9.3 (8.1,10.6) </td>
   <td style="text-align:left;"> 0.9 (0.8, 1) </td>
   <td style="text-align:left;"> -1.3 (-2.3, -0.4) </td>
   <td style="text-align:right;"> 83.5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4. Dejar de fumar (si fuma actualmente) </td>
   <td style="text-align:left;"> 9.9 (8.8,11.2) </td>
   <td style="text-align:left;"> 0.9 (0.9, 1) </td>
   <td style="text-align:left;"> -0.8 (-1.3, -0.3) </td>
   <td style="text-align:right;"> 26.5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6. Intervencion 1 + 4 </td>
   <td style="text-align:left;"> 8.6 (7.1,10.5) </td>
   <td style="text-align:left;"> 0.8 (0.7, 0.9) </td>
   <td style="text-align:left;"> -2.1 (-3.5, -0.6) </td>
   <td style="text-align:right;"> 99.1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7. Intervencion 2 + 4 </td>
   <td style="text-align:left;"> 8.7 (7.6,10.1) </td>
   <td style="text-align:left;"> 0.8 (0.7, 0.9) </td>
   <td style="text-align:left;"> -1.9 (-2.8, -1.1) </td>
   <td style="text-align:right;"> 88.6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8. Intervencion 3 + 4 </td>
   <td style="text-align:left;"> 8.7 (7.5,10.1) </td>
   <td style="text-align:left;"> 0.8 (0.7, 0.9) </td>
   <td style="text-align:left;"> -2 (-3, -1.1) </td>
   <td style="text-align:right;"> 88.8 </td>
  </tr>
</tbody>
<tfoot>
<tr><td style="padding: 0; border: 0;" colspan="100%"><span style="font-style: italic;">Note: </span></td></tr>
<tr><td style="padding: 0; border: 0;" colspan="100%">
<sup></sup> PAS: Presion arterial sistolica, 500 bootstraps.</td></tr>
</tfoot>
</table>

---
## Resultados: ACV

<img src="index_files/figure-html/unnamed-chunk-3-1.png" width="648" style="display: block; margin: auto;" />
---
## Resultados: ACV

<img src="index_files/figure-html/unnamed-chunk-4-1.png" width="648" style="display: block; margin: auto;" />
---
## Resultados: ACV

<img src="index_files/figure-html/unnamed-chunk-5-1.png" width="648" style="display: block; margin: auto;" />

## Resultados: ACV

<img src="index_files/figure-html/unnamed-chunk-6-1.png" width="648" style="display: block; margin: auto;" />
---
## Resultados: ACV

<img src="index_files/figure-html/unnamed-chunk-7-1.png" width="648" style="display: block; margin: auto;" />
---
## Resultados: ACV

<img src="index_files/figure-html/unnamed-chunk-8-1.png" width="648" style="display: block; margin: auto;" />
---
## Resultados: ACV

<img src="index_files/figure-html/unnamed-chunk-9-1.png" width="648" style="display: block; margin: auto;" />

---
## Resultados: Demencia

El riesgo observado en 15 años de seguimiento es **9.15%**. 

<table class="table table-hover table-responsive" style="font-size: 15px; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Intervencion </th>
   <th style="text-align:left;"> Riesgo </th>
   <th style="text-align:left;"> Riesgo Relativo </th>
   <th style="text-align:left;"> Diferencia de Riesgo </th>
   <th style="text-align:right;"> Total Intervenido % </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 0. Curso natural </td>
   <td style="text-align:left;"> 9.2 (8.3,10.3) </td>
   <td style="text-align:left;"> 1 (1, 1) </td>
   <td style="text-align:left;"> 0 (0, 0) </td>
   <td style="text-align:right;"> 0.0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1. Mantener PAS &lt; 120 mmHg </td>
   <td style="text-align:left;"> 10.1 (8.2,11.8) </td>
   <td style="text-align:left;"> 1.1 (0.9, 1.2) </td>
   <td style="text-align:left;"> 0.8 (-0.6, 2.2) </td>
   <td style="text-align:right;"> 98.2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2. Mantener PAS &lt; 140 mmHg </td>
   <td style="text-align:left;"> 9.4 (8.2,10.7) </td>
   <td style="text-align:left;"> 1 (0.9, 1.1) </td>
   <td style="text-align:left;"> 0.2 (-0.5, 0.9) </td>
   <td style="text-align:right;"> 84.3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3. Reducir PAS en 10% si &gt; 140 mmHg </td>
   <td style="text-align:left;"> 9.5 (8.2,11) </td>
   <td style="text-align:left;"> 1 (0.9, 1.1) </td>
   <td style="text-align:left;"> 0.3 (-0.5, 1.1) </td>
   <td style="text-align:right;"> 84.0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4. Dejar de fumar (si fuma actualmente) </td>
   <td style="text-align:left;"> 9.4 (8.4,10.4) </td>
   <td style="text-align:left;"> 1 (1, 1.1) </td>
   <td style="text-align:left;"> 0.1 (-0.3, 0.5) </td>
   <td style="text-align:right;"> 26.4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6. Intervencion 1 + 4 </td>
   <td style="text-align:left;"> 10.1 (8.3,12) </td>
   <td style="text-align:left;"> 1.1 (0.9, 1.3) </td>
   <td style="text-align:left;"> 0.9 (-0.6, 2.5) </td>
   <td style="text-align:right;"> 98.9 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7. Intervencion 2 + 4 </td>
   <td style="text-align:left;"> 9.5 (8.3,10.8) </td>
   <td style="text-align:left;"> 1 (1, 1.1) </td>
   <td style="text-align:left;"> 0.3 (-0.5, 1.1) </td>
   <td style="text-align:right;"> 89.6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8. Intervencion 3 + 4 </td>
   <td style="text-align:left;"> 9.7 (8.3,11) </td>
   <td style="text-align:left;"> 1.1 (1, 1.1) </td>
   <td style="text-align:left;"> 0.4 (-0.5, 1.3) </td>
   <td style="text-align:right;"> 89.1 </td>
  </tr>
</tbody>
<tfoot>
<tr><td style="padding: 0; border: 0;" colspan="100%"><span style="font-style: italic;">Note: </span></td></tr>
<tr><td style="padding: 0; border: 0;" colspan="100%">
<sup></sup> PAS: Presion arterial sistolica, 500 bootstraps.</td></tr>
</tfoot>
</table>
---
## Resultados: Demencia

<img src="index_files/figure-html/unnamed-chunk-11-1.png" width="648" style="display: block; margin: auto;" />
---
## Resultados: Demencia

<img src="index_files/figure-html/unnamed-chunk-12-1.png" width="648" style="display: block; margin: auto;" />
---
## Resultados: Demencia

<img src="index_files/figure-html/unnamed-chunk-13-1.png" width="648" style="display: block; margin: auto;" />
---
## Resultados: Demencia

<img src="index_files/figure-html/unnamed-chunk-14-1.png" width="648" style="display: block; margin: auto;" />
---
## Resultados: Demencia

<img src="index_files/figure-html/unnamed-chunk-15-1.png" width="648" style="display: block; margin: auto;" />
---
## Resultados: Demencia

<img src="index_files/figure-html/unnamed-chunk-16-1.png" width="648" style="display: block; margin: auto;" />
---
## Resultados: Demencia

<img src="index_files/figure-html/unnamed-chunk-17-1.png" width="648" style="display: block; margin: auto;" />
---

## Conclusión

- Todas las intervenciones disminuyen el riesgo de ACV en 15 años.

- Intervenciones conjuntas disminuyen en mayor % el riesgo de ACV.

- No hay efecto de las intervenciones en el riesgo de demencia y los resultados contradictorios pueden estar influenciados por el **sesgo de supervivencia**.

---

# El mensaje para llevar a casa 

- Tenemos que identificar bien la pregunta que queremos realizar antes de ver los datos.

--

- Generalmente la pregunta a responder permitirá:

  &#x2714;&#xFE0F; Describir

  &#x2714;&#xFE0F; Predecir

  &#x2714;&#xFE0F; Inferir

--

- Si nos interesa **_inferir_**, tenemos que pensar en todas las variables que pueden confundir nuestra asociación principal y utilizar métodos apropiados responder la pregunta.

--

- Al utilizar **_datos longitudinales_** tenemos que tener en cuenta los mecanismos de generación de datos.

---


name: title
class: center, middle
#Gracias!!!#


### Encuentrame en:
<!--html_preserve--><i class="fas  fa-paper-plane " style="color:#011A5E;"></i><!--/html_preserve--></i>&nbsp;palolili@gmail.org</a><br>

<!--html_preserve--><i class="fab  fa-twitter " style="color:#011A5E;"></i><!--/html_preserve--> <a href="http://twitter.com/palolili23"> </i>&nbsp; @palolili23</a><br>

<!--html_preserve--><i class="fab  fa-github " style="color:#011A5E;"></i><!--/html_preserve--> <a href="https://github.com/palolili23"> </i>&nbsp; @palolili23</a><br>


---

## Apendice


---
## Evaluación del modelado de variables


<img src=./stroke.png width="500" height="450"/>
