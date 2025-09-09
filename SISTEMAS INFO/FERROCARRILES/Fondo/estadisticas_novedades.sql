select af.id,
                rnd.created_at as fecha_solicitud,
                rn.fecha_inicio_novedad as fecha_novedad,
                div.division as division,
                de.nombre,
                mu.nombre,
                rnd.valor_nuevo,
                case
                    when rnd.campo_modificado='codigo_municipio_atencion_id' then 'cambios punto atencion'
                    when rnd.campo_modificado='tipo_documento' then 'cambios datos de identificacion'
                    when rnd.campo_modificado='documento' then 'cambios datos de identificacion'
                    when rnd.campo_modificado='tipo_afiliado' then 'cambio tipo de afiliado'
                    when rnd.campo_modificado = 'estado_afiliacion_id' and rnd.valor_nuevo = '2' then 'fallecidos'
                    when rnd.campo_modificado = 'estado_afiliacion_id' and rnd.valor_nuevo = '1' then 'aplicaciones ingresos'
                    when rnd.campo_modificado = 'estado_afiliacion_id' and rnd.valor_nuevo = '3' then 'traslados a otra EPS'
                    when rnd.campo_modificado = 'estado_afiliacion_id' and rnd.valor_nuevo = '5' then 'Retiros'
                else ''
                    end as novedad
                     from registro_novedad_detalles rnd
                     LEFT JOIN registro_novedades as rn ON rnd.registro_novedad_id = rn.id
                     LEFT JOIN  afiliados as af on rn.afiliado_id = af.id
                     LEFT JOIN  divisiones as div on af.divisione_id = div.id
                     LEFT JOIN  municipios as mu on mu.id = af.codigo_municipio_atencion_id
                     LEFT JOIN  departamentos as de on mu.departamento_id = de.id
                     where rnd.campo_modificado IN( 'codigo_municipio_atencion_id','tipo_documento','documento','tipo_afiliado','estado_afiliacion_id');