--afiliados producción
select
    af.tipo_afiliado,
    af.empresa_pension,
    af.[plan],
    af.sexo as sexo,
    dep.nombre as departamento_atencion,
    mu.nombre as municipio_atencion,
    est.nombre estado,
    div.division,
    af.sexo_identificacion,
    (select TOP 1 nombre from grupos_etarios
     where FLOOR(DATEDIFF(day,fecha_nacimiento ,getdate() ) / 365.2425) >= desde
       and FLOOR(DATEDIFF(day,fecha_nacimiento ,getdate() ) / 365.2425) <= hasta  and grupos_etarios.sexo LIKE CONCAT('%',UPPER(af.sexo),'%')) as grupo_etario,
    COUNT(*) AS total_afiliados  -- Cuenta el número de afiliados en cada grupo
from afiliados af
         INNER JOIN departamentos as dep ON dep.id= af.codigo_departamento_atencion_id
         INNER JOIN municipios as mu ON mu.id=af.codigo_municipio_atencion_id
         INNER JOIN estados as est ON est.id= af.estado_afiliacion_id
         INNER JOIN divisiones as div ON af.divisione_id = div.id
GROUP BY
    af.tipo_afiliado,
    af.empresa_pension,
    af.[plan],
    af.sexo,
    dep.nombre,
    mu.nombre,
    est.nombre,
    div.division,
    af.sexo_identificacion,
    fecha_nacimiento;