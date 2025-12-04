WITH

raw_proposales AS (
    SELECT
        *
    FROM
        {{ source('raw_proposals', 'raw_proposals') }}
),

-- Only standardize states in AU
joined_states AS (
    SELECT
        rp.*,
        CASE
            WHEN cs.state_code IS NULL THEN rp.state
            ELSE cs.state_code
        END AS standardized_state
    FROM
        raw_proposales rp
    LEFT JOIN
        {{ ref('ctl_states') }} cs
    ON
        rp.state = cs.state_name
),

standardize_proposals AS (
    SELECT
        id::BIGINT AS id,
        CASE
            WHEN address IN ('-', '') THEN NULL
            ELSE address
        END AS address,
        state as raw_state,
        standardized_state AS state,
        stage,
        notes,
        created_date::TIMESTAMP AS created_date,
        modified_date::TIMESTAMP AS modified_date,
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
