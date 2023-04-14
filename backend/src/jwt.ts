// import { JWT_SECRET } from './config';
import crypto from 'crypto';
import koaJwt from 'koa-jwt';

export const JWT_SECRET = crypto.randomBytes(20).toString('hex');

export const jwt = koaJwt({
	secret: JWT_SECRET,
});
