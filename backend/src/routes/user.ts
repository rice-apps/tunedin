import Router from '@koa/router';
import User from '../models/user';

const router = new Router({
	prefix: '/users',
});

router.get('/', async (ctx, next) => {
	ctx.body = await User.find();
});

router.get('/:username', async (ctx, next) => {
	const user = await User.findOneBy({
		username: ctx.params.username,
	});
	if (user === null) {
		ctx.status = 404;
		return;
	}

	ctx.body = user;
});

router.put('/:username', async (ctx, next) => {
	const user = new User();
	user.username = ctx.params.username;
	user.displayname = 'John Doe';
	await user.save();
	ctx.body = user;
});

router.delete('/', async (ctx, next) => {
	const users = await User.find();
	ctx.body = await User.remove(users);
});

export default router;
