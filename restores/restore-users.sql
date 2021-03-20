DROP FUNCTION restore_users();

CREATE OR REPLACE FUNCTION restore_users()
RETURNS VOID
AS $$
BEGIN
    TRUNCATE TABLE public.user;

    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

    INSERT INTO public.user (
        "id",
        "firstName",
        "lastName",
        "email",
        "phoneNumber",
        "birthDate",
        "occupation",
        "vehicleType",
        "vehicleModel",
        "vehicleYear",
        "createdAt",
        "updatedAt",
        "vehicleVIN",
        "vehicleMaker"
    )
    SELECT
        uuid_generate_v4(),
        md5(RANDOM()::text),
        md5(RANDOM()::text),
        CONCAT(md5(RANDOM()::text), '@gmail.com'),
        CONCAT(ROUND(RANDOM() * 100), '-', ROUND(RANDOM() * 100), '-', ROUND(RANDOM() * 1000)),
        TIMESTAMP '1900-01-10 20:00:00' + RANDOM() * (NOW() - TIMESTAMP '1900-01-10 10:00:00'),
        md5(RANDOM()::text),
        (ARRAY['car', 'truck', 'bus'])[ROUND(RANDOM()) + 1],
        CONCAT(md5(RANDOM()::text), ROUND(RANDOM() * 1000)),
        ROUND(RANDOM() * 1000),
        TIMESTAMP '2014-01-10 20:00:00' + RANDOM() * (TIMESTAMP '2014-01-20 20:00:00' - TIMESTAMP '2014-01-10 10:00:00'),
        TIMESTAMP '2014-01-10 20:00:00' + RANDOM() * (TIMESTAMP '2014-01-20 20:00:00' - TIMESTAMP '2014-01-10 10:00:00'),
        uuid_generate_v4(),
        (ARRAY['bmw', 'mercedes', 'volkswagen'])[ROUND(RANDOM()) + 1]
    FROM generate_series(1, 100) s(i);
END;
$$ LANGUAGE 'plpgsql'