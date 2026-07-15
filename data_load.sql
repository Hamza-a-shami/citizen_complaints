INSERT INTO districts (district_name)
SELECT DISTINCT district
FROM raw_complaints
WHERE district IS NOT NULL;

INSERT INTO citizens (citizen_name, contact_number)
SELECT DISTINCT citizen_name, contact_number
FROM raw_complaints
WHERE citizen_name IS NOT NULL;

INSERT INTO departments (department_name)
SELECT DISTINCT department
FROM raw_complaints
WHERE department IS NOT NULL;

INSERT INTO categories (category_name)
SELECT DISTINCT category
FROM raw_complaints
WHERE category IS NOT NULL;

INSERT INTO date_fill (date_filled, day, month, year)
SELECT DISTINCT 
    date_filed::DATE,
    EXTRACT(DAY FROM date_filed::DATE)::INTEGER,
    EXTRACT(MONTH FROM date_filed::DATE)::INTEGER,
    EXTRACT(YEAR FROM date_filed::DATE)::INTEGER
FROM raw_complaints
WHERE date_filed IS NOT NULL;

INSERT INTO complaints (
    complaint_id,
    citizen_id,
    district_id,
    department_id,
    category_id,
    status,
    priority,
    date_id,
    date_resolved,
    satisfaction_score
)
SELECT
    r.complaint_id::INTEGER,
    c.citizen_id,
    d.district_id,
    dep.department_id,
    cat.category_id,
    r.status,
    r.priority,
    df.date_id,
    NULLIF(r.date_resolved, '')::DATE,
    NULLIF(r.satisfaction_score, '')::INTEGER
FROM raw_complaints r
LEFT JOIN citizens c ON r.citizen_name = c.citizen_name AND r.contact_number = c.contact_number
LEFT JOIN districts d ON r.district = d.district_name
LEFT JOIN departments dep ON r.department = dep.department_name
LEFT JOIN categories cat ON r.category = cat.category_name
LEFT JOIN date_fill df ON r.date_filed::DATE = df.date_filled;