require("dotenv").config();

const config = {
    dev: process.env.NODE_ENV !== "production",
    port: process.env.PORT || 5500,
    secret: process.env.COOKIE_SECRET || 'secret',
    secretToken: process.env.ACCESS_TOKEN_SECRET || 'secret',
    sentryDns: process.env.SENTRY_DNS,
    sentryId: process.env.SENTRY_ID,
    database: {
        host: process.env.MYSQL_HOST || '',
        user: process.env.MYSQL_USER || '',
        password: process.env.MYSQL_PASS || '',
        database: process.env.MYSQL_DB || '',
    }
};

module.exports = config;