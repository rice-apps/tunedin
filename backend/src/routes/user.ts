import Router from '@koa/router';

const router = new Router({
	prefix: '/user',
});

router.get('/', (ctx, next) => {
	ctx.body = {};
});

export default router;
