import Router from '@koa/router';
import Group from '../models/group';
import User from '../models/user';

const router = new Router({
	prefix: '/groups',
});

router.get('/', async (ctx, next) => {
	ctx.body = await Group.find();
});

router.get('/:name', async (ctx, next) => {
	const group = await User.findOneBy({
		username: ctx.params.groupname,
	});
	if (group === null) {
		ctx.status = 404;
		return;
	}

	ctx.body = user;
});

router.put('/:username', async (ctx, next) => {
	const user = new User();
	user.username = ctx.params.username;
	user.name = 'John Doe';
	await user.save();
	ctx.body = user;
});

router.delete('/', async (ctx, next) => {
	const users = await User.find();
	ctx.body = await User.remove(users);
});

export default router;