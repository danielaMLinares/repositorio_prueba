
select
    rn.tipo_solicitud,
    rn.fecha_inicio_novedad,
    rn.created_at,
    es.nombre as estado,
    u1.email,
    tu.nombre as tipo_usuario_audita,
    ct.nombre as causales_traslados,
    u2.email as usuario_solicita,
    tu1.nombre as tipo_usuario_solicita,
    rnd.campo_modificado,
    de.nombre as departamento,
    mu.nombre as municipio,
    dv.division,
    dv.empresa
from registro_novedades rn
inner join estados  as es on rn.estado_id = es.id
left join dbo.users u1 on rn.usuario_auditor = u1.id
left join tipo_usuarios as tu on u1.tipo_usuario_id = tu.id
left join causales_traslados as ct on rn.causales_traslado_id = ct.id
left join dbo.users u2 on rn.usuario_realiza = u2.id
left join tipo_usuarios as tu1 on u1.tipo_usuario_id = tu1.id
left  join registro_novedad_detalles as rnd on rn.id = rnd.registro_novedad_id
left join  afiliados as af on rn.afiliado_id = af.id
left join departamentos as de on af.codigo_departamento_atencion_id = de.id
left join municipios as mu on af.codigo_municipio_atencion_id = mu.id
left join divisiones as dv on af.divisione_id = dv.id;