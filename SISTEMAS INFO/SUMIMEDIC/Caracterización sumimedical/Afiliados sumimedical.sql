SELECT
    af.sexo AS sexo,
    af.edad_cumplida,
    de.nombre AS departamento,
    mu.nombre AS municipio,
    re.nombre AS IPS,
    es.nombre AS estado,
    af.discapacidad AS discapacidad,
    af.grado_discapacidad AS grado_discapacidad,
    ta.nombre AS tipo_afiliado,
    af.fecha_nacimiento,
    af.fecha_afiliacion,
    CONCAT(de.codigo_dane, mu.codigo_dane) AS ubicacion,
    ent.nombre AS entidad,
    COUNT(*) AS total_registros
FROM afiliados AS af
         INNER JOIN departamentos AS de ON de.id = af.departamento_atencion_id
         INNER JOIN municipios AS mu ON mu.id = af.municipio_atencion_id
         INNER JOIN reps AS re ON re.id = af.ips_id
         INNER JOIN prestadores AS p ON re.prestador_id = p.id
         INNER JOIN estados AS es ON es.id = af.estado_afiliacion_id
         INNER JOIN tipo_afiliados AS ta ON ta.id = af.tipo_afiliado_id
         INNER JOIN entidades AS ent ON ent.id = af.entidad_id
WHERE de.id IN (1,12,9,18,21) AND p.nit = '900033371' AND af.estado_afiliacion_id = 1 AND af.entidad_id = 1
GROUP BY
    af.sexo,
    af.edad_cumplida,
    de.nombre,
    mu.nombre,
    re.nombre,
    es.nombre,
    ta.nombre,
    af.discapacidad,
    af.grado_discapacidad,
    af.fecha_nacimiento,
    af.fecha_afiliacion,
    de.codigo_dane,
    mu.codigo_dane,
    ent.nombre

UNION ALL

SELECT
    af.sexo AS sexo,
    af.edad_cumplida,
    de.nombre AS departamento,
    mu.nombre AS municipio,
    re.nombre AS IPS,
    es.nombre AS estado,
    af.discapacidad AS discapacidad,
    af.grado_discapacidad AS grado_discapacidad,
    ta.nombre AS tipo_afiliado,
    af.fecha_nacimiento,
    af.fecha_afiliacion,
    CONCAT(de.codigo_dane, mu.codigo_dane) AS ubicacion,
    ent.nombre AS entidad,
    COUNT(*) AS total_registros
FROM afiliados AS af
         INNER JOIN departamentos AS de ON de.id = af.departamento_atencion_id
         INNER JOIN municipios AS mu ON mu.id = af.municipio_atencion_id
         INNER JOIN reps AS re ON re.id = af.ips_id
         INNER JOIN prestadores AS p ON re.prestador_id = p.id
         INNER JOIN estados AS es ON es.id = af.estado_afiliacion_id
         INNER JOIN tipo_afiliados AS ta ON ta.id = af.tipo_afiliado_id
         INNER JOIN entidades AS ent ON ent.id = af.entidad_id
WHERE af.estado_afiliacion_id = 1 AND af.entidad_id = 3
GROUP BY
    af.sexo,
    af.edad_cumplida,
    de.nombre,
    mu.nombre,
    re.nombre,
    es.nombre,
    ta.nombre,
    af.discapacidad,
    af.grado_discapacidad,
    af.fecha_nacimiento,
    af.fecha_afiliacion,
    de.codigo_dane,
    mu.codigo_dane,
    ent.nombre;