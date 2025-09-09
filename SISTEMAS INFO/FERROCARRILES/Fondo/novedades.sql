SELECT
    rn.tipo_solicitud,
    rn.tipo_novedad,
    rn.fecha_inicio_novedad,
    rn.created_at,
    es.nombre AS estado,
    af.empresa_pension AS empresa_pension,
    dep.nombre as departamento
FROM registro_novedades rn
         LEFT JOIN estados AS es ON es.id = rn.estado_id
         LEFT JOIN afiliados AS af ON af.id = rn.afiliado_id
         LEFT JOIN departamentos AS dep ON dep.id= af.codigo_departamento_atencion_id;