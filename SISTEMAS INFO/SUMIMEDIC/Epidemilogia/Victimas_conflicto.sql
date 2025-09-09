SELECT distinct
    p.numero_documento as numero_documento,
    p.edad_cumplida as edad,
    p.fecha_nacimiento as fecha_nacimiento,
    cp.fecha_hora_inicio as fecha_atencion,
    EXTRACT(YEAR FROM cp.fecha_hora_inicio) AS año_atencion,  -- Extraer el año
    p.sexo as sexo,
    dep.nombre as departamento_atencion,
    mu.nombre as municipio_atencion,
    ci.nombre as tipo_cita,
    se.nombre as sede_atencion,
    esp.nombre as especialidad,
    rep.nombre as ips_primaria,
    cu.codigo as cups,
    cu.nombre as descripcion_cups,
    ent.nombre as entidad,
    c10.codigo_cie10 as cie10_principal,
    c10.nombre as diagnostico_principal,
    c10b.codigo_cie10 as cie10_relacionado,
    c10b.nombre as dignostico_relacionado,
    concat( p.numero_documento,c10.codigo_cie10,EXTRACT(YEAR FROM cp.fecha_hora_inicio)) as id_año,

    CASE
        WHEN tv.nombre IS null  THEN 'No se identifica como víctima'
        ELSE tv.nombre
        END AS tipo_violencia

FROM consultas cp
         join afiliados p ON cp.afiliado_id = p.id
         join reps rep on rep.id = p.ips_id
         join agendas ag on cp.agenda_id = ag.id
         join citas ci on ag.cita_id = ci.id
         join especialidades esp on esp.id = ci.especialidade_id
         join consultorios co on co.id=ag.consultorio_id
         join sedes se on se.rep_id= co.rep_id
         join estados  es on es.id= cp.estado_id
         join cups cu on cu.id = cp.cup_id
         join entidades ent on ent.id = p.entidad_id
         left join cie10_afiliados c10a on c10a.consulta_id= cp.id
         left join cie10s c10 on c10.id= c10a.Cie10_id
         left join cie10_afiliados c10a1 on c10a1.consulta_id= cp.id
         left join cie10s c10b on c10b.id= c10a1.Cie10_id
         left join municipios as mu on p.municipio_atencion_id=mu.id
         left join departamentos as dep on p.departamento_atencion_id=dep.id
         left join caracterizacion_afiliados as cat on p.id = cat.afiliado_id
         left join tipo_violencias as tv on cat.tipo_violencia_id = tv.id

WHERE cp.fecha_hora_inicio IS NOT NULL
  AND cp.tipo_consulta_id <> 1 -- es decir diferente a transcripción

  AND cp.estado_id =9 -- estado 9 atendido
  AND cu.codigo is not NULL
  AND c10a.esprimario= true
  AND c10a1.esprimario =false  and c10.codigo_cie10  is not null AND tv.id in (2,3,4,5,6) AND cu.codigo IN('890105','890205','890305','890405',
                                                                                                           '890101','890201','890301','890501','890601','890701','944901',
                                                                                                           '890109','890209','890309','890409','944905',
                                                                                                           '890108','890208','890297','890308','890397','890408','890608','943102','944002','944102','944202','944904'
    ) --enfermeria, medicina general ,trabajo social, psicologia


order by cp.fecha_hora_inicio desc;