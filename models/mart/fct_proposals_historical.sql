WITH

stg_proposals AS (
    SELECT
        *
    FROM
        {{ ref('stg_proposals') }}
)

SELECT
    CONCAT(id::VARCHAR, org_id::VARCHAR, modified_date::VARCHAR) AS surrogate_key,
    id,
    address,
    state,
    stage,
    notes,
    created_date,
    modified_date,
    priority,
    country_id,
    org_id,
    proposal_sent_date,
    is_lite
FROM stg_proposals
