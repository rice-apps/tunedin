import { JWT_SECRET } from './config';

import koaJwt from 'koa-jwt';

export const jwt = koaJwt({
	secret: JWT_SECRET,
});
