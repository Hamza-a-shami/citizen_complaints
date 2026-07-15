CREATE TABLE districts (
    district_id SERIAL PRIMARY KEY,
    district_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE citizens (
    citizen_id SERIAL PRIMARY KEY,
    citizen_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20)
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE date_fill (
    date_id SERIAL PRIMARY KEY,
    date_filled DATE NOT NULL UNIQUE,
    day INTEGER NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL
);

-- Fact table

CREATE TABLE complaints (
    complaint_id INTEGER PRIMARY KEY,
    citizen_id INTEGER NOT NULL,
    district_id INTEGER NOT NULL,
    department_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    status VARCHAR(20) NOT NULL,
    priority VARCHAR(10) NOT NULL,
    date_id INTEGER NOT NULL,
    date_resolved DATE,
    satisfaction_score INTEGER,

    FOREIGN KEY (citizen_id) REFERENCES citizens(citizen_id),
    FOREIGN KEY (district_id) REFERENCES districts(district_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (date_id) REFERENCES date_fill(date_id)
);

-- Raw table for CSV dump (data lake)
CREATE TABLE raw_complaints (
    complaint_id VARCHAR(10),
    citizen_name VARCHAR(200),
    district VARCHAR(100),
    department VARCHAR(100),
    category VARCHAR(100),
    priority VARCHAR(10),
    status VARCHAR(20),
    date_filed VARCHAR(20),
    date_resolved VARCHAR(20),
    satisfaction_score VARCHAR(10),
    contact_number VARCHAR(20)
);