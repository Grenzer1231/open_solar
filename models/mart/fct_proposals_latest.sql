WITH

stg_proposals AS (
    SELECT
        *
    FROM
        {{ ref('stg_proposals') }}
),

latest_proposals AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY modified_date DESC) AS rn
    FROM stg_proposals
)

SELECT
    id,
    address,
    state,
    stage,
    notes,
    created_date,
    modified_date,
    org_id,
    proposal_sent_date,
    is_lite
FROM latest_proposals
WHERE rn = 1
