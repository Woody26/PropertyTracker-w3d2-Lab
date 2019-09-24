DROP TABLE IF EXISTS property_trackers;

CREATE TABLE property_trackers(
  id SERIAL8 PRIMARY KEY,
  address VARCHAR(255),
  value INT8,
  bedrooms INT2,
  year_built INT4
);
