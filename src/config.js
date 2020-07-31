module.exports = {
  PORT: process.env.PORT || 8000,
  NODE_ENV: process.env.NODE_ENV || 'development',
  DB_URL: process.env.DB_URL
    || 'postgresql://dunder_mifflin@localhost/spaced-repetition',
  TEST_DB_URL: process.env.TEST_DB_URL 
    || 'postgresql://dunder_mifflin@localhost/spaced-repetition-test',
  JWT_SECRET: process.env.JWT_SECRET || 'spaced-rep-secret',
  JWT_EXPIRY: process.env.JWT_EXPIRY || '3h',
};
