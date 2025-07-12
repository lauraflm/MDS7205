# Exploración de Medicamentos con Grafos de Conocimiento

Este proyecto busca representar y analizar un conjunto complejo de medicamentos, sus efectos, usos y relaciones, mediante grafos de conocimiento. A través de la exploración estructural y el uso de técnicas de Machine Learning, se busca extraer patrones útiles, comunidades farmacológicas y realizar predicciones sobre propiedades clínicas.

## Integrantes

- Laura Maldonado Lagos
- Marcelo Palma Moena
- Profesor: Sebastián Ferrada

## Motivación

El dataset original contiene relaciones entre medicamentos difíciles de explorar con enfoques relacionales, por lo que usar grafos permite una visualización más flexible, consultas complejas y aplicación de modelos avanzados que potencian el análisis clínico. 

La idea es explorar una alternativa útil para personas del área farmacéutica y de la medicina, que les signifique una mejor exploración, conocimiento y comparación de los medicamentos.

## Dataset

Se utilizó el dataset **[250k Medicines Usage, Side Effects and Substitutes](https://www.kaggle.com/datasets/rohitsahoo/250k-medicines-usage-side-effects-and-substitutes)** de Kaggle.

**Para cada medicamento se dispone de:**
- Nombre
- Ingredientes activos
- Clase terapéutica
- Clase química
- Usos 
- Efectos secundarios 
- Sustitutos 
- Indicador de dependencia


##  Preprocesamiento

- Creación de archivos csv para importar a Neo4j:
  - `MEDICAMENTOS_NODOS`
  - `RELACIONES_USOS`
  - `RELACIONES_EFECTOS`
  - `RELACIONES_SUSTITUTOS`

## Objetivos

1. Representar los datos como un grafo de conocimiento.
2. Identificar comunidades estructurales relevantes.
3. Aplicar modelos de Machine Learning para predicción de propiedades.
4. Encontrar alternativas terapéuticas más seguras a través de similitud topológica.


##  Ideas a Futuro

- Ampliar el grafo con propiedades como **formato** y **gramaje**.
- Incorporar nuevas fuentes de datos (interacciones, contraindicaciones).
- Desarrollar una interfaz de búsqueda médica basada en grafos para estudiantes y doctores.


##  Tecnologías

- Python (preprocesamiento, ML)
- Neo4j (modelo de grafos)
- GDS (Graph Data Science)
