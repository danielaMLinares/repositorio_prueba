select
    rc.tipo_certificado as tipo_certificado,
    rc.created_at as fecha_certificado,
    af.documento,
    div.division
FROM
    reporte_certificados rc
        INNER JOIN afiliados as af ON af.id = rc.afiliado_id
        INNER JOIN  divisiones as div on af.divisione_id = div.id