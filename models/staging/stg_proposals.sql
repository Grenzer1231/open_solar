WITH

raw_proposales AS (
    SELECT
        *
    FROM
        {{ source('raw_proposals', 'raw_proposals') }}
),

null_blanks AS (
    SELECT
        rp.id,
        NULLIF(rp.address, '') AS address,
        NULLIF(rp.state, '') AS state,
        NULLIF(rp.stage::VARCHAR, '') AS stage,
        NULLIF(rp.notes::VARCHAR, '') AS notes,
        NULLIF(rp.created_date::VARCHAR, '') AS created_date,
        NULLIF(rp.modified_date::VARCHAR, '') AS modified_date,
        NULLIF(rp.priority::VARCHAR, '') AS priority,
        NULLIF(rp.country_id::VARCHAR, '') AS country_id,
        NULLIF(rp.org_id::VARCHAR, '') AS org_id,
        NULLIF(rp.proposal_sent_date::VARCHAR, '') AS proposal_sent_date,
        NULLIF(rp.is_lite::VARCHAR, '') AS is_lite
    FROM
        raw_proposales rp
    
),

-- Only standardize states in AU
joined_states AS (
    SELECT
        nb.*,
        CASE
            WHEN cs.state_code IS NULL THEN nb.state
            ELSE cs.state_code
        END AS standardized_state
    FROM
        null_blanks nb
    LEFT JOIN {{ ref('ctl_states') }} cs
        ON
            nb.state = cs.state_name
),

standardize_proposals AS (
    SELECT
        id::BIGINT AS id,
        CASE
            WHEN address IN ('-', '') THEN NULL
            ELSE address
        END AS address,
        UPPER(state) as raw_state,
        UPPER(standardized_state) AS state,
        stage,
        notes,
        created_date::TIMESTAMP AS created_date,
        modified_date::TIMESTAMP AS modified_date,
        priority::INTEGER AS priority,
        country_id::BIGINT AS country_id,
        org_id::BIGINT AS org_id,
        proposal_sent_date::TIMESTAMP AS proposal_sent_date,
        CASE
            WHEN is_lite = 0 THEN FALSE
            WHEN is_lite = 1 THEN TRUE
            ELSE NULL
        END AS is_lite
    FROM
        joined_states
)

SELECT
*
FROM standardize_proposals
