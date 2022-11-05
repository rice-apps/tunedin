import Router from '@koa/router';
import User from '../models/user';

const router = new Router({
	prefix: '/user',
});

router.get('/', (ctx, next) => {
	ctx.body = {};
});

router.get('/:username', async (ctx, next) => {
	return User.findOneBy({
		username: ctx.params.username,
	});
});

export default router;
