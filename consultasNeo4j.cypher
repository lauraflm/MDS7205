// ------------- 1. Proyección del grafo  -------------
CALL gds.graph.project(
  'Drugs',
  {
    MEDICAMENTO: {},
    USO: {},
    EFECTO_SECUNDARIO: {}
  },
  {
    SE_UTILIZA_PARA: {type: 'SE_UTILIZA_PARA', orientation: 'UNDIRECTED'},
    TIENE_EFECTO: {type: 'TIENE_EFECTO', orientation: 'UNDIRECTED'},
    SUSTITUIDO_POR: {type: 'SUSTITUIDO_POR', orientation: 'UNDIRECTED'}
  }
);

// ------------- 2. Análisis de comunidades (Louvain) -------------
MATCH (m:MEDICAMENTO)
RETURN m.comunidadLouvain AS comunidad, count(*) AS cantidad
ORDER BY cantidad DESC;

// ------------- 3. Generación de embeddings con fastRP -------------
CALL gds.fastRP.write(
  'Drugs',
  {
    embeddingDimension: 128,
    writeProperty: 'embedding',
    randomSeed: 22
  }
);

// ------------- 4. Top 10 medicamentos con más efectos secundarios -------------
MATCH (m:MEDICAMENTO)-[:TIENE_EFECTO]->(e:EFECTO_SECUNDARIO)
RETURN 
  m.name AS medicamento, 
  count(e) AS num_efectos, 
  m.`Therapeutic Class` AS clase
ORDER BY num_efectos DESC
LIMIT 10;

// ------------- 5. PageRank de los nodos  -------------
CALL gds.pageRank.stream('Drugs')
YIELD nodeId, score
RETURN 
  gds.util.asNode(nodeId).name AS medicamento, 
  score
ORDER BY score DESC
LIMIT 10;

//------------- 6. Betweenness centrality en efectos secundarios -------------
CALL gds.betweenness.stream('Drugs')
YIELD nodeId, score
WITH gds.util.asNode(nodeId) AS n, score
WHERE 'EFECTO_SECUNDARIO' IN labels(n)
RETURN 
  n.name AS efecto_secundario, 
  score
ORDER BY score DESC
LIMIT 5;

// ------------- 7. Obtener el nodeId de un medicamento por nombre -------------
MATCH (m:MEDICAMENTO {name: "balila 25mg capsule"})
RETURN id(m) AS nodeId;

// -------------
 8. Similaridad de nodos: top 10 similares al nodo 25719 (balila 25mg capsule) -------------
CALL gds.nodeSimilarity.filtered.stream('Drugs', {
  sourceNodeFilter: 25719,
  topK: 10
})
YIELD node1, node2, similarity
WITH gds.util.asNode(node2) AS similar, similarity
OPTIONAL MATCH (similar)-[:TIENE_EFECTO]->(e:EFECTO_SECUNDARIO)
WITH 
  similar.name AS medicamento_similar,
  similarity,
  count(e) AS num_efectos,
  similar.`Therapeutic Class` AS therapeutic_class
ORDER BY num_efectos ASC
RETURN 
  medicamento_similar, 
  similarity, 
  num_efectos, 
  therapeutic_class;
