
SELECT *
FROM (
         SELECT DISTINCT
             --e.nombre as estado,
             --cp.created_at,
             --C10.Codigo_CIE10 AS cie10
             --cp.fecha_solicita,
             --se.Nombre as sede,
             -- es.Nombre as especialidad,
             --P.Edad_Cumplida
             cp.datetimeingreso AS fecha_atención,
             p.Num_Doc AS numero_documento,
             YEAR(cp.datetimeingreso) AS año,
             FORMAT(cp.datetimeingreso, 'MMMM', 'es-ES') AS nombre_mes,
             c.codigo AS cups,
             ta.name AS tipo_agenda,
             sed.Nombre AS ips_primaria,
             c.nombre AS consulta,
             CASE
                 WHEN ent.nombre = 'REDVITAL UT' THEN 'Fomag'
                 ELSE ent.nombre
                 END AS entidad_modificada,
             --CONCAT(p.Num_Doc, FORMAT(cp.datetimeingreso, 'MMMM', 'es-ES'), YEAR(cp.datetimeingreso)) AS id_primera_vez,
             ROW_NUMBER() OVER (PARTITION BY CONCAT(p.Num_Doc,YEAR(cp.datetimeingreso)) ORDER BY cp.datetimeingreso ASC) AS cantidad        FROM
             cita_paciente cp
                 LEFT JOIN pacientes p ON cp.paciente_id = p.id
                 LEFT JOIN sedeproveedores sed ON sed.id = p.IPS
                 LEFT JOIN estados e ON e.id = cp.Estado_id
                 LEFT JOIN citas ci ON cp.Cita_id = ci.id
                 LEFT JOIN agendas ag ON ci.Agenda_id = ag.id
                 LEFT JOIN consultorios co ON co.id = ag.Consultorio_id
                 LEFT JOIN sedes se ON se.id = co.Sede_id
                 LEFT JOIN especialidade_tipoagenda et ON et.id = ag.Especialidad_id
                 LEFT JOIN especialidades es ON es.id = et.Especialidad_id
                 LEFT JOIN tipo_agendas ta ON cp.actividad_id = ta.id
                 LEFT JOIN cups c ON cp.Cup_id = c.id
                 LEFT JOIN entidades ent ON ent.id = p.entidad_id
         --LEFT join cie10pacientes c10p on c10p.Citapaciente_id= cp.id
         --LEFT join cie10s c10 on c10.id= c10p.Cie10_id
         WHERE
             cp.datetimeingreso IS NOT NULL
           AND cp.Tipocita_id <> 1 -- 1 es transcripción
           AND cp.estado_id IN (6, 9, 12, 45)
           AND c.Codigo IS NOT NULL
           AND e.id = 9 -- estado cita atendida
           AND es.id = 1 -- especialidad medicina general
           AND p.Edad_Cumplida >= 15
           AND c.codigo IN('890201','890301')
           AND ta.id in(1,134,383,477,503,504,545,638,656
             ) -- tipo consulta externa
     ) AS subquery
WHERE cantidad = 1
ORDER BY fecha_atención ASC;
