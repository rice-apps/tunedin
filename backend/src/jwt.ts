import { JWT_SECRET } from './config';

const koaJwt = require('koa-jwt');

module.exports = koaJwt({
	secret: JWT_SECRET,
});
