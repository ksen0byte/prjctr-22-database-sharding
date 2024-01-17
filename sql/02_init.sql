CREATE OR REPLACE FUNCTION create_and_fill_table() RETURNS void AS $$
DECLARE
    i INT;
BEGIN
    -- Create a distributed table
    CREATE TABLE IF NOT EXISTS example_table (
        id SERIAL PRIMARY KEY,
        value TEXT
    );

    -- Distribute the table in Citus
    -- PERFORM create_distributed_table('example_table', 'id');

    -- Initialize the counter
    i := 0;

    -- Insert a million rows
    WHILE i < 1000000 LOOP
        INSERT INTO example_table (value) VALUES ('Sample Data ' || i::TEXT);
        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Call the function to initialize
SELECT  create_and_fill_table();

