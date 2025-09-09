WITH CTE AS (
    SELECT
        ca.fecha_fallecimientos AS fecha_fallecimiento,
        ca.documento AS documento,
        ca.empresa_pension AS empresa,
        dep.nombre AS departamento,
        ca.tipo_afiliado AS tipo_afiliado,
        div.division as divison,
        ROW_NUMBER() OVER (PARTITION BY ca.documento ORDER BY ca.fecha_fallecimientos DESC) AS rn
    FROM cierre_afiliados ca
             LEFT JOIN departamentos dep ON dep.id = ca.codigo_departamento_atencion_id
             LEFT JOIN divisiones AS div ON ca.divisione_id = div.id
    WHERE ca.fecha_fallecimientos IS NOT NULL
)

SELECT
    fecha_fallecimiento,
    documento,
    empresa,
    departamento,
    tipo_afiliado,
    divison
FROM CTE
WHERE rn = 1;