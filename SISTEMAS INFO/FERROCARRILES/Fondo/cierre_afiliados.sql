
select
    af.empresa_pension,
    mu.nombre AS municipio_atención,
    est.nombre AS estado_afiliación,
    af.estado_afiliacion_id,
    af.sexo AS sexo,
    dep.nombre AS departamento_atención,
    af.edad_cumplida AS edad_cumplidad,
    af.tipo_afiliado,
    mu.zona_prestador,
    af.fecha_cierre_base,
    af.fecha_fallecimientos,
    DIV.division,
    COUNT(*) AS total_afiliados
FROM cierre_afiliados AS af
         INNER JOIN  municipios AS mu ON mu.id= af.codigo_municipio_atencion_id
         INNER JOIN estados AS est ON est.id = af.estado_afiliacion_id
         INNER JOIN departamentos AS dep ON dep.id= af.codigo_departamento_atencion_id
         INNER JOIN divisiones AS DIV ON af.divisione_id = DIV.id
GROUP BY
    af.empresa_pension,
    mu.nombre,
    est.nombre,
    af.estado_afiliacion_id,
    af.sexo,
    dep.nombre,
    af.edad_cumplida,
    af.tipo_afiliado,
    mu.zona_prestador,
    af.fecha_cierre_base,
    af.fecha_fallecimientos,
    DIV.division;

