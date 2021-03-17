DROP FUNCTION get_all_users(integer,integer);

CREATE OR REPLACE FUNCTION get_all_users(user_limit INTEGER, user_offset INTEGER)
RETURNS TABLE (
    id           UUID,
    firstName    VARCHAR,
    lastName     VARCHAR,
    email        VARCHAR,
    phoneNumber  VARCHAR,
    birthDate    DATE,
    occupation   VARCHAR,
    vehicleType  VARCHAR,
    vehicleModel VARCHAR,
    vehicleYear  VARCHAR,
    createdAt    TIMESTAMP,
    updatedAt    TIMESTAMP,
    vehicleVIN   VARCHAR,
    vehicleMaker VARCHAR
)
AS $$
BEGIN
    RETURN QUERY (
        SELECT *
        FROM public.user
        ORDER BY id
        LIMIT user_limit
        OFFSET user_offset
    );
END;
$$ LANGUAGE 'plpgsql'