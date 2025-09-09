
SELECT *
FROM (
         SELECT DISTINCT
             --es.nombre as estado,
             --cp.created_at,
             --se.nombre as sede,
             ---cp.fecha_solicitada as fecha_solicita,
            --esp.nombre as especialidad,

             --ent.nombre as entidad,
             --c10.codigo_cie10 as cie10
             cp.fecha_hora_inicio AS datetimeingreso,
             p.numero_documento AS Numero_documento,
             EXTRACT(YEAR FROM cp.fecha_hora_inicio) AS año,
             LOWER(CASE EXTRACT(MONTH FROM cp.fecha_hora_inicio)
                       WHEN 1 THEN 'Enero'
                       WHEN 2 THEN 'Febrero'
                       WHEN 3 THEN 'Marzo'
                       WHEN 4 THEN 'Abril'
                       WHEN 5 THEN 'Mayo'
                       WHEN 6 THEN 'Junio'
                       WHEN 7 THEN 'Julio'
                       WHEN 8 THEN 'Agosto'
                       WHEN 9 THEN 'Septiembre'
                       WHEN 10 THEN 'Octubre'
                       WHEN 11 THEN 'Noviembre'
                       WHEN 12 THEN 'Diciembre'
                 END) AS nombre_mes,
             cu.codigo AS cups,
             ci.nombre AS tipo_agenda,
             rep.nombre AS ips_primaria,
             cu.nombre AS consulta,

             CASE
                 WHEN ent.nombre = 'REDVITAL UT' THEN 'Fomag'
                 ELSE ent.nombre
                 END AS entidad_modificada,
             ROW_NUMBER() OVER (
                 PARTITION BY CONCAT(p.numero_documento,EXTRACT(YEAR FROM cp.fecha_hora_inicio))
                 ORDER BY cp.fecha_hora_inicio ASC
                 ) AS cantidad
         FROM
             consultas cp
             left JOIN afiliados p ON cp.afiliado_id = p.id
             left  JOIN reps rep ON rep.id = p.ips_id
             left JOIN agendas ag ON cp.agenda_id = ag.id
             left JOIN citas ci ON ag.cita_id = ci.id
             left JOIN especialidades esp ON esp.id = ci.especialidade_id
             left JOIN consultorios co ON co.id = ag.consultorio_id
             left JOIN sedes se ON se.rep_id = co.rep_id
             left JOIN estados es ON es.id = cp.estado_id
             left JOIN cups cu ON cu.id = cp.cup_id
             left JOIN entidades ent ON ent.id = p.entidad_id
         --left join cie10_afiliados c10a on c10a.consulta_id= cp.id
         --left join cie10s c10 on c10.id= c10a.Cie10_id
         WHERE
             cp.fecha_hora_inicio IS NOT NULL
           AND cp.tipo_consulta_id <> 1
           AND cp.estado_id IN (6, 7, 8, 9, 49)
           AND cu.codigo IS NOT NULL
           AND es.id = 9 -- estado cita atendida
           AND esp.id = 1 -- especialidad medicina general
         AND ci.id IN(1167,64,46,880,1059,21,1086,896,1150,1132,1084,1147,48,1149,81,687,944,1,6,1085,23,1115,84,49,53,80,899,1095,70,62,72,1169,1061,113,203,206,201,785,877,892,890,891,893,979,1040,1096,1118,1141,1145,79,90,253,61,65,59,205,204,415,416,33,67,77,63,1170,69,73,57,87,83,82,86,68,1173,94,66,1171,853,1139,1056,865,902,901,922,845,1117,1060,1093,1092,1091,817,1114,688,1099,848,1094,1087,939,1102,872,816,1018,1057) -- Tipo cita consulat externa
     ) AS subquery
WHERE cantidad = 1
ORDER BY datetimeingreso ASC;